import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/usuario_controller.dart';
import 'package:nosso/src/core/model/usuario.dart';
import 'package:nosso/src/paginas/cliente/cliente_create_page.dart';
import 'package:nosso/src/paginas/usuario/usuario_perfil_cliente.dart';
import 'package:nosso/src/paginas/usuario/usuario_pesquisa_login.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/snackbar/snackbar_global.dart';
import 'package:nosso/src/util/validador/validador_login.dart';

class UsuarioLogin extends StatefulWidget {
  @override
  _UsuarioLoginState createState() => _UsuarioLoginState();
}

class _UsuarioLoginState extends State<UsuarioLogin> with LoginValidators {
  var usuarioController = GetIt.I.get<UsuarioController>();
  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  Dialogs dialogs = Dialogs();

  Usuario u;
  bool isButtonDesable = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    if (u == null) {
      u = Usuario();
    }
    super.initState();
  }

  Controller controller;

  @override
  didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  showSnackbar(BuildContext context, String texto) {
    final snackbar = SnackBar(content: Text(texto));
    GlobalScaffold.instance.showSnackbar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (usuarioController.dioError == null) {
          return buildListViewForm(context);
        } else {
          print("Erro: ${usuarioController.mensagem}");
          return buildListViewForm(context);
        }
      },
    );
  }

  buildListViewForm(BuildContext context) {
    var focus = FocusScope.of(context);
    return ListView(
      children: <Widget>[
        buildContainer(context),
        SizedBox(height: 0),
        Container(
          padding: EdgeInsets.all(30),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  onSaved: (value) => u.email = value.trim(),
                  controller: emailController,
                  validator: validateEmail,
                  decoration: InputDecoration(
                    labelText: "Insira seu e-mail",
                    hintText: "email@gmail.com",
                    suffixIcon: IconButton(
                      onPressed: () => emailController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  onEditingComplete: () => focus.nextFocus(),
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  maxLines: 1,
                ),
                TextFormField(
                  autofocus: false,
                  controller: senhaController,
                  onSaved: (value) => u.senha = value.trim(),
                  validator: validateSenha,
                  decoration: InputDecoration(
                    labelText: "Digite sua senha",
                    hintText: "Senha",
                    suffixIcon: IconButton(
                      icon: usuarioController.senhaVisivel == true
                          ? Icon(Icons.visibility_outlined, color: Colors.grey)
                          : Icon(Icons.visibility_off_outlined,
                              color: Colors.grey),
                      onPressed: () {
                        usuarioController.visualizarSenha();
                      },
                    ),
                  ),
                  onEditingComplete: () => focus.nextFocus(),
                  keyboardType: TextInputType.text,
                  obscureText: !usuarioController.senhaVisivel,
                  maxLength: 8,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 0),
        Container(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: RaisedButton.icon(
            label: Text("Entrar"),
            icon: Icon(Icons.check),
            onPressed: () {
              if (controller.validate()) {
                if (u.id == null) {
                  dialogs.information(context, "verificando login...");
                  Timer(Duration(seconds: 3), () {
                    usuarioController.loginToken(u).then((usuario) {
                      if (usuario != null) {
                        buildPush(context);
                      } else {
                        showSnackbar(context, "Erro: login/senha inválido");
                        emailController.clear();
                        senhaController.clear();
                      }
                      print("login...");
                    });
                    Navigator.pop(context);
                  });
                }
              }
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: RaisedButton.icon(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.account_circle_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ClienteCreatePage();
                  },
                ),
              );
            },
            label: Text("Não tem conta? cadastre-se"),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Esqueceu a senha ? "),
              GestureDetector(
                child: Text(
                  "Alterar senha",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return UsuarioPesquisaLogin();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      height: 130,
      color: Theme.of(context).accentColor.withOpacity(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(1),
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor
                ],
              ),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.grey[100],
              radius: 25,
              child: Icon(
                Icons.person,
                size: 25,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text("Olá :) acesse sua conta"),
        ],
      ),
    );
  }

  buildPush(BuildContext context) {
    Navigator.pop(context);
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UsuarioPerfilCliente(),
      ),
    );
  }
}

class Controller {
  var formKey = GlobalKey<FormState>();

  bool validate() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
}
