import 'package:flutter/material.dart';

class CircularProgressor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: CircularProgressIndicator(
          strokeWidth: 1.8,
          backgroundColor: Theme.of(context).primaryColor,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
  }
}
