import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/paginas/caixa/caixa_page.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_page.dart';
import 'package:nosso/src/paginas/caixafluxoentrada/caixafluxoentrada_page.dart';
import 'package:nosso/src/paginas/caixafluxosaida/caixafluxosaida_page.dart';
import 'package:nosso/src/paginas/pdv/caixa_pdv_page.dart';
import 'package:nosso/src/paginas/pedido/pedido_page.dart';
import 'package:nosso/src/paginas/pedidoitem/itens_page.dart';

class CaixaControlePage extends StatelessWidget {
  var dateFormat = DateFormat('dd/MM/yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 50,
        title: Text("Controle de caixa"),
        actions: <Widget>[
          SizedBox(width: 2),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ItemPage();
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Container(
                  height: 150,
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).accentColor
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 21),
                        blurRadius: 54,
                        color: Colors.black.withOpacity(0.05),
                      )
                    ],
                    border: Border.all(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text(
                              "CONTROLE DE CAIXA - OFERTAS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Icon(Icons.dashboard_outlined),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text(
                              "${dateFormat.format(DateTime.now())}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.calculate_outlined),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey[200],
                          Colors.grey[400],
                        ],
                      ),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: buildGridViewConfig(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  builderBodyBack() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[200].withOpacity(0.2),
            Colors.grey[600].withOpacity(0.9)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  buildGridViewConfig(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(top: 2),
      // crossAxisSpacing: 1,
      // mainAxisSpacing: 1,
      crossAxisCount: 3,

      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2.1,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CaixaPage();
                },
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.shop_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(15),
              ),
              Text("PDV", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CaixaPage();
                },
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.computer,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(15),
              ),
              Text("Caixa", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CaixaPage();
                },
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.laptop_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(15),
              ),
              Text("Fluxo de caixa", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CaixaFluxoEntradaPage();
                },
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.monetization_on_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(15),
              ),
              Text("Receitas", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CaixaFluxoSaidaPage();
                },
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.monetization_on_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(15),
              ),
              Text("Despesas", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PedidoPage();
                },
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.monetization_on_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(15),
              ),
              Text("Vendas", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
