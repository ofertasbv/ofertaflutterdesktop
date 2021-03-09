import 'package:flutter/material.dart';
import 'package:nosso/src/paginas/usuario/usuario_login.dart';

class UsuarioLoginPage extends StatefulWidget {
  @override
  _UsuarioLoginPageState createState() => _UsuarioLoginPageState();
}

class _UsuarioLoginPageState extends State<UsuarioLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: UsuarioLogin(),
    );
  }
}
