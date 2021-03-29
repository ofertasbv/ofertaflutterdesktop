import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nosso/src/core/controller/caixafluxo_controller.dart';
import 'package:nosso/src/core/controller/caixafluxoentrada_controller.dart';
import 'package:nosso/src/core/controller/pedido_controller.dart';
import 'package:nosso/src/core/controller/vendedor_controller.dart';
import 'package:nosso/src/core/model/caixaentrada.dart';
import 'package:nosso/src/core/model/caixafluxo.dart';
import 'package:nosso/src/core/model/pedido.dart';
import 'package:nosso/src/core/model/vendedor.dart';
import 'package:nosso/src/paginas/caixafluxoentrada/caixafluxoentrada_page.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/dropdown/dropdown_vendedor.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';
import 'package:nosso/src/util/validador/validador_caixafluxo.dart';

class CaixaFluxoEntradaCreatePage extends StatefulWidget {
  CaixaFluxoEntrada entrada;

  CaixaFluxoEntradaCreatePage({Key key, this.entrada}) : super(key: key);

  @override
  _CaixaFluxoEntradaCreatePageState createState() =>
      _CaixaFluxoEntradaCreatePageState(c: this.entrada);
}

class _CaixaFluxoEntradaCreatePageState
    extends State<CaixaFluxoEntradaCreatePage> with ValidadorCaixaFluxo {
  _CaixaFluxoEntradaCreatePageState({this.c});

  var caixafluxoentradaController = GetIt.I.get<CaixafluxoentradaController>();
  var caixafluxoController = GetIt.I.get<CaixafluxoController>();
  var pedidoController = GetIt.I.get<PedidoController>();

  var dialogs = Dialogs();

  var saldoAnteriorController = TextEditingController();
  var valorEntradaController = TextEditingController();
  var valorSaidaController = TextEditingController();
  var valorTotalController = TextEditingController();

  CaixaFluxoEntrada c;
  CaixaFluxo caixaFluxo;
  Vendedor vendedorSelecionado;
  Pedido pedidoSelecionado;
  Controller controller;

  @override
  void initState() {
    if (c == null) {
      c = CaixaFluxoEntrada();
    }else{
      pedidoSelecionado = c.pedido;
      valorEntradaController.text = c.valorEntrada.toStringAsFixed(2);
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
            return Text("Não foi possível buscar permissões");
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
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: pedidoSelecionado,
            onChanged: (Pedido l) {
              setState(() {
                c.pedido = l;
                print("pedido: ${c.pedido.descricao}");
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
        title: Text("Caixa entrada cadastro"),
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
              if (caixafluxoController.dioError == null) {
                return buildListViewForm(context);
              } else {
                print("Erro: ${caixafluxoController.mensagem}");
                return buildListViewForm(context);
              }
            },
          ),
        ),
      ),
    );
  }

  buildListViewForm(BuildContext context) {
    var dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    var maskFormatterNumero = new MaskTextInputFormatter(
        mask: '####-####-####-####', filter: {"#": RegExp(r'[0-9]')});
    var focus = FocusScope.of(context);

    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text("Dados do fluxo de caixa"),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15),
          child: Container(
            height: 200,
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor
                ],
              ),
              border: Border.all(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text("FLUXO DE CAIXA"),
                      Icon(Icons.vpn_key_outlined),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text(
                        "${dateFormat.format(DateTime.now())}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.calculate_outlined),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text("CAIXA 01 - PC01"),
                      Icon(Icons.computer),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 0),
        Container(
          padding: EdgeInsets.all(5),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  child: builderConteudoListPedidos(),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 0),
                      TextFormField(
                        initialValue: c.descricao,
                        onSaved: (value) => c.descricao = value,
                        validator: validateDescricao,
                        decoration: InputDecoration(
                          labelText: "Descrição da entrada",
                          border: OutlineInputBorder(
                            gapPadding: 0.0,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Descrição",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.credit_card),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatterNumero],
                        maxLength: 23,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: valorEntradaController,
                        validator: validateValorEntrada,
                        onSaved: (value) {
                          c.valorEntrada = double.tryParse(value);
                        },
                        decoration: InputDecoration(
                          labelText: "Valor entrada",
                          hintText: "Valor entrada",
                          prefixIcon: Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => valorEntradaController.clear(),
                            icon: Icon(Icons.clear),
                          ),
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
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: false),
                        maxLength: 6,
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
          padding: EdgeInsets.all(20),
          child: RaisedButton.icon(
            label: Text("Enviar formulário"),
            icon: Icon(Icons.check),
            onPressed: () {
              if (controller.validate()) {
                if (c.id == null) {
                  dialogs.information(context, "prepando para o cadastro...");
                  Timer(Duration(seconds: 3), () {
                    caixafluxoentradaController.create(c).then((value) {
                      print("resultado : ${value}");
                    });
                    Navigator.of(context).pop();
                    buildPush(context);
                  });
                } else {
                  dialogs.information(
                      context, "preparando para o alteração...");
                  Timer(Duration(seconds: 3), () {
                    caixafluxoentradaController.update(c.id, c);
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
        builder: (context) => CaixaFluxoEntradaPage(),
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
