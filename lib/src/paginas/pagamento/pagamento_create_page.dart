import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nosso/src/core/controller/pagamento_controller.dart';
import 'package:nosso/src/core/model/pagamento.dart';
import 'package:nosso/src/paginas/pagamento/pagamento_page.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/steps/step_menu_etapa.dart';
import 'package:nosso/src/util/validador/validador_pagamento.dart';
import 'package:steps/steps.dart';

class PagamentoCreatePage extends StatefulWidget {
  Pagamento pagamento;

  PagamentoCreatePage({Key key, this.pagamento}) : super(key: key);

  @override
  _PagamentoCreatePageState createState() =>
      _PagamentoCreatePageState(p: this.pagamento);
}

class _PagamentoCreatePageState extends State<PagamentoCreatePage>
    with ValidadorPagamento {
  _PagamentoCreatePageState({this.p});

  var pagamentoController = GetIt.I.get<PagamentoController>();
  var dialogs = Dialogs();

  var quantidadeController = TextEditingController();
  var valorTotalController = TextEditingController();

  Pagamento p;
  Controller controller;
  String pagamentoForma;

  @override
  void initState() {
    if (p == null) {
      p = Pagamento();
    }
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 50,
        title: Text("Pagamento cadastro"),
        actions: <Widget>[
          SizedBox(width: 20),
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {
              showSearch(context: context, delegate: ProdutoSearchDelegate());
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: Observer(
          builder: (context) {
            if (pagamentoController.dioError == null) {
              return buildListViewForm(context);
            } else {
              print("Erro: ${pagamentoController.mensagem}");
              showToast("${pagamentoController.mensagem}");
              return buildListViewForm(context);
            }
          },
        ),
      ),
    );
  }

  buildListViewForm(BuildContext context) {
    var dateFormat = DateFormat('dd/MM/yyyy');
    var maskFormatterNumero = new MaskTextInputFormatter(
        mask: '####-####-####-####', filter: {"#": RegExp(r'[0-9]')});
    var focus = FocusScope.of(context);

    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text("Dados de pagamento"),
            trailing: Icon(Icons.credit_card),
          ),
        ),
        SizedBox(height: 10),
        StepMenuEtapa(
          colorPedido: Colors.orangeAccent,
          colorPagamento: Colors.grey,
          colorConfirmacao: Colors.orangeAccent,
        ),
        SizedBox(height: 0),
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
                        controller: quantidadeController,
                        onSaved: (value) {
                          p.quantidade = int.tryParse(value);
                        },
                        validator: validateQuantidade,
                        decoration: InputDecoration(
                          labelText: "Quantidade",
                          border: OutlineInputBorder(
                            gapPadding: 0.0,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Quantidade",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.confirmation_number_outlined),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatterNumero],
                        maxLength: 23,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: valorTotalController,
                        onSaved: (value) {
                          p.valor = double.tryParse(value);
                        },
                        validator: validateValorTotal,
                        decoration: InputDecoration(
                          labelText: "Valor total",
                          border: OutlineInputBorder(
                            gapPadding: 0.0,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "valor total",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.monetization_on_outlined),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatterNumero],
                        maxLength: 23,
                      ),
                      SizedBox(height: 10),
                      DateTimeField(
                        initialValue: p.dataPagamento,
                        format: dateFormat,
                        validator: validateDataPagamento,
                        onSaved: (value) => p.dataPagamento = value,
                        decoration: InputDecoration(
                          labelText: "Data de validade",
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            locale: Locale('pt', 'BR'),
                            lastDate: DateTime(2030),
                          );
                        },
                        keyboardType: TextInputType.datetime,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Forma de pagamento"),
                    RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text("DINHEIRO/ESPÉCIE"),
                      value: "DINHEIRO",
                      groupValue: pagamentoForma,
                      secondary: const Icon(Icons.monetization_on_outlined),
                      onChanged: (String valor) {
                        setState(() {
                          pagamentoForma = valor;
                          print("Pagamento: " + pagamentoForma);
                        });
                      },
                    ),
                    RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text("BOLETO BANCÁRIO"),
                      value: "BOLETO_BANCARIO",
                      groupValue: pagamentoForma,
                      secondary: const Icon(Icons.picture_as_pdf_outlined),
                      onChanged: (String valor) {
                        setState(() {
                          pagamentoForma = valor;
                          print("Pagamento: " + pagamentoForma);
                        });
                      },
                    ),
                    RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text("TRANSFERÊNCIA BANCÁRIA"),
                      value: "TRANSFERENCIA_BANCARIA",
                      groupValue: pagamentoForma,
                      secondary: const Icon(Icons.atm_outlined),
                      onChanged: (String valor) {
                        setState(() {
                          pagamentoForma = valor;
                          print("Pagamento: " + pagamentoForma);
                        });
                      },
                    ),
                    RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text("CARTÃO DE CRÉDIDO"),
                      value: "CARTAO_CREDITO",
                      groupValue: pagamentoForma,
                      secondary: const Icon(Icons.credit_card),
                      onChanged: (String valor) {
                        setState(() {
                          pagamentoForma = valor;
                          print("Pagamento: " + pagamentoForma);
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
          padding: EdgeInsets.all(15),
          child: RaisedButton.icon(
            label: Text("Enviar formulário"),
            icon: Icon(Icons.check),
            onPressed: () {
              if (controller.validate()) {
                if (p.id == null) {
                  dialogs.information(context, "prepando para o cadastro...");
                  Timer(Duration(seconds: 3), () {
                    pagamentoController.create(p).then((value) {
                      print("resultado : ${value}");
                    });
                    Navigator.of(context).pop();
                    buildPush(context);
                  });
                } else {
                  dialogs.information(
                      context, "preparando para o alteração...");
                  Timer(Duration(seconds: 3), () {
                    pagamentoController.update(p.id, p);
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
        builder: (context) => PagamentoPage(),
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
