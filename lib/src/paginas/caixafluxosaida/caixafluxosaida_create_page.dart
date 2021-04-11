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
import 'package:nosso/src/core/controller/caixafluxosaida_controller.dart';
import 'package:nosso/src/core/controller/vendedor_controller.dart';
import 'package:nosso/src/core/model/caixafluxo.dart';
import 'package:nosso/src/core/model/caixasaida.dart';
import 'package:nosso/src/core/model/vendedor.dart';
import 'package:nosso/src/paginas/caixafluxosaida/caixafluxosaida_page.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';
import 'package:nosso/src/util/validador/validador_caixafluxo.dart';

class CaixaFluxoSaidaCreatePage extends StatefulWidget {
  CaixaFluxoSaida saida;

  CaixaFluxoSaidaCreatePage({Key key, this.saida}) : super(key: key);

  @override
  _CaixaFluxoSaidaCreatePageState createState() =>
      _CaixaFluxoSaidaCreatePageState(c: this.saida);
}

class _CaixaFluxoSaidaCreatePageState extends State<CaixaFluxoSaidaCreatePage>
    with ValidadorCaixaFluxo {
  _CaixaFluxoSaidaCreatePageState({this.c});

  var caixafluxosaidaController = GetIt.I.get<CaixafluxosaidaController>();
  var caixafluxoController = GetIt.I.get<CaixafluxoController>();
  var vendedorController = GetIt.I.get<VendedorController>();
  var dialogs = Dialogs();

  var saldoAnteriorController = TextEditingController();
  var valorEntradaController = TextEditingController();
  var valorSaidaController = TextEditingController();
  var valorTotalController = TextEditingController();

  CaixaFluxoSaida c;
  CaixaFluxo caixaFluxoSelecionado;
  Vendedor vendedorSelecionado;
  Controller controller;

  @override
  void initState() {
    if (c == null) {
      c = CaixaFluxoSaida();
    } else {
      caixaFluxoSelecionado = c.caixaFluxo;
      valorSaidaController.text = c.valorSaida.toStringAsFixed(2);
    }
    caixafluxoController.getAll();
    super.initState();
  }

  @override
  didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  builderConteudoListCaixaFluxos() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<CaixaFluxo> caixaFluxos = caixafluxoController.caixaFluxos;
          if (caixafluxoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (caixaFluxos == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<CaixaFluxo>(
            label: "Selecione fluxos do dia",
            popupTitle: Center(child: Text("Caixa Fluxos")),
            items: caixaFluxos,
            showSearchBox: true,
            itemAsString: (CaixaFluxo s) => s.descricao,
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: caixaFluxoSelecionado,
            onChanged: (CaixaFluxo l) {
              setState(() {
                c.caixaFluxo = l;
                print("fluxo: ${c.caixaFluxo.descricao}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por fluxo",
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
        title: Text("Caixa saídas cadastro"),
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(0),
                        width: double.infinity,
                        child: builderConteudoListCaixaFluxos(),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        initialValue: c.descricao,
                        onSaved: (value) => c.descricao = value,
                        validator: validateDescricao,
                        decoration: InputDecoration(
                          labelText: "Descrição do caixa",
                          border: OutlineInputBorder(
                            gapPadding: 0.0,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Descrição",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.credit_card),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 23,
                      ),
                      SizedBox(height: 10),

                      TextFormField(
                        controller: valorSaidaController,
                        validator: validateValorSaida,
                        onSaved: (value) {
                          c.valorSaida = double.tryParse(value);
                        },
                        decoration: InputDecoration(
                          labelText: "Valor saída",
                          hintText: "Valor saída",
                          prefixIcon: Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => valorSaidaController.clear(),
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
                      SizedBox(height: 10),
                      DateTimeField(
                        initialValue: c.dataRegistro != null
                            ? c.dataRegistro
                            : DateTime.now(),
                        format: dateFormat,
                        validator: validateDateRegsitro,
                        onSaved: (value) => c.dataRegistro = value,
                        decoration: InputDecoration(
                          labelText: "data registro",
                          hintText: "99-09-9999",
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
                        maxLength: 10,
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
                    caixafluxosaidaController.create(c).then((value) {
                      print("resultado : ${value}");
                    });
                    Navigator.of(context).pop();
                    buildPush(context);
                  });
                } else {
                  dialogs.information(
                      context, "preparando para o alteração...");
                  Timer(Duration(seconds: 3), () {
                    caixafluxosaidaController.update(c.id, c);
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
        builder: (context) => CaixaFluxoSaidaPage(),
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
