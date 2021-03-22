import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/cliente_controller.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/controller/pedido_controller.dart';
import 'package:nosso/src/core/controller/usuario_controller.dart';
import 'package:nosso/src/core/model/cliente.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/pedido.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/paginas/pedido/pedido_page.dart';
import 'package:nosso/src/paginas/pedidoitem/pedito_itens_page.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:nosso/src/util/steps/step_menu_etapa.dart';
import 'package:nosso/src/util/validador/validador_pedido.dart';

class PedidoCreatePage extends StatefulWidget {
  Pedido pedido;

  PedidoCreatePage({Key key, this.pedido}) : super(key: key);

  @override
  _PedidoCreatePageState createState() =>
      _PedidoCreatePageState(p: this.pedido);
}

class _PedidoCreatePageState extends State<PedidoCreatePage>
    with ValidadorPedido {
  _PedidoCreatePageState({this.p});

  var pedidoController = GetIt.I.get<PedidoController>();
  var pedidoItemController = GetIt.I.get<PedidoItemController>();
  var usuarioController = GetIt.I.get<UsuarioController>();
  var lojaController = GetIt.I.get<LojaController>();
  var clienteController = GetIt.I.get<ClienteController>();

  Dialogs dialogs = Dialogs();

  Pedido p;
  Cliente clienteSelecionado;
  Loja lojaSelecionda;
  String statusPedido;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var nomeCotroller = TextEditingController();
  var valorInicialCotroller = TextEditingController();
  var descontoCotroller = TextEditingController();
  var valorFreteCotroller = TextEditingController();
  var valorTotalCotroller = TextEditingController();

  @override
  void initState() {
    if (p == null) {
      p = Pedido();
      statusPedido = "CRIADO";
    } else {
      lojaSelecionda = p.loja;
      clienteSelecionado = p.cliente;

      valorInicialCotroller.text = p.valorInicial.toStringAsFixed(1);
      descontoCotroller.text = p.valorDesconto.toStringAsFixed(2);
      valorFreteCotroller.text = p.valorFrete.toStringAsFixed(2);
      valorTotalCotroller.text = p.valorTotal.toStringAsFixed(2);
    }

    lojaController.getAll();
    clienteController.getAll();
    super.initState();
  }

  Controller controller;

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  buscarPessoaCliente(int id) async {
    clienteSelecionado = await clienteController.getById(id);
    print("Cliente: ${clienteSelecionado.nome}");
    return clienteSelecionado;
  }

  buscarPessoaLoja(int id) async {
    lojaSelecionda = await lojaController.getById(id);
    print("Loja: ${lojaSelecionda.nome}");
    return lojaSelecionda;
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

  builderConteudoListClientes() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Cliente> clientes = clienteController.clientes;
          if (clienteController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (clientes == null) {
            return CircularProgressor();
          }

          return DropdownSearch<Cliente>(
            label: "Selecione clientes",
            popupTitle: Center(child: Text("Clientes")),
            items: clientes,
            showSearchBox: true,
            itemAsString: (Cliente c) => c.nome,
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: clienteSelecionado,
            onChanged: (Cliente c) {
              setState(() {
                p.cliente = c;
                print("Cliente: ${p.cliente.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por cliente",
            ),
          );
        },
      ),
    );
  }

  builderConteudoListLojas() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Loja> lojas = lojaController.lojas;
          if (lojaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (lojas == null) {
            return CircularProgressor();
          }

          return DropdownSearch<Loja>(
            label: "Selecione lojas",
            popupTitle: Center(child: Text("Lojas")),
            items: lojas,
            showSearchBox: true,
            itemAsString: (Loja s) => s.nome,
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: lojaSelecionda,
            onChanged: (Loja l) {
              setState(() {
                p.loja = l;
                print("loja: ${p.loja.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por loja",
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
        elevation: 0,
        titleSpacing: 50,
        title: Text("Pedido cadastros"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: Card(
          child: Observer(
            builder: (context) {
              if (pedidoController.dioError == null) {
                return buildListViewForm(context);
              } else {
                print("Erro: ${pedidoController.mensagem}");
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
    var dateFormat = DateFormat('dd/MM/yyyy');
    var formatter = NumberFormat("00.00");
    var formata = new NumberFormat("#,##0.00", "pt_BR");

    return ListView(
      children: <Widget>[
        Container(
          color: Colors.grey[200],
          child: ExpansionTile(
            leading: Icon(
              Icons.shopping_basket_outlined,
              color: Colors.blue,
            ),
            title: Text(
              "Meus itens",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            children: [
              Container(
                height: 400,
                child: PedidoItensList(),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: Center(
            child: StepMenuEtapa(
              colorPedido: Colors.grey,
              colorPagamento: Colors.orangeAccent,
              colorConfirmacao: Colors.orangeAccent,
            ),
          ),
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
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: p.descricao,
                        onSaved: (value) => p.descricao = value,
                        validator: validateDescricao,
                        decoration: InputDecoration(
                          labelText: "Descrição",
                          hintText: "Descrição",
                          prefixIcon: Icon(Icons.edit, color: Colors.grey),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lime[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 200,
                        maxLines: null,
                        //initialValue: c.nome,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          controller: valorInicialCotroller,
                          onSaved: (value) {
                            p.valorInicial = double.tryParse(value);
                          },
                          validator: validateDesconto,
                          decoration: InputDecoration(
                            labelText: "Valor inicial",
                            hintText: "Valor inicial",
                            prefixIcon: Icon(
                              Icons.monetization_on_outlined,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => valorInicialCotroller.clear(),
                              icon: Icon(Icons.clear),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo[900]),
                              gapPadding: 1,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          maxLength: 6,
                        ),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          controller: valorFreteCotroller,
                          onSaved: (value) {
                            p.valorFrete = double.tryParse(value);
                          },
                          validator: validateValorFrete,
                          decoration: InputDecoration(
                            labelText: "Valor de entrega",
                            hintText: "Valor de entrega",
                            prefixIcon: Icon(
                              Icons.monetization_on_outlined,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => valorFreteCotroller.clear(),
                              icon: Icon(Icons.clear),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo[900]),
                              gapPadding: 1,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          maxLength: 6,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          controller: descontoCotroller,
                          onSaved: (value) {
                            p.valorDesconto = double.tryParse(value);
                          },
                          validator: validateDesconto,
                          onChanged: (percentual) {
                            setState(() {
                              double valor = (double.tryParse(
                                      valorInicialCotroller.text) -
                                  ((double.tryParse(
                                              valorInicialCotroller.text) *
                                          double.tryParse(
                                              descontoCotroller.text)) /
                                      100) +
                                  double.tryParse(valorFreteCotroller.text));
                              valorTotalCotroller.text =
                                  valor.toStringAsFixed(2);
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Percentual de desconto",
                            hintText: "Percentual de desconto",
                            prefixIcon: Icon(
                              Icons.monetization_on_outlined,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => descontoCotroller.clear(),
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
                              TextInputType.numberWithOptions(decimal: true),
                          maxLength: 10,
                        ),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          controller: valorTotalCotroller,
                          onSaved: (value) {
                            p.valorTotal = double.tryParse(value);
                          },
                          validator: validateValorTotal,
                          decoration: InputDecoration(
                            labelText: "Valor Total",
                            hintText: "Valor total",
                            prefixIcon: Icon(
                              Icons.monetization_on_outlined,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => valorTotalCotroller.clear(),
                              icon: Icon(Icons.clear),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo[900]),
                              gapPadding: 1,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          maxLength: 6,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: DateTimeField(
                          initialValue: p.dataRegistro,
                          format: dateFormat,
                          validator: validateDateEntrega,
                          onSaved: (value) => p.dataRegistro = value,
                          decoration: InputDecoration(
                            labelText: "data de resgistro",
                            hintText: "99-09-9999",
                            prefixIcon: Icon(Icons.calendar_today),
                            suffixIcon: Icon(Icons.close),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo[900]),
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
                          maxLength: 10,
                        ),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: DateTimeField(
                          initialValue: p.dataHoraEntrega,
                          format: dateFormat,
                          validator: validateDateHoraEntrega,
                          onSaved: (value) => p.dataHoraEntrega = value,
                          decoration: InputDecoration(
                            labelText: "data e hora da entrega",
                            hintText: "99-09-9999",
                            prefixIcon: Icon(Icons.calendar_today),
                            suffixIcon: Icon(Icons.close),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.indigo[900]),
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
                          maxLength: 10,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListClientes(),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListLojas(),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Status do pedido"),
                        RadioListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: Text("CRIADO"),
                          value: "CRIADO",
                          groupValue: p.statusPedido == null
                              ? p.statusPedido = statusPedido
                              : p.statusPedido,
                          secondary: const Icon(Icons.check_outlined),
                          onChanged: (String valor) {
                            setState(() {
                              p.statusPedido = valor;
                              print("StatusPedido: " + p.statusPedido);
                            });
                          },
                        ),
                        RadioListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: Text("ENVIADO"),
                          value: "ENVIADO",
                          groupValue: p.statusPedido == null
                              ? p.statusPedido = statusPedido
                              : p.statusPedido,
                          secondary: const Icon(Icons.check_outlined),
                          onChanged: (String valor) {
                            setState(() {
                              p.statusPedido = valor;
                              print("StatusPedido: " + p.statusPedido);
                            });
                          },
                        ),
                        RadioListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: Text("CANCELADO"),
                          value: "CANCELADO",
                          groupValue: p.statusPedido == null
                              ? p.statusPedido = statusPedido
                              : p.statusPedido,
                          secondary: const Icon(Icons.check_outlined),
                          onChanged: (String valor) {
                            setState(() {
                              p.statusPedido = valor;
                              print("StatusPedido: " + p.statusPedido);
                            });
                          },
                        ),
                        RadioListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: Text("ENTREGUE"),
                          value: "ENTREGUE",
                          groupValue: p.statusPedido == null
                              ? p.statusPedido = statusPedido
                              : p.statusPedido,
                          secondary: const Icon(Icons.check_outlined),
                          onChanged: (String valor) {
                            setState(() {
                              p.statusPedido = valor;
                              print("StatusPedido: " + p.statusPedido);
                            });
                          },
                        ),
                      ],
                    ),
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
                if (p.id == null) {
                  dialogs.information(context, "prepando para o cadastro...");
                  Timer(Duration(seconds: 3), () {
                    p.valorTotal = (pedidoItemController.total -
                        ((pedidoItemController.total * p.valorDesconto) / 100) +
                        p.valorFrete);

                    print("Cliente: ${clienteSelecionado.nome}");
                    print("Loja: ${lojaSelecionda.nome}");

                    print("Descrição: ${p.descricao}");
                    print("Desconto: ${p.valorDesconto}");
                    print("Frete: ${p.valorFrete}");
                    print("Valor total: ${p.valorTotal}");

                    print("Status: ${p.statusPedido}");

                    print("Data de regsitro: ${p.dataRegistro}");
                    print("Data e hora da entrega: ${p.dataHoraEntrega}");

                    for (PedidoItem item in pedidoItemController.itens) {
                      print("Produto: ${item.produto.nome}");
                    }

                    // pedidoController.create(p).then((value) {
                    //   print("resultado : ${value}");
                    // });
                    // Navigator.of(context).pop();
                    // buildPush(context);
                  });
                } else {
                  dialogs.information(
                      context, "preparando para o alteração...");
                  Timer(Duration(seconds: 3), () {
                    p.valorTotal = (pedidoItemController.total -
                        ((pedidoItemController.total * p.valorDesconto) / 100) +
                        p.valorFrete);

                    print("Cliente: ${clienteSelecionado.nome}");
                    print("Loja: ${lojaSelecionda.nome}");
                    print("Descrição: ${p.descricao}");
                    print("Desconto: ${p.valorDesconto}");
                    print("Frete: ${p.valorFrete}");
                    print("Valor total: ${p.valorTotal}");

                    print("Status: ${p.statusPedido}");

                    print("Data de resgistro: ${p.dataRegistro}");
                    print("Data e hora da entrega: ${p.dataHoraEntrega}");

                    // pedidoController.update(p.id, p);
                    // Navigator.of(context).pop();
                    // buildPush(context);
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
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PedidoPage(),
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
