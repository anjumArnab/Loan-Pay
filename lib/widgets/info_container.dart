import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double spacing;

  const InfoContainer({
    super.key,
    required this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ?? const TextStyle(fontSize: 14),
          ),
          if (subtitle != null) ...[
            SizedBox(height: spacing),
            Text(
              subtitle!,
              style: subtitleStyle ?? const TextStyle(fontSize: 14),
            ),
          ],
        ],
      ),
    );
  }
}
