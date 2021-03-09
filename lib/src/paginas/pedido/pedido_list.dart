import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedido_controller.dart';
import 'package:nosso/src/core/model/pedido.dart';
import 'package:nosso/src/paginas/pedido/pedido_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PedidoList extends StatefulWidget {
  @override
  _PedidoListState createState() => _PedidoListState();
}

class _PedidoListState extends State<PedidoList>
    with AutomaticKeepAliveClientMixin<PedidoList> {
  var pedidoController = GetIt.I.get<PedidoController>();

  @override
  void initState() {
    pedidoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return pedidoController.getAll();
  }

  @override
  Widget build(BuildContext context) {
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
              child: CircularProgressor(),
            );
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(pedidos),
          );
        },
      ),
    );
  }

  ListView builderList(List<Pedido> pedidos) {
    return ListView.builder(
      itemCount: pedidos.length,
      itemBuilder: (context, index) {
        Pedido c = pedidos[index];

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
            title: Text(c.descricao),
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

  showDialogAlert(BuildContext context, Pedido p) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('INFORMAÇÃOES'),
          content: Text(p.descricao),
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
                      return PedidoCreatePage(pedido: p);
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

  PopupMenuButton<String> buildPopupMenuButton(BuildContext context, Pedido c) {
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
                return PedidoCreatePage(pedido: c);
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
