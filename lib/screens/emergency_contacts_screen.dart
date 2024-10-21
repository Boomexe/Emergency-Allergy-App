import 'package:emergency_allergy_app/components/custom_list_tile.dart';
import 'package:emergency_allergy_app/components/list_view_seperator.dart';
import 'package:emergency_allergy_app/models/emergency_contact.dart';
import 'package:emergency_allergy_app/services/firestore_service.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  void deleteContact(EmergencyContact contact) {
    setState(() {});

    FirestoreService.deleteEmergencyContact(contact.id!);
  }

  Future<void> test() {
    print('hi');
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Emergency Contacts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: FirestoreService.getEmergencyContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error retrieving data: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Emergency contacts will appear here'),
            );
          }

          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => const ListViewSeperator(),
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      icon: Icons.delete,
                      label: 'Delete',
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      onPressed: (context) => deleteContact(
                        snapshot.data![index],
                      ),
                    )
                  ],
                ),
                child: FutureBuilder(
                    future: FirestoreService.getNameFromUserId(
                        snapshot.data![index].contactId),
                    builder: (context, s) {
                      return CustomListTile(
                        title: s.data ?? 'Could not find user',
                        subtitle: snapshot.data![index].contactId,
                        trailing: '',
                      );
                    }),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddEmergencyContactModal(context),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
