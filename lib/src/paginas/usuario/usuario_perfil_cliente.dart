import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/cliente_controller.dart';
import 'package:nosso/src/core/controller/usuario_controller.dart';
import 'package:nosso/src/core/model/cliente.dart';
import 'package:nosso/src/core/model/uploadFileResponse.dart';
import 'package:nosso/src/paginas/endereco/endereco_cliente_page.dart';
import 'package:nosso/src/paginas/usuario/usuario_create_page.dart';
import 'package:nosso/src/paginas/usuario/usuario_edit_cliente.dart';
import 'package:nosso/src/util/upload/upload_response.dart';

class UsuarioPerfilCliente extends StatefulWidget {
  Cliente cliente;

  UsuarioPerfilCliente({Key key, this.cliente}) : super(key: key);

  @override
  _UsuarioPerfilClienteState createState() =>
      _UsuarioPerfilClienteState(p: this.cliente);
}

class _UsuarioPerfilClienteState extends State<UsuarioPerfilCliente> {
  _UsuarioPerfilClienteState({this.p});

  var usuarioController = GetIt.I.get<UsuarioController>();
  var clienteController = GetIt.I.get<ClienteController>();
  var uploadFileResponse = UploadFileResponse();
  var response = UploadRespnse();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Cliente p;
  File file;
  bool isEnabledEnviar = false;
  bool isEnabledDelete = false;

  @override
  void initState() {
    if (p == null) {
      p = Cliente();
    }

    super.initState();
  }

  enableButton() {
    setState(() {
      isEnabledEnviar = true;
    });
  }

  disableButton() {
    setState(() {
      isEnabledDelete = true;
    });
  }

  onClickUpload() async {
    if (file != null) {
      var url = await clienteController.upload(file, p.foto);

      print("url: ${url}");

      print("========= UPLOAD FILE RESPONSE ========= ");

      uploadFileResponse = response.response(uploadFileResponse, url);

      print("fileName: ${uploadFileResponse.fileName}");
      print("fileDownloadUri: ${uploadFileResponse.fileDownloadUri}");
      print("fileType: ${uploadFileResponse.fileType}");
      print("size: ${uploadFileResponse.size}");

      p.foto = uploadFileResponse.fileName;

      setState(() {
        uploadFileResponse;
      });

      showSnackbar(context, "Arquivo anexada com sucesso!");
    }
  }

  showSnackbar(BuildContext context, String content) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 150,
          color: Theme.of(context).primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(1),
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor],
                  ),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: GestureDetector(
                  onTap: () {
                    // openBottomSheet(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 30,
                    child: file != null
                        ? Image.file(
                            file,
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                            height: 300,
                          )
                        : usuarioController.usuarioSelecionado.pessoa.foto !=
                                null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  clienteController.arquivo +
                                      usuarioController
                                          .usuarioSelecionado.pessoa.foto,
                                ),
                              )
                            : CircleAvatar(
                                radius: 50,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                ),
                              ),
                  ),
                ),
              ),
              SizedBox(height: 0),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Text(
                  "${usuarioController.usuarioSelecionado.pessoa.nome}",
                  style: TextStyle(
                    color: Colors.grey[100],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Text(
                  "${usuarioController.usuarioSelecionado.pessoa.tipoPessoa}",
                  style: TextStyle(
                    color: Colors.grey[100],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text("Cupom de desconto"),
                subtitle: Text("Resgate seu cupom de desconto"),
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
                title: Text("Minha lista de desejo"),
                subtitle: Text("Todos os seus desejos"),
                leading: CircleAvatar(
                  child: Icon(Icons.list_alt_outlined),
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
                title: Text("Dados pesoais"),
                subtitle: Text("Alterar senha, login, email, e dados pessoais"),
                leading: CircleAvatar(
                  child: Icon(Icons.account_circle_outlined),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return UsuarioEditCliente();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Minhas avaliações"),
                subtitle: Text("Suas opiniões dos produtos de desejo"),
                leading: CircleAvatar(
                  child: Icon(Icons.star_border),
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
                title: Text("Endereço de cliente"),
                subtitle: Text("Altere seu endereço"),
                leading: CircleAvatar(
                  child: Icon(Icons.location_on_outlined),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return EnderecoClientePage();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Atedimento ao cliente"),
                subtitle: Text("Envie um e-mail"),
                leading: CircleAvatar(
                  child: Icon(Icons.email_outlined),
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
                title: Text("Sair"),
                subtitle: Text("Acesse com outra conta"),
                leading: CircleAvatar(
                  child: Icon(Icons.logout),
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
            ],
          ),
        ),
      ],
    );
  }
}
