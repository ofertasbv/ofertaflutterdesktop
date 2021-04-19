import 'package:flutter/material.dart';
import 'package:nosso/src/home/constants.dart';
import 'package:nosso/src/util/responsivel/responsive.dart';

class Socal extends StatelessWidget {
  const Socal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isMobile(context)) Icon(Icons.home_outlined),
        if (!Responsive.isMobile(context))
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            child: Icon(
              Icons.home_outlined,
            ),
          ),
        if (!Responsive.isMobile(context)) Icon(Icons.home_outlined),
        SizedBox(width: kDefaultPadding),
        ElevatedButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 1.5,
              vertical:
                  kDefaultPadding / (Responsive.isDesktop(context) ? 1 : 2),
            ),
          ),
          child: Text("Let's Talk"),
        ),
      ],
    );
  }
}
