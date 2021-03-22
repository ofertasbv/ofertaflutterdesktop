import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/paginas/produto/produto_page.dart';
import 'package:nosso/src/paginas/promocao/promocao_create_page.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';

class ContainerPromocao extends StatelessWidget {
  PromoCaoController promoCaoController;
  Promocao p;

  ContainerPromocao(this.promoCaoController, this.p);

  ProdutoFilter filter = ProdutoFilter();

  @override
  Widget build(BuildContext context) {
    var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");
    var dateFormat = DateFormat('dd/MM/yyyy');

    return Container(
      color: Colors.white,
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        "${promoCaoController.arquivo + p.foto}",
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
              subtitle: Text(
                  "${dateFormat.format(p.dataInicio)} á ${dateFormat.format(p.dataFinal)}"),
            ),
          ),
          Container(
            width: 500,
            height: 150,
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: ListTile(
              isThreeLine: false,
              leading: Text(
                "% ${formatMoeda.format(p.desconto)} DE DESCOSTO",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                label: Text("${p.produtos.length}"),
              ),
            ),
          ),
        ],
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
          filter.subCategoria = p.id;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProdutoPage(filter: filter);
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
