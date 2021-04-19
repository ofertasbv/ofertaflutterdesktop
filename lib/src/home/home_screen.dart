import 'package:flutter/material.dart';
import 'package:nosso/src/home/constants.dart';
import 'package:nosso/src/util/responsivel/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.redAccent,
            height: 1000,
          ),
        ),
        if (!Responsive.isMobile(context)) SizedBox(width: kDefaultPadding),
        // Sidebar
        if (!Responsive.isMobile(context))
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.green,
              height: 1000,
            ),
          ),
      ],
    );
  }
}
