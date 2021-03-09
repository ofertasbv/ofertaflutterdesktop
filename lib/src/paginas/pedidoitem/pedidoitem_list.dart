import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/paginas/pedidoitem/pedidoitem_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PedidoItemList extends StatefulWidget {
  @override
  _PedidoItemListState createState() => _PedidoItemListState();
}

class _PedidoItemListState extends State<PedidoItemList>
    with AutomaticKeepAliveClientMixin<PedidoItemList> {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();

  @override
  void initState() {
    pedidoItemController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return pedidoItemController.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<PedidoItem> itens = pedidoItemController.pedidoItens;
          if (pedidoItemController.error != null) {
            return Text("Não foi possível buscar permissões");
          }

          if (itens == null) {
            return Center(
              child: CircularProgressor(),
            );
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(itens),
          );
        },
      ),
    );
  }

  ListView builderList(List<PedidoItem> itens) {
    return ListView.builder(
      itemCount: itens.length,
      itemBuilder: (context, index) {
        PedidoItem c = itens[index];

        return Container(
          child: ListTile(
            isThreeLine: true,
            leading: Container(
              padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor],
                ),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(35),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 20,
                child: Icon(Icons.shopping_basket_outlined),
              ),
            ),
            title: Text(c.produto.nome),
            subtitle: Text("R\$ ${c.valorTotal}"),
            trailing: buildPopupMenuButton(context, c),
            onLongPress: () {
              showDialogAlert(context, c);
            },
          ),
        );
      },
    );
  }

  showDialogAlert(BuildContext context, PedidoItem p) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('INFORMAÇÃOES'),
          content: Text(p.produto.nome),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('EDITAR'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return PedidoItemCreatePage(pedidoItem: p);
                    },
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(
      BuildContext context, PedidoItem c) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: Icon(Icons.more_vert),
      onSelected: (valor) {
        if (valor == "novo") {
          print("novo");
        }
        if (valor == "editar") {
          print("editar");
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return PedidoItemCreatePage(
                  pedidoItem: c,
                );
              },
            ),
          );
        }
        if (valor == "delete") {
          print("delete");
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'novo',
          child: ListTile(
            leading: Icon(Icons.add),
            title: Text('novo'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'editar',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('editar'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
