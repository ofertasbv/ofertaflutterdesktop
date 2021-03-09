import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/src/home/catalogo_menu.dart';
import 'package:nosso/src/home/drawer_list.dart';
import 'package:nosso/src/util/layout/home_tabe.dart';


class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          drawer: DrawerList(),
          body: HomeTabe(),
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            child: Icon(Icons.apps),
            hoverColor: Colors.redAccent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatalogoMenu(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
