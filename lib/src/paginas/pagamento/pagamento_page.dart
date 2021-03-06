import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pagamento_controller.dart';
import 'package:nosso/src/paginas/pagamento/pagamento_create_page.dart';
import 'package:nosso/src/paginas/pagamento/pagamento_table.dart';

class PagamentoPage extends StatelessWidget {
  var pagamentoController = GetIt.I.get<PagamentoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Text("Pagamentos"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (pagamentoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (pagamentoController.pagamentos == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
                child: Text(
                  (pagamentoController.pagamentos.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {
                pagamentoController.getAll();
              },
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50, top: 10),
        child: Card(child: PagamentoTable()),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PagamentoCreatePage();
              },
            ),
          );
        },
      ),
    );
  }
}
