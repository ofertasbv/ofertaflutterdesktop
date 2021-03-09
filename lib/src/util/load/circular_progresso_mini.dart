import 'package:flutter/material.dart';

class CircularProgressorMini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          strokeWidth: 1.8,
          backgroundColor: Theme.of(context).primaryColor,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
  }
}
