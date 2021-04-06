import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/usuario_controller.dart';
import 'package:nosso/src/paginas/usuario/usuario_create_page.dart';
import 'package:nosso/src/paginas/usuario/usuario_list.dart';
import 'package:nosso/src/paginas/usuario/usuario_table.dart';

class UsuarioPage extends StatelessWidget {
  var usuarioController = GetIt.I.get<UsuarioController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 50,
        elevation: 0,
        title: Text("Usuários"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (usuarioController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (usuarioController.usuarios == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
                child: Text(
                  (usuarioController.usuarios.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 50),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50, top: 10),
        child: Card(child: UsuarioTable()),
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
                MaterialPageRoute(
                  builder: (context) {
                    return UsuarioCreatePage();
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
