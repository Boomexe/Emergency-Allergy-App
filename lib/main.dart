import 'dart:convert';

import 'package:emergency_allergy_app/auth/auth_gate.dart';
import 'package:emergency_allergy_app/screens/message_screen.dart';
import 'package:emergency_allergy_app/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:emergency_allergy_app/themes/dark_theme.dart';
import 'package:emergency_allergy_app/themes/light_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:emergency_allergy_app/firebase_options.dart';

// todo: add google-services.json and GoogleService-Info.plist to gitignore

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('Notification recieved in background...');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.init();
  await NotificationService.localNotificationInit();

  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('Bg notification tapped');
      navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) => const MessageScreen(),
          settings: RouteSettings(arguments: message)));
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      String payloadData = jsonEncode(message.data);
      print('Recieved message in foreground');

      if (message.notification != null) {
        NotificationService.showSimpleNotificaiton(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData,
        );
      }
    }
  });

  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print('Launched from terminated state');
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => const MessageScreen(),
          settings: RouteSettings(arguments: message),
        ),
      );
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;

  void onUpdateIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Allergy Emergency',
      theme: lightTheme,
      darkTheme: darkTheme,
      navigatorKey: navigatorKey,
      home: const AuthGate(),
    );
  }
}
