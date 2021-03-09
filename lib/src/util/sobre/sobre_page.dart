import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/src/api/constants/constant_api.dart';

class SobrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre"),
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  ConstantApi.urlLogo,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "U-NOSSO",
                  ),
                  SizedBox(height: 10),
                  Text("Versão 1.0"),
                  SizedBox(height: 10),
                  Text(
                    "Desenvolvido by gdados tecnologia",
                  ),
                  SizedBox(height: 10),
                  Text("Todos os direitos resarvado a gdados tecnologia")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
