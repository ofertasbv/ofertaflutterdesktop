import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/paginas/promocao/promocao_create_page.dart';
import 'package:nosso/src/paginas/promocao/promocao_table.dart';

class PromocaoPage extends StatefulWidget {
  Loja p;

  PromocaoPage({Key key, this.p}) : super(key: key);

  @override
  _PromocaoPageState createState() => _PromocaoPageState(p: this.p);
}

class _PromocaoPageState extends State<PromocaoPage> {
  var promocaoController = GetIt.I.get<PromoCaoController>();

  Loja p;

  _PromocaoPageState({this.p});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        title: Text("Ofertas"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (promocaoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (promocaoController.promocoes == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                child: Text(
                  (promocaoController.promocoes.length ?? 0).toString(),
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
                promocaoController.getAll();
              },
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50, top: 10),
        child: Card(child: PromocaoTable()),
      ),
    );
  }
}
