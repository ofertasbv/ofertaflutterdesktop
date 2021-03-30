import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:masked_text_input_formatter/masked_text_input_formatter.dart';
import 'package:nosso/src/core/controller/cidade_controller.dart';
import 'package:nosso/src/core/controller/endereco_controller.dart';
import 'package:nosso/src/core/controller/estado_controller.dart';
import 'package:nosso/src/core/model/cidade.dart';
import 'package:nosso/src/core/model/endereco.dart';
import 'package:nosso/src/core/model/estado.dart';
import 'package:nosso/src/paginas/endereco/endereco_page.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';
import 'package:nosso/src/util/validador/validador_endereco.dart';

class EnderecoCreatePage extends StatefulWidget {
  Endereco endereco;

  EnderecoCreatePage({Key key, this.endereco}) : super(key: key);

  @override
  _EnderecoCreatePageState createState() =>
      _EnderecoCreatePageState(e: endereco);
}

class _EnderecoCreatePageState extends State<EnderecoCreatePage>
    with ValidadorEndereco {
  var enderecoController = GetIt.I.get<EnderecoController>();
  var estadoController = GetIt.I.get<EstadoController>();
  var cidadeController = GetIt.I.get<CidadeController>();

  Dialogs dialogs = Dialogs();

  Endereco e;
  Estado estadoSelecionado;
  Cidade cidadeSelecionada;

  Future<List<Estado>> estados;
  Future<List<Cidade>> cidades;

  String tipoEndereco;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _EnderecoCreatePageState({this.e});

  @override
  void initState() {
    cidadeController.getAll();
    estados = estadoController.getAll();

    if (e == null) {
      e = Endereco();
      tipoEndereco = "COMERCIAL";
    } else {
      cidadeSelecionada = e.cidade;
      estadoSelecionado = cidadeSelecionada.estado;
    }
    super.initState();
  }

  Controller controller;

  @override
  didChangeDependencies() {
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

  builderConteudoListEstados() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Estado> estados = estadoController.estados;
          if (cidadeController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (estados == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Estado>(
            label: "Selecione estados",
            popupTitle: Center(child: Text("Estados")),
            items: estados,
            showSearchBox: true,
            itemAsString: (Estado s) => s.nome,
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: estadoSelecionado,
            onChanged: (Estado e) {
              estadoSelecionado = e;
              setState(() {
                cidadeController.getAllByEstadoId(estadoSelecionado.id);
                print("estado: ${estadoSelecionado.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por estado",
            ),
          );
        },
      ),
    );
  }

  builderConteudoListCiadades() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Cidade> cidades = cidadeController.cidades;
          if (cidadeController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (cidades == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Cidade>(
            label: "Selecione cidades",
            popupTitle: Center(child: Text("Cidades")),
            items: cidades,
            showSearchBox: true,
            itemAsString: (Cidade s) => s.nome,
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: cidadeSelecionada,
            onChanged: (Cidade m) {
              setState(() {
                e.cidade = m;
                print("cidade: ${e.cidade.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por cidade",
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        titleSpacing: 50,
        elevation: 0,
        title: e.logradouro == null
            ? Text("Cadastro de endereço")
            : Text(e.logradouro),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: Card(
          child: Observer(
            builder: (context) {
              if (enderecoController.dioError == null) {
                return buildListViewForm(context);
              } else {
                print("Erro: ${enderecoController.mensagem}");
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
    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text("seu endereço, é rapido e seguro"),
            trailing: Icon(Icons.location_on_outlined),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15),
                        Text("Tipo de endereço"),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("COMERCIAL"),
                              value: "COMERCIAL",
                              groupValue: e.tipoEndereco == null
                                  ? tipoEndereco
                                  : e.tipoEndereco,
                              onChanged: (String valor) {
                                setState(() {
                                  e.tipoEndereco = valor;
                                  print("resultado: " + e.tipoEndereco);
                                });
                              },
                            ),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("RESIDENCIAL"),
                              value: "RESIDENCIAL",
                              groupValue: e.tipoEndereco == null
                                  ? tipoEndereco
                                  : e.tipoEndereco,
                              onChanged: (String valor) {
                                setState(() {
                                  e.tipoEndereco = valor;
                                  print("resultado: " + e.tipoEndereco);
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
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        initialValue: e.logradouro,
                        onSaved: (value) => e.logradouro = value,
                        validator: validateLogradouro,
                        decoration: InputDecoration(
                          labelText: "Logradouro",
                          hintText: "Logradouro",
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 255,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          initialValue: e.complemento,
                          onSaved: (value) => e.complemento = value,
                          validator: validateComplemento,
                          decoration: InputDecoration(
                            labelText: "Complemento",
                            hintText: "Complemento",
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                        ),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          initialValue: e.numero,
                          onSaved: (value) => e.numero = value,
                          validator: validateNumero,
                          decoration: InputDecoration(
                            labelText: "Número",
                            hintText: "Número",
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.text,
                          maxLength: 10,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          initialValue: e.cep,
                          onSaved: (value) => e.cep = value,
                          validator: validateCep,
                          decoration: InputDecoration(
                            labelText: "Cep",
                            hintText: "Cep",
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            MaskedTextInputFormatter(
                                mask: '99999-999', separator: '-')
                          ],
                          maxLength: 9,
                        ),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          initialValue: e.bairro,
                          onSaved: (value) => e.bairro = value,
                          validator: validateBairro,
                          decoration: InputDecoration(
                            labelText: "Bairro",
                            hintText: "Bairro",
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          initialValue: e.latitude.toString(),
                          onSaved: (value) =>
                              e.latitude = double.tryParse(value),
                          validator: validateLatitude,
                          decoration: InputDecoration(
                            labelText: "Latitude",
                            hintText: "Latidute",
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          maxLength: 50,
                        ),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          initialValue: e.longitude.toString(),
                          onSaved: (value) =>
                              e.longitude = double.tryParse(value),
                          validator: validateLongitude,
                          decoration: InputDecoration(
                            labelText: "Longitude",
                            hintText: "Longitude",
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          maxLength: 50,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListEstados(),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListCiadades(),
                      )
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
                if (e.id == null) {
                  dialogs.information(context, "prepando para o cadastro...");
                  Timer(Duration(seconds: 3), () {
                    print("Logradouro: ${e.logradouro}");
                    print("Complemento: ${e.complemento}");
                    print("Bairro: ${e.bairro}");
                    print("Numero: ${e.numero}");
                    print("Cep: ${e.cep}");
                    print("Cidade: ${e.cidade.nome}");

                    print("Latitude: ${e.latitude}");
                    print("Longitude: ${e.longitude}");

                    enderecoController.create(e).then((value) {
                      print("resultado : ${value}");
                    });
                    buildPush(context);
                  });
                } else {
                  dialogs.information(
                      context, "preparando para o alteração...");
                  Timer(Duration(seconds: 3), () {
                    print("Logradouro: ${e.logradouro}");
                    print("Complemento: ${e.complemento}");
                    print("Bairro: ${e.bairro}");
                    print("Numero: ${e.numero}");
                    print("Cep: ${e.cep}");
                    print("Cidade: ${e.cidade.nome}");

                    print("Latitude: ${e.latitude}");
                    print("Longitude: ${e.longitude}");

                    enderecoController.update(e.id, e).then((value) {
                      print("resultado : ${value}");
                    });
                    buildPush(context);
                  });
                }
              }
            },
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
        builder: (context) => EnderecoPage(),
      ),
    );
  }

  /* ============== ESTADO LISTA ============== */

  alertSelectEstados(BuildContext context, Estado c) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: builderConteudoListEstados(),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("ok"),
            )
          ],
        );
      },
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
