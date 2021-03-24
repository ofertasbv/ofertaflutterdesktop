import 'dart:async';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/controller/pedido_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/controller/tamanho_controller.dart';
import 'package:nosso/src/core/model/pedido.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/tamanho.dart';
import 'package:nosso/src/paginas/pedidoitem/pedidoitem_page.dart';
import 'package:nosso/src/paginas/permissao/permissao_page.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class PedidoItemCreatePage extends StatefulWidget {
  PedidoItem pedidoItem;

  PedidoItemCreatePage({Key key, this.pedidoItem}) : super(key: key);

  @override
  _PedidoItemCreatePageState createState() =>
      _PedidoItemCreatePageState(p: this.pedidoItem);
}

class _PedidoItemCreatePageState extends State<PedidoItemCreatePage> {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();
  var produtoController = GetIt.I.get<ProdutoController>();
  var pedidoController = GetIt.I.get<PedidoController>();
  var tamanhoController = GetIt.I.get<TamanhoController>();

  Dialogs dialogs = Dialogs();

  PedidoItem p;
  Tamanho tamanhoSelecionado;
  Pedido pedidoSelecionado;
  Produto produtoSelecionado;
  File file;

  _PedidoItemCreatePageState({this.p});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  var controllerNome = TextEditingController();

  @override
  void initState() {
    produtoController.getAll();
    tamanhoController.getAll();
    pedidoItemController.getAll();
    pedidoController.getAll();
    if (p == null) {
      p = PedidoItem();
    } else {
      produtoSelecionado = p.produto;
      pedidoSelecionado = p.pedido;
      tamanhoSelecionado = p.tamanho;
    }
    super.initState();
  }

  Controller controller;

  @override
  void didChangeDependencies() {
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

  builderConteudoListTamanhos() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Tamanho> tamanhos = tamanhoController.tamanhos;
          if (tamanhoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (tamanhos == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Tamanho>(
            label: "Selecione tamanhos",
            popupTitle: Center(child: Text("Tamanhos")),
            items: tamanhos,
            showSearchBox: true,
            itemAsString: (Tamanho s) => s.descricao,
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: tamanhoSelecionado,
            onChanged: (Tamanho l) {
              setState(() {
                p.tamanho = l;
                print("tamanho: ${p.tamanho.descricao}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por tamanho",
            ),
          );
        },
      ),
    );
  }

  builderConteudoListProdutos() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Produto> produtos = produtoController.produtos;
          if (produtoController.error != null) {
            return Text("Não foi possível buscar produtos");
          }

          if (produtos == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Produto>(
            label: "Selecione produtos",
            popupTitle: Center(child: Text("Produtos")),
            items: produtos,
            showSearchBox: true,
            itemAsString: (Produto s) => s.descricao,
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: produtoSelecionado,
            onChanged: (Produto l) {
              setState(() {
                p.produto = l;
                print("produto: ${p.produto.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por produto",
            ),
          );
        },
      ),
    );
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
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 50,
        title: Text("Pedidos itens cadastros"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: Card(
          child: Observer(
            builder: (context) {
              if (pedidoItemController.dioError == null) {
                return buildListViewForm(context);
              } else {
                print("Erro: ${pedidoItemController.mensagem}");
                return buildListViewForm(context);
              }
            },
          ),
        ),
      ),
    );
  }

  buildListViewForm(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          padding: EdgeInsets.all(0),
          child: ListTile(
            title: Text("Cadastrar itens de pedido"),
            trailing: Icon(Icons.shopping_basket_outlined),
          ),
        ),
        SizedBox(height: 10),
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
                        initialValue: p.quantidade.toString(),
                        onSaved: (value) => p.quantidade = int.tryParse(value),
                        validator: (value) =>
                            value.isEmpty ? "campo obrigário" : null,
                        decoration: InputDecoration(
                          labelText: "Quatidade",
                          hintText: "Entre com a quantidade",
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
                        keyboardType: TextInputType.text,
                        maxLength: 50,
                        maxLines: 1,
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
                          initialValue: p.valorUnitario.toString(),
                          onSaved: (value) =>
                              p.valorUnitario = double.tryParse(value),
                          validator: (value) =>
                              value.isEmpty ? "campo obrigário" : null,
                          decoration: InputDecoration(
                            labelText: "Valor unitário",
                            hintText: "Entre com valor unitário",
                            prefixIcon:
                                Icon(Icons.monetization_on, color: Colors.grey),
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
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                          maxLines: 1,
                          //initialValue: c.nome,
                        ),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: TextFormField(
                          initialValue: p.valorTotal.toString(),
                          onSaved: (value) =>
                              p.valorTotal = double.tryParse(value),
                          validator: (value) =>
                              value.isEmpty ? "campo obrigário" : null,
                          decoration: InputDecoration(
                            labelText: "Valor total",
                            hintText: "Entre com valor total",
                            prefixIcon:
                                Icon(Icons.monetization_on, color: Colors.grey),
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
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                          maxLines: 1,
                          //initialValue: c.nome,
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
                        child: builderConteudoListProdutos(),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListTamanhos(),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: builderConteudoListPedidos(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 0),
        Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton.icon(
            label: Text("Enviar formulário"),
            icon: Icon(Icons.check),
            onPressed: () {
              if (controller.validate()) {
                if (p.id == null) {
                  dialogs.information(context, "prepando para o cadastro...");
                  Timer(Duration(seconds: 3), () {
                    pedidoItemController.create(p).then((value) {
                      print("resultado : ${value}");
                    });
                    Navigator.of(context).pop();
                    buildPush(context);
                  });
                } else {
                  dialogs.information(
                      context, "preparando para o alteração...");
                  Timer(Duration(seconds: 3), () {
                    pedidoItemController.update(p.id, p);
                    Navigator.of(context).pop();
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
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PedidoItemPage(),
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
