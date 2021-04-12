import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/produto.dart';

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
            color: Colors.grey[600].withOpacity(1),
            padding: EdgeInsets.all(0),
            child: p.foto != null
                ? Container(
                    width: 200,
                    height: 150,
                    color: Colors.grey[600].withOpacity(1),
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
                    color: Colors.grey[600].withOpacity(1),
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
}
