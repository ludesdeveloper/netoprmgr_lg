import 'package:flutter/material.dart';

class DynamicInput extends StatelessWidget {
  TextEditingController sourceController = new TextEditingController();
  TextEditingController destinationController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: sourceController,
          decoration: InputDecoration(hintText: 'Source'),
        ),
        TextField(
          controller: destinationController,
          decoration: InputDecoration(hintText: 'Destination'),
        ),
      ],
    );
  }
}
