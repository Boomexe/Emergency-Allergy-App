import 'package:emergency_allergy_app/screens/emergency_contacts_screen.dart';
import 'package:emergency_allergy_app/utils/phone_number_utils.dart';
import 'package:flutter/material.dart';

class CallEmergencyNumberModal extends StatefulWidget {
  const CallEmergencyNumberModal({super.key});

  @override
  State<CallEmergencyNumberModal> createState() =>
      _CallEmergencyNumberModalState();
}

class _CallEmergencyNumberModalState extends State<CallEmergencyNumberModal> {
  void callEmergencyNumberButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmergencyContactsScreen(
          openIndex: 1,
          openedDirectly: true,
        ),
      ),
    );
  }

  void callEmergencyServicesButtonPressed() {
    print('hi');
    PhoneNumberUtils.callEmergencyServices();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.1,
      width: 500,
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 100,
                child: TextButton(
                  onPressed: () => callEmergencyNumberButtonPressed(),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: Text(
                    'Call an Emergency Number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 100,
                child: TextButton(
                  onPressed: () => callEmergencyServicesButtonPressed(),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: Text(
                    'Call Emergency Services',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
