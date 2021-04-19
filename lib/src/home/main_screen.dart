import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nosso/src/home/MenuController.dart';
import 'package:nosso/src/home/constants.dart';
import 'package:nosso/src/home/header.dart';
import 'package:nosso/src/home/home_screen.dart';
import 'package:nosso/src/home/side_menu.dart';

class MainScreen extends StatelessWidget {
  final MenuController _controller = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.scaffoldkey,
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              constraints: BoxConstraints(maxWidth: kMaxWidth),
              child: SafeArea(
                child: HomeScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
