import 'package:emergency_allergy_app/components/custom_list_tile.dart';
import 'package:emergency_allergy_app/components/list_view_seperator.dart';
import 'package:emergency_allergy_app/models/emergency_contact.dart';
import 'package:emergency_allergy_app/models/emergency_number.dart';
import 'package:emergency_allergy_app/services/firestore_service.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:emergency_allergy_app/utils/phone_number_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_symbols_icons/symbols.dart';

class EmergencyContactsScreen extends StatefulWidget {
  final int openIndex;
  final bool openedDirectly;
  const EmergencyContactsScreen(
      {super.key, this.openIndex = 0, this.openedDirectly = false});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  void deleteContact(EmergencyContact contact) {
    setState(() {});

    FirestoreService.deleteEmergencyContact(contact.id!);
  }

  void deleteNumber(EmergencyNumber contact) {
    setState(() {});

    FirestoreService.deleteEmergencyNumber(contact.id!);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.openIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Emergency Contacts',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: widget.openedDirectly,
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.onPrimary,
            unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
            dividerColor: Theme.of(context).colorScheme.secondary,
            indicatorColor: Theme.of(context).colorScheme.tertiary,
            tabs: const [
              Tab(
                text: 'Emergency Contacts',
              ),
              Tab(
                text: 'Emergency Numbers',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
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
                  separatorBuilder: (context, index) =>
                      const ListViewSeperator(),
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        extentRatio: .25,
                        children: [
                          SlidableAction(
                            icon: Symbols.delete,
                            label: 'Delete',
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiary,
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
            FutureBuilder(
              future: FirestoreService.getEmergencyNumbers(),
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
                    child: Text('Emergency numbers will appear here'),
                  );
                }

                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) =>
                      const ListViewSeperator(),
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        extentRatio: .25,
                        children: [
                          SlidableAction(
                            icon: Symbols.call,
                            label: 'Call',
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHigh,
                            onPressed: (context) =>
                                PhoneNumberUtils.callPhoneNumber(
                              snapshot.data![index].phoneNumber,
                            ),
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        extentRatio: .25,
                        children: [
                          SlidableAction(
                            icon: Symbols.delete,
                            label: 'Delete',
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiary,
                            onPressed: (context) => deleteNumber(
                              snapshot.data![index],
                            ),
                          )
                        ],
                      ),
                      child: InkWell(
                        onTap: () => PhoneNumberUtils.callPhoneNumber(
                          snapshot.data![index].phoneNumber,
                        ),
                        child: CustomListTile(
                          title: snapshot.data![index].name,
                          subtitle:
                              '(${snapshot.data![index].phoneNumber.substring(0, 3)}) ${snapshot.data![index].phoneNumber.substring(3, 6)}-${snapshot.data![index].phoneNumber.substring(6, 10)}',
                          trailing: '',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        floatingActionButton: !widget.openedDirectly ? Builder(
          builder: (context) {
            // index = DefaultTabController.of(context).index;
            return FloatingActionButton(
              onPressed: () {
                final index = DefaultTabController.of(context).index;

                index == 0
                    ? showAddEmergencyContactModal(context)
                    : showAddEmergencyNumberModal(context);
              },
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Symbols.add),
            );
          },
        ) : null,
      ),
    );
  }
}
