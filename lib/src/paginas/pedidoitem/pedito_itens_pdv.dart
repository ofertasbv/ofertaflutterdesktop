import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/paginas/produto/produto_tab.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:nosso/src/util/snackbar/snackbar_global.dart';

class PedidoItensListPDV extends StatefulWidget {

  @override
  _PedidoItensListPDVState createState() => _PedidoItensListPDVState();
}

class _PedidoItensListPDVState extends State<PedidoItensListPDV> {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  @override
  void initState() {
    pedidoItemController.pedidosItens();
    pedidoItemController.calculateTotal();
    super.initState();
  }

  showSnackbar(BuildContext context, String texto) {
    final snackbar = SnackBar(content: Text(texto));
    GlobalScaffold.instance.showSnackbar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return builderConteudoList();
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<PedidoItem> itens = pedidoItemController.itens;
          if (pedidoItemController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (itens == null) {
            return CircularProgressor();
          }

          if (itens.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Icon(
                      Icons.shopping_basket,
                      color: Colors.green,
                      size: 100,
                    ),
                  ),
                  Text("Sua cesta está vazia"),
                  SizedBox(height: 20),
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ProdutoTab();
                          },
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide(color: Colors.blue),
                    ),
                    color: Colors.white,
                    textColor: Colors.green,
                    padding: EdgeInsets.all(10),
                    icon: Icon(
                      Icons.home,
                      color: Colors.blue,
                    ),
                    label: Text(
                      "ESCOLHER PRODUTOS",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    elevation: 0,
                  ),
                ],
              ),
            );
          }

          return builderTable(itens);
        },
      ),
    );
  }

  builderTable(List<PedidoItem> itens) {
    return DataTable(
      sortAscending: true,
      showCheckboxColumn: true,
      columns: [
        DataColumn(label: Text("Código")),
        DataColumn(label: Text("Quantidade")),
        DataColumn(label: Text("Valor Unit.")),
        DataColumn(label: Text("Descrição")),
        DataColumn(label: Text("Valor Total")),
        DataColumn(label: Text("Editar")),
        DataColumn(label: Text("Excluir"))
      ],
      rows: itens
          .map(
            (p) => DataRow(
              cells: [
                DataCell(
                  Text("${p.produto.id}"),
                ),
                DataCell(
                  Text("${p.quantidade}"),
                ),
                DataCell(
                  Text(
                    "R\$ ${formatMoeda.format(p.valorUnitario)}",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                DataCell(Text(p.produto.nome)),
                DataCell(
                  Text(
                    "R\$ ${formatMoeda.format(p.valorTotal)}",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.edit_rounded),
                    onPressed: () {
                      print("Código de barra: ${p.produto.codigoBarra}");
                      print("Descrição: ${p.produto.descricao}");
                      print("Quantidade: ${p.quantidade}");
                      print("Valor unitário: ${p.valorUnitario}");
                      print("Valor total: ${p.valorTotal}");
                    },
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () {
                      showDialogAlert(context, p);
                    },
                  ),
                )
              ],
            ),
          )
          .toList(),
    );
  }

  showDialogAlert(BuildContext context, PedidoItem p) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Deseja remover este item?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${p.produto.nome}"),
                Text("Cod: ${p.produto.id}"),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      ConstantApi.urlArquivoProduto + p.produto.foto,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton.icon(
              icon: Icon(
                Icons.cancel,
                color: Colors.grey,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
              label: Text('CANCELAR'),
              color: Colors.white,
              elevation: 0,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton.icon(
              icon: Icon(
                Icons.restore_from_trash,
                color: Colors.green,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
              label: Text('EXCLUIR'),
              color: Colors.white,
              elevation: 0,
              onPressed: () {
                setState(() {
                  pedidoItemController.remove(p);
                  pedidoItemController.itens;
                });

                // showSnackbar(context, "Produto ${p.produto.nome} removido");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
