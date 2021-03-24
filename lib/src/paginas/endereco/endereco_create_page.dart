import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      _EnderecoCreatePageState(endereco: endereco);
}

class _EnderecoCreatePageState extends State<EnderecoCreatePage>
    with ValidadorEndereco {
  var enderecoController = GetIt.I.get<EnderecoController>();
  var estadoController = GetIt.I.get<EstadoController>();
  var cidadeController = GetIt.I.get<CidadeController>();

  Dialogs dialogs = Dialogs();

  Endereco endereco;
  Estado estadoSelecionado;
  Cidade cidadeSelecionada;

  Future<List<Estado>> estados;
  Future<List<Cidade>> cidades;

  File file;
  bool isButtonDesable = false;

  String tipoEndereco;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _EnderecoCreatePageState({this.endereco});

  var controllerNome = TextEditingController();
  var latitudeController = TextEditingController();
  var longitudeController = TextEditingController();

  var controllerDestino = TextEditingController();
  var controllerLogradouro = TextEditingController();
  var controllerNumero = TextEditingController();
  var controllerBairro = TextEditingController();
  var controllerCidade = TextEditingController();
  var controllerCep = TextEditingController();
  var controllerLatitude = TextEditingController();
  var controllerLongitude = TextEditingController();

  @override
  void initState() {
    cidadeController.getAll();
    estados = estadoController.getAll();

    if (endereco == null) {
      endereco = Endereco();
    } else {
      cidadeSelecionada = endereco.cidade;
      estadoSelecionado = cidadeSelecionada.estado;
    }

    tipoEndereco = "COMERCIAL";
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
                print("cidade: ${m.nome}");
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
        title: endereco.logradouro == null
            ? Text("Cadastro de endereço")
            : Text(endereco.logradouro),
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
                        Text("Tipo de endereço"),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("COMERCIAL"),
                              value: "COMERCIAL",
                              groupValue: endereco.tipoEndereco == null
                                  ? tipoEndereco
                                  : endereco.tipoEndereco,
                              onChanged: (String valor) {
                                setState(() {
                                  endereco.tipoEndereco = valor;
                                  print("resultado: " + endereco.tipoEndereco);
                                });
                              },
                            ),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("RESIDENCIAL"),
                              value: "RESIDENCIAL",
                              groupValue: endereco.tipoEndereco == null
                                  ? tipoEndereco
                                  : endereco.tipoEndereco,
                              onChanged: (String valor) {
                                setState(() {
                                  endereco.tipoEndereco = valor;
                                  print("resultado: " + endereco.tipoEndereco);
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
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        initialValue: endereco.logradouro,
                        onSaved: (value) => endereco.logradouro = value,
                        validator: validateLogradouro,
                        decoration: InputDecoration(
                          labelText: "Logradouro",
                          hintText: "Logradouro",
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 255,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                  initialValue: endereco.complemento,
                  onSaved: (value) => endereco.complemento = value,
                  validator: validateComplemento,
                  decoration: InputDecoration(
                    labelText: "Complemento",
                    hintText: "Complemento",
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[900]),
                      gapPadding: 1,
                      borderRadius: BorderRadius.circular(5.0),
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
                  initialValue: endereco.numero,
                  onSaved: (value) => endereco.numero = value,
                  validator: validateNumero,
                  decoration: InputDecoration(
                    labelText: "Número",
                    hintText: "Número",
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[900]),
                      gapPadding: 1,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onEditingComplete: () => focus.nextFocus(),
                  keyboardType: TextInputType.number,
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
                  initialValue: endereco.cep,
                  onSaved: (value) => endereco.cep = value,
                  validator: validateCep,
                  decoration: InputDecoration(
                    labelText: "Cep",
                    hintText: "Cep",
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[900]),
                      gapPadding: 1,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onEditingComplete: () => focus.nextFocus(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    MaskedTextInputFormatter(mask: '99999-999', separator: '-')
                  ],
                  maxLength: 9,
                ),
              ),
              Container(
                width: 500,
                color: Colors.grey[200],
                child: TextFormField(
                  initialValue: endereco.bairro,
                  onSaved: (value) => endereco.bairro = value,
                  validator: validateBairro,
                  decoration: InputDecoration(
                    labelText: "Bairro",
                    hintText: "Bairro",
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[900]),
                      gapPadding: 1,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
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
                  initialValue: endereco.latitude.toString(),
                  onSaved: (value) =>
                      endereco.latitude = double.tryParse(value),
                  validator: validateLatitude,
                  decoration: InputDecoration(
                    labelText: "Latitude",
                    hintText: "Latidute",
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[900]),
                      gapPadding: 1,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onEditingComplete: () => focus.nextFocus(),
                  keyboardType: TextInputType.numberWithOptions(),
                  maxLength: 50,
                ),
              ),
              Container(
                width: 500,
                color: Colors.grey[200],
                child: TextFormField(
                  initialValue: endereco.longitude.toString(),
                  onSaved: (value) =>
                      endereco.longitude = double.tryParse(value),
                  validator: validateLongitude,
                  decoration: InputDecoration(
                    labelText: "Longitude",
                    hintText: "Longitude",
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[900]),
                      gapPadding: 1,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onEditingComplete: () => focus.nextFocus(),
                  keyboardType: TextInputType.numberWithOptions(),
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
        SizedBox(height: 0),
        Container(
          padding: EdgeInsets.all(15),
          child: RaisedButton.icon(
            label: Text("Enviar formulário"),
            icon: Icon(Icons.check),
            onPressed: () {
              if (controller.validate()) {
                if (endereco.id == null) {
                  dialogs.information(context, "prepando para o cadastro...");
                  Timer(Duration(seconds: 3), () {
                    print("Logradouro: ${endereco.logradouro}");
                    print("Complemento: ${endereco.complemento}");
                    print("Bairro: ${endereco.bairro}");
                    print("Numero: ${endereco.numero}");
                    print("Cep: ${endereco.cep}");
                    print("Cidade: ${endereco.cidade}");

                    print("Latitude: ${endereco.latitude}");
                    print("Longitude: ${endereco.longitude}");

                    enderecoController.create(endereco).then((value) {
                      print("resultado : ${value}");
                    });
                    buildPush(context);
                  });
                } else {
                  dialogs.information(
                      context, "preparando para o alteração...");
                  Timer(Duration(seconds: 3), () {
                    print("Logradouro: ${endereco.logradouro}");
                    print("Complemento: ${endereco.complemento}");
                    print("Bairro: ${endereco.bairro}");
                    print("Numero: ${endereco.numero}");
                    print("Cep: ${endereco.cep}");
                    print("Cidade: ${endereco.cidade}");

                    print("Latitude: ${endereco.latitude}");
                    print("Longitude: ${endereco.longitude}");

                    enderecoController
                        .update(endereco.id, endereco)
                        .then((value) {
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
