import 'package:flutter/material.dart';

class SobrePage extends StatefulWidget {
  @override
  _SobrePageState createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Text("Sobre"),
        actions: [
          CircleAvatar(
            foregroundColor: Theme.of(context).accentColor,
            child: IconButton(
              icon: Icon(
                Icons.info_outline,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: buildContainer(context),
    );
  }

  buildContainer(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Container(
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
                              fontSize: 45,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.shopping_basket_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        "OFERTAS",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: ListTile(
                    title: Text("versão 1.0"),
                    subtitle: Text("todos os direitos reservados"),
                  ),
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: ListTile(
                    title: Text("contato"),
                    subtitle: Text("bookofertasbr@gmail.com"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
