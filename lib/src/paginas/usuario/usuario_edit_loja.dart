import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/controller/usuario_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/paginas/loja/loja_create_page.dart';
import 'package:nosso/src/paginas/usuario/usuario_create_page.dart';
import 'package:nosso/src/paginas/usuario/usuario_recuperar_senha.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';

class UsuarioEditLoja extends StatefulWidget {
  @override
  _UsuarioEditLojaState createState() => _UsuarioEditLojaState();
}

class _UsuarioEditLojaState extends State<UsuarioEditLoja> {
  var lojaController = GetIt.I.get<LojaController>();
  var usuarioController = GetIt.I.get<UsuarioController>();
  Dialogs dialogs = Dialogs();

  Loja p = Loja();

  buscarPessoa(int id) async {
    p = await lojaController.getById(id);
    print("Loja: ${p.nome}");
    return p;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil de loja"),
      ),
      body: ListView(
        children: [
          Container(
            height: 240,
            color: Colors.grey[100],
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text("Alterar login"),
                  subtitle: Text("Altere seu login"),
                  leading: CircleAvatar(
                    child: Icon(Icons.games_outlined),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UsuarioCreatePage();
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text("Alterar senha"),
                  subtitle: Text("Atualize sua senha"),
                  leading: CircleAvatar(
                    child: Icon(Icons.list_alt_outlined),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UsuarioRecuperarSenha();
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text("Alterar dados comerciais"),
                  subtitle: Text("Nome Fantazia, Razão Social, CNPJ"),
                  leading: CircleAvatar(
                    child: Icon(Icons.account_circle_outlined),
                  ),
                  onTap: () {
                    buscarPessoa(
                        usuarioController.usuarioSelecionado.pessoa.id);
                    dialogs.information(context, "carregando suas informações");
                    Timer(Duration(seconds: 3), () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return LojaCreatePage(
                              loja: p,
                            );
                          },
                        ),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
