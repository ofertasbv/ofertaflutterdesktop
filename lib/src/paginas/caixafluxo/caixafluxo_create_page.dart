import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nosso/src/core/controller/caixa_controller.dart';
import 'package:nosso/src/core/controller/caixafluxo_controller.dart';
import 'package:nosso/src/core/controller/vendedor_controller.dart';
import 'package:nosso/src/core/model/caixa.dart';
import 'package:nosso/src/core/model/caixafluxo.dart';
import 'package:nosso/src/core/model/vendedor.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_page.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';
import 'package:nosso/src/util/validador/validador_caixafluxo.dart';

class CaixaFluxoCreatePage extends StatefulWidget {
  CaixaFluxo caixaFluxo;
  Caixa caixa;

  CaixaFluxoCreatePage({Key key, this.caixaFluxo, this.caixa})
      : super(key: key);

  @override
  _CaixaFluxoCreatePageState createState() =>
      _CaixaFluxoCreatePageState(c: this.caixaFluxo, caixa: this.caixa);
}

class _CaixaFluxoCreatePageState extends State<CaixaFluxoCreatePage>
    with ValidadorCaixaFluxo {
  _CaixaFluxoCreatePageState({this.c, this.caixa});

  var caixafluxoController = GetIt.I.get<CaixafluxoController>();
  var caixaController = GetIt.I.get<CaixaController>();
  var vendedorController = GetIt.I.get<VendedorController>();
  var dialogs = Dialogs();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var saldoAnteriorController = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
    precision: 2,
  );
  var valorEntradaController = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
    precision: 2,
  );
  var valorSaidaController = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
    precision: 2,
  );
  var valorTotalController = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
    precision: 2,
  );

  var saldoController = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
    precision: 2,
  );

  CaixaFluxo c;
  Caixa caixa;
  bool status;
  Caixa caixaSelecionado;
  Vendedor vendedorSelecionado;
  Controller controller;

  @override
  void initState() {
    if (c == null) {
      c = CaixaFluxo();
      status = false;
    } else {
      status = c.status;

      caixaSelecionado = c.caixa;
      vendedorSelecionado = c.vendedor;

      saldoAnteriorController.text = c.saldoAnterior.toStringAsFixed(2);
      valorEntradaController.text = c.valorEntrada.toStringAsFixed(2);
      valorSaidaController.text = c.valorSaida.toStringAsFixed(2);
      valorTotalController.text = c.valorTotal.toStringAsFixed(2);
    }
    caixaController.getAll();
    vendedorController.getAll();
    super.initState();
  }

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

  verificaCaixaStatus(bool status) {
    if (status == true) {
      this.c.caixaStatus = "ABERTO";
    } else {
      this.c.caixaStatus = "FECHADO";
    }
  }

  builderConteudoListCaixas() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Caixa> caixas = caixaController.caixas;
          if (caixaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (caixas == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Caixa>(
            label: "Selecione caixas",
            popupTitle: Center(child: Text("Caixas")),
            items: caixas,
            showSearchBox: true,
            itemAsString: (Caixa s) => s.descricao,
            validator: (categoria) =>
                categoria == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: caixaSelecionado,
            onChanged: (Caixa caixa) {
              setState(() {
                c.caixa = caixa;
                print("Caixa: ${c.caixa.descricao}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por caixa",
            ),
          );
        },
      ),
    );
  }

  builderConteudoListVendedores() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Vendedor> vendedores = vendedorController.vendedores;
          if (vendedorController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (vendedores == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Vendedor>(
            label: "Selecione vendedores",
            popupTitle: Center(child: Text("Vendedores")),
            items: vendedores,
            showSearchBox: true,
            itemAsString: (Vendedor s) => s.nome,
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: vendedorSelecionado,
            onChanged: (Vendedor vendedor) {
              setState(() {
                c.vendedor = vendedor;
                print("Vendedor: ${c.vendedor.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por vendedor",
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
        title: Text("Caixa Fluxo cadastro"),
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
          ),
          SizedBox(width: 100),
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
    var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

    var focus = FocusScope.of(context);

    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text("Fluxo de caixa"),
            subtitle: caixa == null
                ? Text("CAIXA SEM STATUS")
                : Text("${caixa.descricao} - ${caixa.referencia}"),
            trailing: Text("${dateFormat.format(DateTime.now())}"),
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
                  height: 100,
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListCaixas(),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListVendedores(),
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
                          controller: valorEntradaController,
                          decoration:
                              InputDecoration(labelText: 'Valor entrada'),
                          onChanged: (value) {
                            value = valorEntradaController.text;
                            print("Valor entrada: ${value}");
                          },
                          onSaved: (value) {
                            valorEntradaController.updateValue(0);
                          },
                        ),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          controller: valorTotalController,
                          decoration: InputDecoration(labelText: 'Valor total'),
                          onChanged: (value) {
                            value = valorTotalController.text;
                            print("Valor total: ${value}");
                          },
                          onSaved: (value) {
                            valorTotalController.updateValue(0);
                          },
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
                          controller: saldoAnteriorController,
                          decoration:
                              InputDecoration(labelText: 'Valor anterior'),
                          onChanged: (value) {
                            value = saldoAnteriorController.text;
                            print("Valor anterior: ${value}");
                          },
                          onSaved: (value) {
                            saldoAnteriorController.updateValue(0);
                          },
                        ),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          controller: valorSaidaController,
                          decoration: InputDecoration(labelText: 'Valor saida'),
                          onChanged: (value) {
                            value = valorSaidaController.text;
                            print("Valor saida: ${value}");
                          },
                          onSaved: (value) {
                            valorSaidaController.updateValue(0);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 0),
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
                          labelText: "Descrição do caixa",
                          border: OutlineInputBorder(
                            gapPadding: 0.0,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Descrição breve",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.edit_attributes_outlined),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 255,
                        maxLines: null,
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
                    print("Descrição: ${c.descricao}");
                    print("Saldo anterior: ${c.saldoAnterior}");
                    print("Valor de entrada: ${c.valorEntrada}");
                    print("Valor de saida: ${c.valorSaida}");
                    print("Valor total: ${c.valorTotal}");
                    print("Caixa status: ${c.caixaStatus}");
                    print("Status: ${c.status}");
                    print("Data Registro: ${c.dataRegistro}");
                    print("Caixa: ${c.caixa.descricao}");
                    print("Operador: ${c.vendedor.nome}");

                    verificaCaixaStatus(c.status);

                    caixafluxoController.create(c).then((value) {
                      print("cadastro : ${value}");
                    });

                    Navigator.of(context).pop();
                    buildPush(context);
                  });
                } else {
                  dialogs.information(
                      context, "preparando para o alteração...");
                  Timer(Duration(seconds: 3), () {
                    verificaCaixaStatus(c.status);
                    print("Descrição: ${c.descricao}");
                    print("Saldo anterior: ${c.saldoAnterior}");
                    print("Valor de entrada: ${c.valorEntrada}");
                    print("Valor de saida: ${c.valorSaida}");
                    print("Valor total: ${c.valorTotal}");
                    print("Caixa status: ${c.caixaStatus}");
                    print("Status: ${c.status}");
                    print("Data Registro: ${c.dataRegistro}");
                    print("Caixa: ${c.caixa.descricao}");
                    print("Operador: ${c.vendedor.nome}");

                    verificaCaixaStatus(c.status);
                    caixafluxoController.update(c.id, c);

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
        builder: (context) => CaixaFluxoPage(),
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
