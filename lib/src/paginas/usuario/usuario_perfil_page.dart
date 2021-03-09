import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/cliente_controller.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/controller/usuario_controller.dart';
import 'package:nosso/src/core/model/cliente.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/usuario.dart';
import 'package:nosso/src/paginas/usuario/usuario_login.dart';
import 'package:nosso/src/paginas/usuario/usuario_perfil_cliente.dart';
import 'package:nosso/src/paginas/usuario/usuario_perfil_loja.dart';

class UsuarioPerfilPage extends StatefulWidget {
  @override
  _UsuarioPerfilPageState createState() => _UsuarioPerfilPageState();
}

class _UsuarioPerfilPageState extends State<UsuarioPerfilPage> {
  var usuarioController = GetIt.I.get<UsuarioController>();
  var clienteController = GetIt.I.get<ClienteController>();
  var lojaController = GetIt.I.get<LojaController>();

  Cliente c;
  Loja l;

  @override
  void initState() {
    if (c == null) {
      c = Cliente();
    }
    if (l == null) {
      l = Loja();
    }
    super.initState();
  }

  buscarPessoaCliente(int id) async {
    c = await clienteController.getById(id);
    print("Cliente: ${c.nome}");
    return c;
  }

  buscarPessoaLoja(int id) async {
    l = await lojaController.getById(id);
    print("Loja: ${l.nome}");
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return usuarioHome();
  }

  usuarioHome() {
    return Observer(
      builder: (context) {
        Usuario u = usuarioController.usuarioSelecionado;

        if (u != null) {
          if (u.pessoa.tipoPessoa == "FISICA") {
            buscarPessoaCliente(u.pessoa.id);
            return UsuarioPerfilCliente(cliente: c);
          } else if (u.pessoa.tipoPessoa == "JURIDICA") {
            buscarPessoaLoja(u.pessoa.id);
            return UsuarioPerfilLoja(loja: l);
          }
        } else {
          return UsuarioLogin();
        }
        return null;
      },
    );
  }
}
