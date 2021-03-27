import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nosso/src/core/controller/endereco_controller.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/model/endereco.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/uploadFileResponse.dart';
import 'package:nosso/src/core/model/usuario.dart';
import 'package:nosso/src/paginas/loja/loja_page.dart';
import 'package:nosso/src/paginas/usuario/usuario_login_page.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/upload/upload_response.dart';
import 'package:nosso/src/util/validador/validador_pessoa.dart';

class LojaCreatePage extends StatefulWidget {
  Loja loja;

  LojaCreatePage({Key key, this.loja}) : super(key: key);

  @override
  _LojaCreatePageState createState() => _LojaCreatePageState(p: this.loja);
}

class _LojaCreatePageState extends State<LojaCreatePage> with ValidadorPessoa {
  _LojaCreatePageState({this.p});

  var lojaController = GetIt.I.get<LojaController>();
  var enderecoController = GetIt.I.get<EnderecoController>();

  Dialogs dialogs = Dialogs();

  Loja p;
  Endereco e;
  Usuario u;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime dataAtual = DateTime.now();
  String tipoPessoa;
  String valorSlecionado;
  File file;

  var uploadFileResponse = UploadFileResponse();
  var response = UploadRespnse();

  var senhaController = TextEditingController();
  var confirmaSenhaController = TextEditingController();

  @override
  void initState() {
    if (p == null) {
      p = Loja();
      u = Usuario();
      e = Endereco();
    } else {
      u = p.usuario;
      // enderecoController.enderecoSelecionado = p.enderecos[0];
    }

    tipoPessoa = "JURIDICA";
    super.initState();
  }

  Controller controller;

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  bool isEnabledEnviar = false;
  bool isEnabledDelete = false;

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
      var url = await lojaController.upload(file, p.foto);

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
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 50,
        title: p.nome == null ? Text("Cadastro de loja") : Text(p.nome),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: Card(
          child: Observer(
            builder: (context) {
              if (lojaController.dioError == null) {
                return buildListViewForm(context);
              } else {
                print("Erro: ${lojaController.mensagem}");
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

    var maskFormatterCNPJ = new MaskTextInputFormatter(
        mask: '##.###.###/###-##', filter: {"#": RegExp(r'[0-9]')});

    p.usuario = u;

    e = enderecoController.enderecoSelecionado;

    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text("faça seu cadastro, é rapido e seguro"),
            trailing: Icon(Icons.local_convenience_store_outlined),
          ),
        ),
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
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  print("Pessoa: " + p.tipoPessoa);
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        padding: EdgeInsets.all(0),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 500,
                              child: TextFormField(
                                initialValue: p.nome,
                                onSaved: (value) => p.nome = value,
                                validator: (value) => value.isEmpty
                                    ? "Preencha o nome fantazia"
                                    : null,
                                decoration: InputDecoration(
                                  labelText: "Nome fantazia",
                                  hintText: "nome",
                                  prefixIcon:
                                      Icon(Icons.people, color: Colors.grey),
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
                                initialValue: p.razaoSocial,
                                onSaved: (value) => p.razaoSocial = value,
                                validator: (value) => value.isEmpty
                                    ? "Preencha a razão social"
                                    : null,
                                decoration: InputDecoration(
                                  labelText: "Razão social ",
                                  hintText: "razão social",
                                  prefixIcon:
                                      Icon(Icons.people, color: Colors.grey),
                                  suffixIcon: Icon(Icons.close),
                                ),
                                onEditingComplete: () => focus.nextFocus(),
                                keyboardType: TextInputType.text,
                                maxLength: 50,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 100,
                        padding: EdgeInsets.all(0),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 500,
                              child: TextFormField(
                                initialValue: p.cnpj,
                                onSaved: (value) => p.cnpj = value,
                                validator: (value) =>
                                    value.isEmpty ? "Preencha o cnpj" : null,
                                decoration: InputDecoration(
                                  labelText: "Cnpj",
                                  hintText: "Cnpj",
                                  prefixIcon: Icon(Icons.contact_mail,
                                      color: Colors.grey),
                                  suffixIcon: Icon(Icons.close),
                                ),
                                onEditingComplete: () => focus.nextFocus(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [maskFormatterCNPJ],
                                maxLength: 17,
                              ),
                            ),
                            Container(
                              width: 500,
                              child: TextFormField(
                                initialValue: p.telefone,
                                onSaved: (value) => p.telefone = value,
                                validator: (value) => value.isEmpty
                                    ? "Preencha o telefone"
                                    : null,
                                decoration: InputDecoration(
                                  labelText: "Telefone",
                                  hintText: "Telefone celular",
                                  prefixIcon:
                                      Icon(Icons.phone, color: Colors.grey),
                                  suffixIcon: Icon(Icons.close),
                                ),
                                onEditingComplete: () => focus.nextFocus(),
                                keyboardType: TextInputType.phone,
                                inputFormatters: [maskFormatterCelular],
                                maxLength: 50,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
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
                    ],
                  ),
                ),

                Container(
                  height: 100,
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                              icon: lojaController.senhaVisivel == true
                                  ? Icon(Icons.visibility_outlined,
                                      color: Colors.grey)
                                  : Icon(Icons.visibility_off_outlined,
                                      color: Colors.grey),
                              onPressed: () {
                                lojaController.visualizarSenha();
                              },
                            ),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.text,
                          obscureText: !lojaController.senhaVisivel,
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
                              icon: lojaController.senhaVisivel == true
                                  ? Icon(Icons.visibility_outlined,
                                      color: Colors.grey)
                                  : Icon(Icons.visibility_off_outlined,
                                      color: Colors.grey),
                              onPressed: () {
                                lojaController.visualizarSenha();
                              },
                            ),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.text,
                          obscureText: !lojaController.senhaVisivel,
                          maxLength: 8,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // SizedBox(height: 0),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     DropDownEndereco(e),
                //     Observer(
                //       builder: (context) {
                //         if (enderecoController.enderecoSelecionado == null) {
                //           return Container(
                //             padding: EdgeInsets.only(left: 25),
                //             child: Container(
                //               child: enderecoController.mensagem == null
                //                   ? Text(
                //                       "campo obrigatório *",
                //                       style: TextStyle(
                //                         color: Colors.red,
                //                         fontSize: 12,
                //                       ),
                //                     )
                //                   : Text(
                //                       "${enderecoController.mensagem}",
                //                       style: TextStyle(
                //                         color: Colors.red,
                //                         fontSize: 12,
                //                       ),
                //                     ),
                //             ),
                //           );
                //         }
                //         return Container(
                //           padding: EdgeInsets.only(left: 25),
                //           child: Container(
                //             child:
                //                 Icon(Icons.check_outlined, color: Colors.green),
                //           ),
                //         );
                //       },
                //     ),
                //   ],
                // ),
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
                    if (senhaController.text != confirmaSenhaController.text) {
                      showSnackbar(context, "senha diferentes");
                      print("senha diferentes");
                    } else {
                      dialogs.information(
                          context, "prepando para o cadastro...");
                      Timer(Duration(seconds: 3), () {
                        print("Pessoa: ${p.tipoPessoa}");
                        print("Nome: ${p.nome}");
                        print("Rasão social: ${p.razaoSocial}");
                        print("Cnpj: ${p.cnpj}");
                        print("Telefone: ${p.telefone}");
                        // print("DataRegistro: ${p.dataRegistro}");
                        print("Email: ${p.usuario.email}");
                        print("Senha: ${p.usuario.senha}");

                        // p.enderecos.add(enderecoController.enderecoSelecionado);

                        lojaController.create(p).then((value) {
                          print("resultado : ${value}");
                        });
                        Navigator.of(context).pop();
                        buildPush(context);
                      });
                    }
                  } else {
                    if (senhaController.text != confirmaSenhaController.text) {
                      showSnackbar(context, "senha diferentes");
                      print("senha diferentes");
                    } else {
                      dialogs.information(
                          context, "preparando para o alteração...");
                      Timer(Duration(seconds: 3), () {
                        print("Pessoa: ${p.tipoPessoa}");
                        print("Nome: ${p.nome}");
                        print("Rasão social: ${p.razaoSocial}");
                        print("Cnpj: ${p.cnpj}");
                        print("Telefone: ${p.telefone}");
                        // print("DataRegistro: ${p.dataRegistro}");
                        print("Email: ${p.usuario.email}");
                        print("Senha: ${p.usuario.senha}");

                        p.enderecos.add(enderecoController.enderecoSelecionado);

                        lojaController.update(p.id, p);
                        Navigator.of(context).pop();
                        buildPush(context);
                      });
                    }
                  }
                }
              }),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Já tem uma conta ? "),
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
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LojaPage(),
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
