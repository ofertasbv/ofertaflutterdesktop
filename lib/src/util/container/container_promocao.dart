import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/paginas/produto/produto_tab.dart';
import 'package:nosso/src/paginas/promocao/promocao_create_page.dart';

class ContainerPromocao extends StatelessWidget {
  PromoCaoController promoCaoController;
  Promocao p;

  ContainerPromocao(this.promoCaoController, this.p);

  @override
  Widget build(BuildContext context) {
    var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

    return ListTile(
      isThreeLine: false,
      leading: Container(
        padding: EdgeInsets.all(1),
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor
            ],
          ),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(35),
        ),
        child: p.foto != null
            ? CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 20,
                backgroundImage: NetworkImage(
                  "${promoCaoController.arquivo + p.foto}",
                ),
              )
            : CircleAvatar(),
      ),
      title: Text(p.nome),
      subtitle: Text("R\$ ${formatMoeda.format(p.desconto)} OFF"),
      trailing: Container(
        height: 80,
        width: 50,
        child: buildPopupMenuButton(context, p),
      ),
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(
      BuildContext context, Promocao p) {
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
                return PromocaoCreatePage(
                  promocao: p,
                );
              },
            ),
          );
        }
        if (valor == "delete") {
          print("delete");
        }
        if (valor == "produtos") {
          print("produtos");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProdutoTab();
              },
            ),
          );
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
            title: Text('delete'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'produtos',
          child: ListTile(
            leading: Icon(Icons.add),
            title: Text('produtos'),
          ),
        )
      ],
    );
  }
}
