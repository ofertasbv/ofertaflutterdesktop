import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildContainerHeader(context);
  }

  buildContainerHeader(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: Container(
        height: 80,
        width: 80,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "BOOK",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.shopping_basket_outlined,
                    size: 20,
                  ),
                ],
              ),
            ),
            Container(
              child: Text(
                "OFERTAS",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
