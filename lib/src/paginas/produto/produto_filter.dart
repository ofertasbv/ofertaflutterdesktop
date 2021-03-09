import 'package:flutter/material.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';

class ProdutoFilterPage extends StatefulWidget {
  @override
  _ProdutoFilterPageState createState() => _ProdutoFilterPageState();
}

class _ProdutoFilterPageState extends State<ProdutoFilterPage> {
  ProdutoFilter filter;

  @override
  void initState() {
    if (filter == null) {
      filter = ProdutoFilter();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    filter.nomeProduto = "Vestido";

    return Scaffold(
      appBar: AppBar(
        title: Text("Produto Filter"),
      ),
      body: Container(
        child: Column(
          children: [
            Text(filter.nomeProduto),
          ],
        ),
      ),
    );
  }
}
