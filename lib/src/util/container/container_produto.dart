import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/content.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/paginas/produto/produto_create_page.dart';

class ContainerProduto extends StatelessWidget {
  ProdutoController produtoController;
  Produto p;

  ContainerProduto(this.produtoController, this.p);

  @override
  Widget build(BuildContext context) {
    var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

    return Container(
      color: Colors.white,
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 600,
            height: 150,
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: ListTile(
              isThreeLine: true,
              leading: p.foto != null
                  ? CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Colors.green,
                      radius: 50,
                      backgroundImage: NetworkImage(
                        "${produtoController.arquivo + p.foto}",
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      radius: 50,
                    ),
              title: Text(
                p.nome,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text("${p.descricao}"),
            ),
          ),
          Container(
            width: 500,
            height: 150,
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: ListTile(
              isThreeLine: false,
              title: Text(
                p.descricao,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${p.loja.nome}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Chip(
                backgroundColor: Theme.of(context).accentColor,
                label: Text("${p.id}"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(
      BuildContext context, Produto p) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      enabled: true,
      elevation: 1,
      icon: Icon(Icons.more_vert),
      onSelected: (valor) {
        if (valor == "novo") {
          print("novo");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProdutoCreatePage();
              },
            ),
          );
        }
        if (valor == "editar") {
          print("editar");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProdutoCreatePage(
                  produto: p,
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
}
