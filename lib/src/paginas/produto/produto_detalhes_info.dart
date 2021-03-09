import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/model/cor.dart';
import 'package:nosso/src/core/model/produto.dart';

class ProdutoDetalhesInfo extends StatefulWidget {
  Produto p;

  ProdutoDetalhesInfo(this.p);

  @override
  _ProdutoDetalhesInfoState createState() => _ProdutoDetalhesInfoState();
}

class _ProdutoDetalhesInfoState extends State<ProdutoDetalhesInfo> {
  Produto p;

  @override
  Widget build(BuildContext context) {
    p = widget.p;

    return buildContainer(p);
  }

  buildContainer(Produto p) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return ListView(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                child: Container(
                  padding: EdgeInsets.all(0),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        title: Text("Produto"),
                        subtitle: Text("${p.nome}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Descrição"),
                        subtitle: Text("${p.descricao}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      // ListTile(
                      //   title: Text("Data Registro"),
                      //   subtitle: Text("${dateFormat.format(p.estoque.dataRegistro)}"),
                      //   trailing: Icon(Icons.check_outlined),
                      // ),
                      Divider(),
                      ListTile(
                        title: Text("Valor"),
                        subtitle: Text("R\$ ${p.estoque.valorUnitario}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Quantidade"),
                        subtitle: Text("${p.estoque.quantidade}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Código de barra"),
                        subtitle: Text("${p.codigoBarra}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("SKU"),
                        subtitle: Text("${p.sku}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Novo"),
                        subtitle: Text("${p.novo}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Status"),
                        subtitle: Text("${p.status}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Medida"),
                        subtitle: Text("${p.medida}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Origem"),
                        subtitle: Text("${p.origem}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Marca"),
                        subtitle: Text("${p.marca.nome}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Categoria"),
                        subtitle: Text("${p.subCategoria.nome}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Promoção"),
                        subtitle: Text("${p.promocao.nome}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Loja"),
                        subtitle: Text("${p.loja.nome}"),
                        trailing: Icon(Icons.check_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Cores"),
                        subtitle: Text("${p.cores.map((e) => e.descricao)}"),
                        trailing: Icon(Icons.color_lens_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Tamanhos"),
                        subtitle: Text("${p.tamanhos.map((e) => e.descricao)}"),
                        trailing: Icon(Icons.format_size_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
