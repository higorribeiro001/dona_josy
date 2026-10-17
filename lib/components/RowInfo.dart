import 'package:dona_josy/components/AppText.dart';
import 'package:flutter/material.dart';

class RowInfo extends StatelessWidget {
  const RowInfo({
    super.key,
    required this.title,
    required this.value,
    this.fontSize,
    this.width,
    this.height,
    this.maxLines,
  });

  final String title;
  final String value;
  final double? fontSize;
  final double? width;
  final double? height;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontWeight: FontWeight.w600,
          fontSize: fontSize ?? 14,
        ),
        SizedBox(width: 5),
        SizedBox(
          width: width ?? 110,
          height: height ?? 20,
          child: AppText(
            text: value,
            fontSize: fontSize ?? 14,
            lines: maxLines ?? 1,
          ),
        ),
      ],
    );
  }
}
