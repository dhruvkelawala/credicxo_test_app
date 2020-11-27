import 'package:flutter/material.dart';

class Retry extends StatelessWidget {
  //
  final String message;


  Retry({this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
