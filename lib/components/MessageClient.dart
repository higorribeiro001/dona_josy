import 'package:flutter/material.dart';

class MessageClient extends StatelessWidget {
  const MessageClient({super.key, required this.message, required this.hour});

  final String message;
  final String hour;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 60.0),
      child: Stack(
        alignment: Alignment(1, 0),
        children: [
          SizedBox(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        message,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 3.0),
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        hour,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
