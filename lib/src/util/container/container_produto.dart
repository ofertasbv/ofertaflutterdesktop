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
            width: 200,
            height: 150,
            color: Colors.grey,
            padding: EdgeInsets.all(0),
            child: p.foto != null
                ? Container(
                    width: 200,
                    height: 150,
                    color: Colors.grey[400],
                    child: Image.network(
                      "${produtoController.arquivo + p.foto}",
                      width: 200,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    width: 200,
                    height: 150,
                    color: Colors.grey[600],
                    child: Image.asset(
                      ConstantApi.urlLogo,
                      width: 200,
                      height: 150,
                    ),
                  ),
          ),
          Container(
            width: 300,
            height: 150,
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  child: ListTile(
                    isThreeLine: false,
                    title: Text(
                      p.nome,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${p.loja.nome}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: ListTile(
                    isThreeLine: false,
                    title: Text(
                      p.promocao.nome,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    subtitle: Text(
                      "R\$ ${formatMoeda.format(p.estoque.valorVenda)}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
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
