import 'package:flutter/material.dart';

class MessageAssistant extends StatelessWidget {
  const MessageAssistant({
    super.key,
    required this.message,
    required this.hour,
    required this.image,
  });

  final String message;
  final String hour;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(right: 60.0),
      child: Stack(
        alignment: Alignment(-1, 0),
        children: [
          SizedBox(
            child: Card(
              color: Color(0xFFD29289),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    if (image != null && image!.isNotEmpty)
                      Column(
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: Image.network(
                              'https://cdn.prod.website-files.com/60c368fa646716418bdf9ce9/614b4884362e9151e5e4a4b5_189142-conheca-as-principais-caracteristicas-das-joias-de-ouro-amarelo.jpeg',
                              width: 40.0, // controla tamanho
                            ),
                          ),
                          SizedBox(height: 3.0),
                        ],
                      ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        message,
                        style: TextStyle(
                          color: Colors.white,
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
                          color: Colors.white,
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
