import 'package:dona_josy/utils/theme.dart';
import 'package:flutter/material.dart';

class Selectbutton extends StatefulWidget {
  const Selectbutton({
    super.key,
    required this.title,
    required this.value,
    required this.setValue,
  });

  final String title;
  final String value;
  final Function(String title) setValue;

  @override
  State<Selectbutton> createState() => _SelectbuttonState();
}

class _SelectbuttonState extends State<Selectbutton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.setValue(widget.title),
      child: Container(
        margin: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color:
              widget.value == widget.title
                  ? themeData.primaryColor
                  : Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
