import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/paginas/loja/loja_create_page.dart';
import 'package:nosso/src/paginas/loja/loja_table.dart';

class LojaPage extends StatelessWidget {
  var lojaController = GetIt.I.get<LojaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 50,
        title: Text("Lojas"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (lojaController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (lojaController.lojas == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                child: Text(
                  (lojaController.lojas.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {
                lojaController.getAll();
              },
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: LojaTable(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 8,
            height: 8,
          ),
          FloatingActionButton(
            elevation: 10,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return LojaCreatePage();
                }),
              );
            },
          )
        ],
      ),
    );
  }
}
