import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/tamanho_controller.dart';
import 'package:nosso/src/core/model/tamanho.dart';
import 'package:nosso/src/paginas/tamanho/tamanho_page.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/format/uppercasetext.dart';

class TamanhoCreatePage extends StatefulWidget {
  Tamanho tamanho;

  TamanhoCreatePage({Key key, this.tamanho}) : super(key: key);

  @override
  _TamanhoCreatePageState createState() => _TamanhoCreatePageState(c: tamanho);
}

class _TamanhoCreatePageState extends State<TamanhoCreatePage> {
  var tamanhoController = GetIt.I.get<TamanhoController>();

  Dialogs dialogs = Dialogs();

  Tamanho c;
  File file;
  bool isButtonDesable = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _TamanhoCreatePageState({this.c});

  var controllerNome = TextEditingController();

  @override
  void initState() {
    tamanhoController.getAll();
    if (c == null) {
      c = Tamanho();
    }
    super.initState();
  }

  Controller controller;

  @override
  didChangeDependencies() {
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
      appBar: AppBar(
        title: c.descricao == null
            ? Text("Cadastro de tamanho")
            : Text(c.descricao),
      ),
      body: Observer(
        builder: (context) {
          if (tamanhoController.dioError == null) {
            return buildListViewForm(context);
          } else {
            print("Erro: ${tamanhoController.mensagem}");
            showToast("${tamanhoController.mensagem}");
            return buildListViewForm(context);
          }
        },
      ),
    );
  }

  buildListViewForm(BuildContext context) {
    var focus = FocusScope.of(context);

    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text("Cadastrar tamanho de produtos"),
            trailing: Icon(Icons.format_size_outlined),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15),
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
                        initialValue: c.descricao,
                        onSaved: (value) => c.descricao = value,
                        validator: (value) =>
                            value.isEmpty ? "campo obrigário" : null,
                        decoration: InputDecoration(
                          labelText: "Descrição do tamanho",
                          hintText: "descrição do tamanho",
                          prefixIcon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lime[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        inputFormatters: [UpperCaeseText()],
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 50,
                        maxLines: 1,
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
                if (c.id == null) {
                  dialogs.information(context, "prepando para o cadastro...");
                  Timer(Duration(seconds: 3), () {
                    tamanhoController.create(c).then((value) {
                      print("resultado : ${value}");
                    });
                    Navigator.of(context).pop();
                    buildPush(context);
                  });
                } else {
                  dialogs.information(
                      context, "preparando para o alteração...");
                  Timer(Duration(seconds: 3), () {
                    tamanhoController.update(c.id, c);
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
        builder: (context) => TamanhoPage(),
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
