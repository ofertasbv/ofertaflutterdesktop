import 'package:flutter/material.dart';
import 'package:nosso/src/paginas/usuario/usuario_login.dart';
import 'package:nosso/src/util/snackbar/snackbar_global.dart';

class UsuarioLoginPage extends StatefulWidget {
  @override
  _UsuarioLoginPageState createState() => _UsuarioLoginPageState();
}

class _UsuarioLoginPageState extends State<UsuarioLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 50,
        elevation: 0,
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 550, right: 550, top: 20),
        height: 700,
        child: Card(child: UsuarioLogin()),
      ),
    );
  }
}
