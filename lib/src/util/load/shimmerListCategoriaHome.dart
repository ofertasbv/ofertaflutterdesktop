import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListCategoriaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 1000;

    return SafeArea(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          print(time);

          return Padding(
            padding: EdgeInsets.only(right: 10),
            child: Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: Colors.grey[350],
              child: ShimmerLayoutListCategoriaHome(),
              period: Duration(milliseconds: time),
            ),
          );
        },
      ),
    );
  }
}

class ShimmerLayoutListCategoriaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width - 150;
    double containerHeight = 15;

    return Card(
      child: AnimatedContainer(
        width: 200,
        height: 300,
        alignment: Alignment.center,
        duration: Duration(seconds: 1),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(1),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 50,
              ),
            ),
            SizedBox(height: 0),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(0),
              height: 80,
              width: containerWidth,
            )
          ],
        ),
      ),
    );
  }
}
