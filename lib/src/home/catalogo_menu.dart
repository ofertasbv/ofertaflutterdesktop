import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nosso/src/home/categoria_list_home.dart';
import 'package:nosso/src/home/home.dart';
import 'package:nosso/src/home/produto_list_home.dart';
import 'package:nosso/src/paginas/loja/loja_location.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/util/barcodigo/leitor_codigo_barra.dart';
import 'package:nosso/src/util/barcodigo/leitor_qr_code.dart';

class CatalogoMenu extends StatefulWidget {
  @override
  _CatalogoMenuState createState() => _CatalogoMenuState();
}

class _CatalogoMenuState extends State<CatalogoMenu> {
  PageController _pageController;
  int _page = 0;

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("aplicativos"),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return HomePage();
                }),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 5),
            Container(
              height: 150,
              child: CategoriaListHome(),
            ),
            Card(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                height: 250,
                child: buildGridView(context),
              ),
            ),
            Expanded(
              child: ProdutoListHome(),
            ),
          ],
        ),
      ),
    );
  }

  builderBodyBack() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[200],
            Colors.grey[200],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  buildGridView(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(top: 2),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,

      //childAspectRatio: MediaQuery.of(context).size.aspectRatio * 1.9,

      scrollDirection: Axis.vertical,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LeitorQRCode();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.qr_code_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(20),
              ),
              Center(
                child: Text("QR code", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LeitorCodigoBarra();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.qr_code_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(20),
              ),
              Center(
                child: Text("Código bar", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LojaLocation();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.map_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(20),
              ),
              Center(
                child: Text("Locais", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LeitorQRCode();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.qr_code_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(20),
              ),
              Center(
                child: Text("QR code", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LeitorCodigoBarra();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.qr_code_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(20),
              ),
              Center(
                child: Text("Código bar", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LojaLocation();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.map_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(20),
              ),
              Center(
                child: Text("Locais", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
