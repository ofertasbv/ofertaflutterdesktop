import 'dart:async';
import 'dart:core';
import 'dart:io';

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
    enderecoController.getAll();
    estados = estadoController.getAll();

    if (endereco == null) {
      endereco = Endereco();
    } else {
      controllerDestino.text = endereco.logradouro;
      controllerNumero.text = endereco.numero;
      controllerCep.text = endereco.cep;
      controllerBairro.text = endereco.bairro;
      controllerLatitude.text = endereco.latitude.toString();
      controllerLongitude.text = endereco.longitude.toString();
    }

    tipoEndereco = "COMERCIAL";
    cidadeSelecionada = endereco.cidade;
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

  criaMapa() {
    return Container(
      height: 600,
      child: GoogleMap(
        onTap: (valor) {
          print("Lat: ${valor.latitude}, Long: ${valor.longitude}");
          setState(() {
            valor != null
                ? latitudeController.text = valor.latitude.toString()
                : latitudeController.text = endereco.latitude.toString();
            valor != null
                ? longitudeController.text = valor.longitude.toString()
                : longitudeController.text = endereco.longitude.toString();
          });
        },
        indoorViewEnabled: true,
        mapToolbarEnabled: true,
        buildingsEnabled: true,
        tiltGesturesEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        rotateGesturesEnabled: true,
        trafficEnabled: false,
        mapType: MapType.satellite,
        initialCameraPosition: CameraPosition(
          target: LatLng(-4.253467, -49.944051),
          zoom: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: endereco.logradouro == null
            ? Text("Cadastro de endereço")
            : Text(endereco.logradouro),
      ),
      body: Observer(
        builder: (context) {
          if (enderecoController.dioError == null) {
            return buildListViewForm(context);
          } else {
            print("Erro: ${enderecoController.mensagem}");
            showToast("${enderecoController.mensagem}");
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
                      SizedBox(height: 10),
                      TextFormField(
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
                        maxLength: 50,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controllerNumero,
                        onSaved: (value) => endereco.numero = value,
                        validator: validateNumero,
                        decoration: InputDecoration(
                          labelText: "Número",
                          hintText: "Número",
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
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controllerCep,
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
                          MaskedTextInputFormatter(
                              mask: '99999-999', separator: '-')
                        ],
                        maxLength: 9,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controllerBairro,
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
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controllerLatitude,
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
                        readOnly: true,
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.numberWithOptions(),
                        maxLength: 50,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controllerLongitude,
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
                        readOnly: true,
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.numberWithOptions(),
                        maxLength: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              title: Text("Estado *"),
              subtitle: estadoSelecionado == null
                  ? Text("Selecione uma estado")
                  : Text(estadoSelecionado.nome),
              leading: Icon(Icons.list_alt_outlined),
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onTap: () {
                alertSelectEstados(context, estadoSelecionado);
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              title: Text("Cidade *"),
              subtitle: cidadeSelecionada == null
                  ? Text("Selecione uma cidade")
                  : Text(cidadeSelecionada.nome),
              leading: Icon(Icons.list_alt_outlined),
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onTap: () {
                alertSelectCidades(context, cidadeSelecionada);
              },
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
                if (endereco.id == null) {
                  dialogs.information(context, "prepando para o cadastro...");
                  Timer(Duration(seconds: 3), () {
                    print("Latitude: ${endereco.latitude}");
                    print("Longitude: ${endereco.longitude}");

                    endereco.cidade = cidadeSelecionada;
                    enderecoController.create(endereco).then((value) {
                      print("resultado : ${value}");
                    });
                    buildPush(context);
                  });
                } else {
                  dialogs.information(
                      context, "preparando para o alteração...");
                  Timer(Duration(seconds: 3), () {
                    print("Latitude: ${endereco.latitude}");
                    print("Longitude: ${endereco.longitude}");

                    endereco.cidade = cidadeSelecionada;
                    enderecoController.update(endereco.id, endereco);

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

          return builderListEstados(estados);
        },
      ),
    );
  }

  builderListEstados(List<Estado> estados) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: estados.length,
      itemBuilder: (context, index) {
        Estado c = estados[index];

        return Column(
          children: [
            GestureDetector(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.location_on_outlined),
                ),
                title: Text(c.nome),
              ),
              onTap: () {
                setState(() {
                  estadoSelecionado = c;
                  cidadeController.getAllByEstadoId(estadoSelecionado.id);
                  print("${estadoSelecionado.nome}");
                });
                Navigator.of(context).pop();
              },
            ),
            Divider()
          ],
        );
      },
    );
  }

  /* ============== CIDADE LISTA ============== */

  alertSelectCidades(BuildContext context, Cidade c) {
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
            child: builderConteudoListCidades(),
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

  builderConteudoListCidades() {
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

          return builderListCidades(cidades);
        },
      ),
    );
  }

  builderListCidades(List<Cidade> cidades) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: cidades.length,
      itemBuilder: (context, index) {
        Cidade c = cidades[index];

        return Column(
          children: [
            GestureDetector(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.location_on_outlined),
                ),
                title: Text(c.nome),
              ),
              onTap: () {
                setState(() {
                  cidadeSelecionada = c;
                  print("${cidadeSelecionada.nome}");
                });
                Navigator.of(context).pop();
              },
            ),
            Divider()
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
