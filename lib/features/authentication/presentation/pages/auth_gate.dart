import 'package:emergency_allergy_app/features/authentication/presentation/pages/login_or_register_page.dart';
import 'package:emergency_allergy_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen(selectedIndex: 0);
          }

          else {
            return const LoginOrRegister();
          }
        }
      ),
    );
  }
}

// TODO: Biometric login
// class AuthGate extends StatelessWidget {
//   const AuthGate({super.key});

//   static LocalAuthentication auth = LocalAuthentication();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return FutureBuilder(
//               future: auth.authenticate(
//                   localizedReason: 'Please authenticate to show app.'),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Text('loading');
//                 }

//                 if (snapshot.hasError) {
//                   return Text(snapshot.error!.toString());
//                 }

//                 return const HomeScreen(selectedIndex: 0);
//               },
//             );
//           } else {
//             return const LoginOrRegister();
//           }
//         },
//       ),
//     );
//   }
// }
