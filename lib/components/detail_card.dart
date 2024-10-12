import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String title;
  final IconData icon;
  final double width;

  const DetailCard({
    super.key,
    required this.color,
    required this.textColor,
    required this.title,
    required this.icon,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Icon(
                icon,
                color: textColor,
                size: 48,
              ),
              Text(
                title,
                softWrap: false,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
