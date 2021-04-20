import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/paginas/produto/produto_detalhes_tab.dart';
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

    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: Container(
          color: Colors.grey[200],
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 200,
                height: 150,
                color: Colors.grey[600],
                padding: EdgeInsets.all(0),
                child: p.foto != null
                    ? Container(
                        width: 200,
                        height: 150,
                        color: Colors.grey[600],
                        child: Image.network(
                          "${promoCaoController.arquivo + p.foto}",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 500,
                    height: 100,
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.center,
                    child: ListTile(
                      title: Text(
                        p.nome,
                        style: TextStyle(
                          fontSize: 25,
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
                      trailing: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Text("${p.produtos.length}"),
                      ),
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 100,
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.center,
                    child: ListTile(
                      title: Text(
                        p.descricao,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "de ${dateFormat.format(p.dataInicio)} á ${dateFormat.format(p.dataFinal)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.location_on_outlined),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                width: 400,
                height: 150,
                color: Colors.grey[300],
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Chip(
                      backgroundColor: Theme.of(context).accentColor,
                      label: Text(
                        "DESCONTO DE",
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          decorationStyle: TextDecorationStyle.dashed,
                        ),
                      ),
                    ),
                    Text(
                      "${formatMoeda.format(p.desconto)} %",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Valor a vista ou no boleto",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey[300],
                width: 300,
                padding: EdgeInsets.all(50),
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.transparent,
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: RaisedButton.icon(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      filter.promocao = p.id;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ProdutoPage(filter: filter);
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_basket_outlined),
                    label: Text("MOSTRAR PRODUTOS"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
