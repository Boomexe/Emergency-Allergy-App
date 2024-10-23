import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/components/medication_reminder_tile.dart';
import 'package:emergency_allergy_app/models/medication.dart';
import 'package:emergency_allergy_app/screens/settings_screen.dart';
import 'package:emergency_allergy_app/services/firestore_service.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:emergency_allergy_app/utils/reminder_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void emergency() async {
    setState(() {
      FirestoreService.setUserStatus(true);
    });
  }

  void cancelEmergency() {
    showSnackBar(context, 'Cancelled ongoing emergency');
    setState(() {
      FirestoreService.setUserStatus(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    String? userName = FirebaseAuth.instance.currentUser?.displayName;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Welcome', style: TextStyle(fontSize: 24)),
            if (userName != null)
              Text(
                ', ${userName.split(' ')[0]}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              )
            else
              const Text(
                '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            ),
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: FirestoreService.getUserStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return FormButton(
                    onTap: () {},
                    text: 'Having a medical emergency?',
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    verticalPadding: 25,
                  );
                }

                if (snapshot.hasError) {
                  return FormButton(
                    onTap: () {},
                    text: 'Error: Could not retrieve user status.',
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    verticalPadding: 25,
                  );
                }

                return FormButton(
                  onTap: () => snapshot.data! ? cancelEmergency() : emergency(),
                  text: snapshot.data!
                      ? 'Cancel emergency.'
                      : 'Having a medical emergency?',
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  verticalPadding: 25,
                );
              },
            ),
            const SizedBox(height: 50),
            const Text('Upcoming Medications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            FutureBuilder(
              future: FirestoreService.getMedications(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 150,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return SizedBox(
                    height: 150,
                    child: Center(
                      child: Text('Error retrieving data: ${snapshot.error}'),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SizedBox(
                    height: 150,
                    child: Center(
                      child: Text('No upcoming medications today.'),
                    ),
                  );
                }

                List<Map<Medication, int>>
                    filteredMedicationsWithReminderIndex = snapshot.data!
                        .expand((medication) {
                          return List.generate(medication.reminders.length,
                              (index) => {medication: index});
                        })
                        .where(
                          (e) => e.keys.first.reminders[e.values.first].days
                              .contains(
                            ReminderUtils.daysBeginningWithMonday[
                                DateTime.now().weekday - 1],
                          ),
                        )
                        .where(
                          (e) => ReminderUtils.isAfterNow(
                            e.keys.first.reminders[e.values.first].time,
                          ),
                        )
                        .toList()
                      ..sort(
                        (a, b) => ReminderUtils.minutesSinceMidnight(
                          a.keys.first.reminders[a.values.first].time,
                        ).compareTo(
                          ReminderUtils.minutesSinceMidnight(
                            b.keys.first.reminders[b.values.first].time,
                          ),
                        ),
                      );

                if (filteredMedicationsWithReminderIndex.isEmpty) {
                  return const SizedBox(
                    height: 150,
                    child: Center(
                      child: Text('No upcoming medications today.'),
                    ),
                  );
                }

                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: filteredMedicationsWithReminderIndex.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => showMedicationInformationSheet(
                            context,
                            filteredMedicationsWithReminderIndex[index]
                                .keys
                                .first),
                        child: MedicationReminderTile(
                          medication:
                              filteredMedicationsWithReminderIndex[index]
                                  .keys
                                  .first,
                          reminderIndex:
                              filteredMedicationsWithReminderIndex[index]
                                  .values
                                  .first,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
