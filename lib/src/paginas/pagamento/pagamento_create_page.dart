import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nosso/src/core/controller/pagamento_controller.dart';
import 'package:nosso/src/core/controller/pedido_controller.dart';
import 'package:nosso/src/core/model/pagamento.dart';
import 'package:nosso/src/core/model/pedido.dart';
import 'package:nosso/src/paginas/pagamento/pagamento_page.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';
import 'package:nosso/src/util/steps/step_menu_etapa.dart';
import 'package:nosso/src/util/validador/validador_pagamento.dart';

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
  var pedidoController = GetIt.I.get<PedidoController>();
  var dialogs = Dialogs();

  var quantidadeController = TextEditingController();
  var valorTotalController = TextEditingController();

  Pagamento p;
  Controller controller;
  String pagamentoForma;
  Pedido pedidoSelecionado;

  @override
  void initState() {
    if (p == null) {
      p = Pagamento();
    } else {
      pedidoSelecionado = p.pedido;
      quantidadeController.text = p.quantidade.toStringAsFixed(0);
      valorTotalController.text = p.valor.toStringAsFixed(2);
    }
    pedidoController.getAll();
    super.initState();
  }

  @override
  didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  builderConteudoListPedidos() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Pedido> pedidos = pedidoController.pedidos;
          if (pedidoController.error != null) {
            return Text("N??o foi poss??vel buscar permiss??es");
          }

          if (pedidos == null) {
            return Center(
              child: CircularProgressorMini(),
            );
          }

          return DropdownSearch<Pedido>(
            label: "Selecione pedidos",
            popupTitle: Center(child: Text("Pedidos")),
            items: pedidos,
            showSearchBox: true,
            itemAsString: (Pedido s) => s.descricao,
            validator: (value) => value == null ? "campo obrigat??rio" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: pedidoSelecionado,
            onChanged: (Pedido l) {
              setState(() {
                p.pedido = l;
                print("pedido: ${p.pedido.descricao}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por pedido",
            ),
          );
        },
      ),
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
        child: Card(
          child: Observer(
            builder: (context) {
              if (pagamentoController.dioError == null) {
                return buildListViewForm(context);
              } else {
                print("Erro: ${pagamentoController.mensagem}");
                return buildListViewForm(context);
              }
            },
          ),
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
                          hintText: "Quantidade",
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
                          hintText: "valor total",
                          prefixIcon: Icon(Icons.monetization_on_outlined),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.number,
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
          height: 100,
          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: builderConteudoListPedidos(),
        ),
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
                      title: Text("DINHEIRO/ESP??CIE"),
                      value: "DINHEIRO",
                      groupValue: p.pagamentoForma == null
                          ? p.pagamentoForma = pagamentoForma
                          : p.pagamentoForma,
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
                      title: Text("BOLETO BANC??RIO"),
                      value: "BOLETO_BANCARIO",
                      groupValue: p.pagamentoForma == null
                          ? p.pagamentoForma = pagamentoForma
                          : p.pagamentoForma,
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
                      title: Text("TRANSFER??NCIA BANC??RIA"),
                      value: "TRANSFERENCIA_BANCARIA",
                      groupValue: p.pagamentoForma == null
                          ? p.pagamentoForma = pagamentoForma
                          : p.pagamentoForma,
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
                      title: Text("CART??O DE CR??DIDO"),
                      value: "CARTAO_CREDITO",
                      groupValue: p.pagamentoForma == null
                          ? p.pagamentoForma = pagamentoForma
                          : p.pagamentoForma,
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
            label: Text("Enviar formul??rio"),
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
                      context, "preparando para o altera????o...");
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
