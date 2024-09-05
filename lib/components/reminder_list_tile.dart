import 'package:flutter/material.dart';

class ReminderListTile extends StatelessWidget {
  const ReminderListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          '12:00 AM',
          style: TextStyle(
              color:
                  Theme.of(context).colorScheme.onPrimary),
        ),
        subtitle: Text(
          'Every Sat, Sun, Mon, Tue, Wed, and Fri',
          style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSecondary),
        ),
        // isThreeLine: true,
        trailing: Wrap(
          children: [
            Text(
              'Off',
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary),
            ),
            const SizedBox(width: 3),
            Icon(
              Icons.arrow_forward,
              size: 20,
              color:
                  Theme.of(context).colorScheme.onSecondary,
            )
          ],
        ),
      ),
    );
  }
}