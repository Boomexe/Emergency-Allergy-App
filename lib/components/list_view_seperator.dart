import 'package:flutter/material.dart';

class ListViewSeperator extends StatelessWidget {
  final double? height;
  const ListViewSeperator({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 1,
        height: height?? 1,
      ),
    );
  }
}
