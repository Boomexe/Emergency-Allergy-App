import 'package:emergency_allergy_app/components/custom_list_tile.dart';
import 'package:emergency_allergy_app/components/detail_card.dart';
import 'package:emergency_allergy_app/models/allergy.dart';
import 'package:emergency_allergy_app/models/medication.dart';
import 'package:emergency_allergy_app/screens/allergy_screen.dart';
import 'package:emergency_allergy_app/services/firestore.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:flutter/material.dart';

class AllergyDetails extends StatefulWidget {
  final Allergy allergy;
  const AllergyDetails({super.key, required this.allergy});

  @override
  State<AllergyDetails> createState() => _AllergyDetailsState();
}

class _AllergyDetailsState extends State<AllergyDetails> {
  late Future<List<Medication>> medicationsFuture;

  @override
  void initState() {
    super.initState();
    medicationsFuture =
        FirestoreService.getMedicationsFromIds(widget.allergy.medicationIds);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.allergy.name} Allergy Details',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
            TextButton(
              onPressed: () async => showModal(
                  context,
                  CreateAllergy(
                      medications: await FirestoreService.getMedications(),
                      allergyToEdit: widget.allergy)),
              child: Text('Edit',
                  style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerLow)),
            ),
          ],
        ),
        widget.allergy.description.isNotEmpty ? Text(
          widget.allergy.description,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ) : Container(),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DetailCard(
              width: 150,
              color: Theme.of(context).colorScheme.surfaceContainer,
              textColor: Theme.of(context).colorScheme.onPrimary,
              title:
                  'Type: ${widget.allergy.type.name[0].toUpperCase()}${widget.allergy.type.name.substring(1)}',
              icon: Icons.medical_information,
            ),
            DetailCard(
              width: 150,
              color: Theme.of(context).colorScheme.tertiary,
              textColor: Theme.of(context).colorScheme.onTertiary,
              title:
                  'Severity: ${widget.allergy.severity.name[0].toUpperCase()}${widget.allergy.severity.name.substring(1)}',
              icon: Icons.priority_high,
            ),
          ],
        ),
        const SizedBox(height: 25),
        FutureBuilder(
            future: medicationsFuture,
            builder: (c, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }

              if (snapshot.hasError) {
                return Container();
              }

              return Text(
                snapshot.data!.isNotEmpty ? 'Medications' : 'No Medications',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary),
              );
            }),
        FutureBuilder(
          future: medicationsFuture,
          builder: (c, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (c, index) {
                Medication medication = snapshot.data![index];
                return CustomListTile(
                  title: medication.name,
                  subtitle: medication.note,
                  trailing: medication.dosage,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
