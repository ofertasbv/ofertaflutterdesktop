import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/permissao_controller.dart';
import 'package:nosso/src/paginas/permissao/permissao_create_page.dart';
import 'package:nosso/src/paginas/permissao/permissao_list.dart';

class PermissaoPage extends StatelessWidget {
  var permissaoController = GetIt.I.get<PermissaoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Permissões"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (permissaoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (permissaoController.permissoes == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return Chip(
                label: Text(
                  (permissaoController.permissoes.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: PermissaoList(),
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
                MaterialPageRoute(
                  builder: (context) => PermissaoCreatePage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
