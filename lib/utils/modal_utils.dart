import 'package:flutter/material.dart';

Future<void> showModal(BuildContext context, Widget content) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: content,
          ));
}

// OPTION 2 FOR EXTRA MEDICATION DETAILS
void showDraggableScrollableSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.3,
        minChildSize: 0.25,
        maxChildSize: 0.5,
        builder: (_, ScrollController scrollController) {
          return Container(
            color: Colors.white,
            child: ListView.builder(itemBuilder: (_, i) => ListTile(title: Text('Item $i')), controller: scrollController),
          );
        },
      );
    },
  );
}
