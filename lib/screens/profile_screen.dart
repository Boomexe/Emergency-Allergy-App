import 'package:emergency_allergy_app/components/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                // backgroundImage: ,
                backgroundColor: Colors.red,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'First Name'),
              readOnly: true,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Last Name'),
              readOnly: true,
            ),
            InputDatePickerFormField(
              fieldLabelText: 'Birthdate',
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Weight (lbs)',
              ),
              keyboardType: TextInputType.number,
              readOnly: true,
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Height (feet)',
                  ),
                  keyboardType: TextInputType.number,
                  readOnly: true,
                )),
                const SizedBox(width: 10),
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Height (inches)',
                  ),
                  keyboardType: TextInputType.number,
                  readOnly: true,
                )),
              ],
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Allergies'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    
                  },
                )
              ],
            )
          ],
        )),);
  }
}
