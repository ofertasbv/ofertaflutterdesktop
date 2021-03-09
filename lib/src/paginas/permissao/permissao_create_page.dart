import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/permissao_controller.dart';
import 'package:nosso/src/core/model/permissao.dart';
import 'package:nosso/src/paginas/permissao/permissao_page.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/format/uppercasetext.dart';

class PermissaoCreatePage extends StatefulWidget {
  Permissao permissao;

  PermissaoCreatePage({Key key, this.permissao}) : super(key: key);

  @override
  _PermissaoCreatePageState createState() =>
      _PermissaoCreatePageState(p: this.permissao);
}

class _PermissaoCreatePageState extends State<PermissaoCreatePage> {
  var permissaoController = GetIt.I.get<PermissaoController>();

  Dialogs dialogs = Dialogs();

  Permissao p;
  File file;

  _PermissaoCreatePageState({this.p});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var controllerNome = TextEditingController();

  @override
  void initState() {
    permissaoController.getAll();
    if (p == null) {
      p = Permissao();
    }
    super.initState();
  }

  Controller controller;

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  showToast(String cardTitle) {
    Fluttertoast.showToast(
      msg: "$cardTitle",
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 10,
      fontSize: 16.0,
    );
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
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: p.descricao == null
            ? Text("Cadastro de permissão")
            : Text(p.descricao),
      ),
      body: Observer(
        builder: (context) {
          if (permissaoController.dioError == null) {
            return buildListViewForm(context);
          } else {
            print("Erro: ${permissaoController.mensagem}");
            showToast("${permissaoController.mensagem}");
            return buildListViewForm(context);
          }
        },
      ),
    );
  }

  buildListViewForm(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text("Cadastrar permissão de acesso"),
            trailing: Icon(Icons.vpn_key_outlined),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: p.descricao,
                        onSaved: (value) => p.descricao = value,
                        validator: (value) =>
                            value.isEmpty ? "campo obrigário" : null,
                        decoration: InputDecoration(
                          labelText: "Descrição",
                          hintText: "exe: CADASTRO_ROLE",
                          prefixIcon: Icon(Icons.edit, color: Colors.grey),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lime[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        inputFormatters: [UpperCaeseText()],
                        keyboardType: TextInputType.text,
                        maxLength: 50,
                        maxLines: 1,
                        //initialValue: c.nome,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 0),
        Container(
          padding: EdgeInsets.all(15),
          child: RaisedButton.icon(
            label: Text("Enviar formulário"),
            icon: Icon(Icons.check),
            onPressed: () {
              if (controller.validate()) {
                if (p.id == null) {
                  dialogs.information(context, "prepando para o cadastro...");
                  Timer(Duration(seconds: 3), () {
                    permissaoController.create(p).then((value) {
                      print("resultado : ${value}");
                    });
                    Navigator.of(context).pop();
                    buildPush(context);
                  });
                } else {
                  dialogs.information(
                      context, "preparando para o alteração...");
                  Timer(Duration(seconds: 3), () {
                    permissaoController.update(p.id, p);
                    Navigator.of(context).pop();
                    buildPush(context);
                  });
                }
              }
            },
          ),
        ),
      ],
    );
  }

  buildPush(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PermissaoPage(),
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
