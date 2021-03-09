import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/paginas/produto/produto_create_page.dart';
import 'package:nosso/src/paginas/produto/produto_detalhes_tab.dart';
import 'package:nosso/src/util/container/container_produto.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class LojaProdutoPage extends StatefulWidget {
  @override
  _LojaProdutoPageState createState() => _LojaProdutoPageState();
}

class _LojaProdutoPageState extends State<LojaProdutoPage> {
  var produtoController = GetIt.I.get<ProdutoController>();
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  @override
  void initState() {
    produtoController.getAllByLojaById(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus produtos"),
        actions: [
          Observer(
            builder: (context) {
              if (produtoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (produtoController.produtosByLoja == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.purple[800],
                child: Text(
                  (produtoController.produtosByLoja.length ?? 0).toString(),
                  style: TextStyle(color: Colors.yellow[900]),
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: builderConteudoList(),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ProdutoCreatePage();
            }),
          );
        },
      ),
    );
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Produto> produtos = produtoController.produtosByLoja;
          if (produtoController.error != null) {
            return Text("Não foi possível buscar produtos");
          }

          if (produtos == null) {
            return CircularProgressor();
          }

          return builderListProduto(produtos);
        },
      ),
    );
  }

  builderListProduto(List<Produto> produtos) {
    double containerWidth = 250;
    double containerHeight = 20;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Produto p = produtos[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: ContainerProduto(produtoController, p),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoDetalhesTab(p);
                },
              ),
            );
          },
        );
      },
    );
  }

  builderList(List<Produto> produtos) {
    double containerWidth = 160;
    double containerHeight = 30;

    DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Produto p = produtos[index];

        return GestureDetector(
          child: ListTile(
            isThreeLine: true,
            leading: Container(
              padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.grey[900]],
                ),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(35),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 25,
                backgroundImage: NetworkImage(
                  "${produtoController.arquivo + p.foto}",
                ),
              ),
            ),
            title: Text(p.nome),
            subtitle: Text(
              "R\$ ${formatMoeda.format(p.estoque.valorUnitario - ((p.estoque.valorUnitario * p.promocao.desconto) / 100))}",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Container(
              height: 80,
              width: 50,
              child: buildPopupMenuButton(context, p),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoDetalhesTab(p);
                },
              ),
            );
          },
        );
      },
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
        if (valor == "editar") {
          print("editar");
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
