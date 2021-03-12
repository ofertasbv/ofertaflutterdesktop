import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/cartao_controller.dart';
import 'package:nosso/src/paginas/cartao/cartao_create_page.dart';
import 'package:nosso/src/paginas/pagamento/pagamento_create_page.dart';
import 'package:nosso/src/paginas/pagamento/pagamento_list.dart';
import 'package:nosso/src/paginas/pagamento/pagamento_table.dart';

class PagamentoPage extends StatelessWidget {
  var cartaoController = GetIt.I.get<CartaoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 50,
        title: Text("Pagamentos"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (cartaoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (cartaoController.cartoes == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return Chip(
                label: Text(
                  (cartaoController.cartoes.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 100),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: PagamentoTable(),
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
