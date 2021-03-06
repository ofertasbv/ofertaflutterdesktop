import 'dart:async';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nosso/src/core/controller/vendedor_controller.dart';
import 'package:nosso/src/core/model/endereco.dart';
import 'package:nosso/src/core/model/uploadFileResponse.dart';
import 'package:nosso/src/core/model/usuario.dart';
import 'package:nosso/src/core/model/vendedor.dart';
import 'package:nosso/src/paginas/usuario/usuario_login_page.dart';
import 'package:nosso/src/paginas/vendedor/vendedor_page.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/upload/upload_response.dart';
import 'package:nosso/src/util/validador/validador_pessoa.dart';

class VendedorCreatePage extends StatefulWidget {
  Vendedor vendedor;

  VendedorCreatePage({Key key, this.vendedor}) : super(key: key);

  @override
  _VendedorCreatePageState createState() =>
      _VendedorCreatePageState(p: this.vendedor);
}

class _VendedorCreatePageState extends State<VendedorCreatePage>
    with ValidadorPessoa {
  _VendedorCreatePageState({this.p});

  var vendedorController = GetIt.I.get<VendedorController>();
  var dialogs = Dialogs();

  Vendedor p;
  Endereco e;
  Usuario u;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime dataAtual = DateTime.now();
  String tipoPessoa;
  String sexo;
  String valorSlecionado;
  File file;

  var uploadFileResponse = UploadFileResponse();
  var response = UploadRespnse();

  var senhaController = TextEditingController();
  var confirmaSenhaController = TextEditingController();

  @override
  void initState() {
    if (p == null) {
      p = Vendedor();
      u = Usuario();
      e = Endereco();
    } else {
      u = p.usuario;
    }

    tipoPessoa = "FISICA";
    sexo = "MASCULINO";
    super.initState();
  }

  Controller controller;

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
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
        elevation: 0,
        titleSpacing: 50,
        title: p.nome == null ? Text("Cadastro de vendedor") : Text(p.nome),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: Card(
          child: Observer(
            builder: (context) {
              if (vendedorController.dioError == null) {
                return buildListViewForm(context);
              } else {
                print("Erro: ${vendedorController.mensagem}");
                return buildListViewForm(context);
              }
            },
          ),
        ),
      ),
    );
  }

  buildListViewForm(BuildContext context) {
    var focus = FocusScope.of(context);
    var dateFormat = DateFormat('dd-MM-yyyy');

    var maskFormatterCelular = new MaskTextInputFormatter(
        mask: '(##)#####-####', filter: {"#": RegExp(r'[0-9]')});

    var maskFormatterCPF = new MaskTextInputFormatter(
        mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

    p.usuario = u;

    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text("fa??a seu cadastro, ?? rapido e seguro"),
            trailing: Icon(Icons.person_outline),
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Text("Dados Pessoais"),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("PESSOA FISICA"),
                              value: "FISICA",
                              groupValue: p.tipoPessoa == null
                                  ? p.tipoPessoa = tipoPessoa
                                  : p.tipoPessoa,
                              onChanged: (String valor) {
                                setState(() {
                                  p.tipoPessoa = valor;
                                  print("resultado: " + p.tipoPessoa);
                                });
                              },
                            ),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("PESSOA JURIDICA"),
                              value: "JURIDICA",
                              groupValue: p.tipoPessoa == null
                                  ? p.tipoPessoa = tipoPessoa
                                  : p.tipoPessoa,
                              onChanged: (String valor) {
                                setState(() {
                                  p.tipoPessoa = valor;
                                  print("resultado: " + p.tipoPessoa);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15),
                        Text("Genero sexual"),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("MASCULINO"),
                              value: "MASCULINO",
                              groupValue:
                                  p.sexo == null ? p.sexo = sexo : p.sexo,
                              onChanged: (String valor) {
                                setState(() {
                                  p.sexo = valor;
                                  print("sexo: " + p.sexo);
                                });
                              },
                            ),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("FEMININO"),
                              value: "FEMININO",
                              groupValue:
                                  p.sexo == null ? p.sexo = sexo : p.sexo,
                              onChanged: (String valor) {
                                setState(() {
                                  p.sexo = valor;
                                  print("sexo: " + p.sexo);
                                });
                              },
                            ),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("OUTRO"),
                              value: "OUTRO",
                              groupValue:
                                  p.sexo == null ? p.sexo = sexo : p.sexo,
                              onChanged: (String valor) {
                                setState(() {
                                  p.sexo = valor;
                                  print("sexo: " + p.sexo);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 500,
                        child: TextFormField(
                          initialValue: p.nome,
                          onSaved: (value) => p.nome = value,
                          validator: (value) =>
                              value.isEmpty ? "campo obrig??rio" : null,
                          decoration: InputDecoration(
                            labelText: "Nome completo",
                            hintText: "nome",
                            prefixIcon: Icon(Icons.people, color: Colors.grey),
                            suffixIcon: Icon(Icons.close),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                        ),
                      ),
                      Container(
                        width: 500,
                        child: TextFormField(
                          initialValue: p.cpf,
                          onSaved: (value) => p.cpf = value,
                          validator: (value) =>
                              value.isEmpty ? "campo obrig??rio" : null,
                          decoration: InputDecoration(
                            labelText: "cpf",
                            hintText: "cpf",
                            prefixIcon:
                                Icon(Icons.contact_mail, color: Colors.grey),
                            suffixIcon: Icon(Icons.close),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          inputFormatters: [maskFormatterCPF],
                          keyboardType: TextInputType.number,
                          maxLength: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 500,
                        child: TextFormField(
                          initialValue: p.telefone,
                          onSaved: (value) => p.telefone = value,
                          validator: (value) =>
                              value.isEmpty ? "campo obrig??rio" : null,
                          decoration: InputDecoration(
                            labelText: "Telefone",
                            hintText: "Telefone celular",
                            prefixIcon: Icon(Icons.phone, color: Colors.grey),
                            suffixIcon: Icon(Icons.close),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [maskFormatterCelular],
                          maxLength: 50,
                        ),
                      ),
                      Container(
                        width: 500,
                        child: TextFormField(
                          initialValue: p.usuario.email,
                          onSaved: (value) => p.usuario.email = value,
                          validator: validateEmail,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email, color: Colors.grey),
                            suffixIcon: Icon(Icons.close),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 500,
                        child: TextFormField(
                          controller: senhaController,
                          onSaved: (value) => p.usuario.senha = value,
                          validator: validateSenha,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            hintText: "Senha",
                            prefixIcon:
                                Icon(Icons.security, color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: vendedorController.senhaVisivel == true
                                  ? Icon(Icons.visibility_outlined,
                                      color: Colors.grey)
                                  : Icon(Icons.visibility_off_outlined,
                                      color: Colors.grey),
                              onPressed: () {
                                vendedorController.visualizarSenha();
                              },
                            ),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.text,
                          obscureText: !vendedorController.senhaVisivel,
                          maxLength: 8,
                        ),
                      ),
                      Container(
                        width: 500,
                        child: TextFormField(
                          controller: confirmaSenhaController,
                          validator: validateSenha,
                          decoration: InputDecoration(
                            labelText: "Confirma senha",
                            hintText: "Confirma senha",
                            prefixIcon:
                                Icon(Icons.security, color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: vendedorController.senhaVisivel == true
                                  ? Icon(Icons.visibility_outlined,
                                      color: Colors.grey)
                                  : Icon(Icons.visibility_off_outlined,
                                      color: Colors.grey),
                              onPressed: () {
                                vendedorController.visualizarSenha();
                              },
                            ),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.text,
                          obscureText: !vendedorController.senhaVisivel,
                          maxLength: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        SizedBox(height: 0),
        Container(
          padding: EdgeInsets.all(15),
          child: RaisedButton.icon(
            label: Text("Enviar formul??rio"),
            icon: Icon(Icons.check),
            onPressed: () {
              if (controller.validate()) {
                if (p.id == null) {
                  if (senhaController.text != confirmaSenhaController.text) {
                    showSnackbar(context, "senha diferentes");
                    print("senha diferentes");
                  } else {
                    dialogs.information(context, "prepando para o cadastro...");
                    Timer(Duration(seconds: 3), () {
                      print("Pessoa: ${p.tipoPessoa}");
                      print("Nome: ${p.nome}");
                      print("CPF: ${p.cpf}");
                      print("Telefone: ${p.telefone}");
                      print("DataRegistro: ${p.dataRegistro}");
                      print("Email: ${p.usuario.email}");
                      print("Senha: ${p.usuario.senha}");

                      vendedorController.create(p).then((value) {
                        print("resultado : ${value}");
                      });
                      buildPush(context);
                    });
                  }
                } else {
                  if (p.usuario.senha == p.usuario.confirmaSenha) {
                    showSnackbar(context, "senha diferentes");
                    print("senha diferentes");
                  } else {
                    dialogs.information(
                        context, "preparando para o altera????o...");
                    Timer(Duration(seconds: 3), () {
                      print("Pessoa: ${p.tipoPessoa}");
                      print("Nome: ${p.nome}");
                      print("CPF: ${p.cpf}");
                      print("Telefone: ${p.telefone}");
                      print("DataRegistro: ${p.dataRegistro}");
                      print("Email: ${p.usuario.email}");
                      print("Senha: ${p.usuario.senha}");

                      vendedorController.update(p.id, p);
                      buildPush(context);
                    });
                  }
                }
              }
            },
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("J?? tem uma conta ? "),
              GestureDetector(
                child: Text(
                  "Entrar",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return UsuarioLoginPage();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  buildPush(BuildContext context) {
    Navigator.of(context).pop();
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendedorPage(),
      ),
    );
  }

  confirmaSenha() {
    print("senha diferentes");
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
