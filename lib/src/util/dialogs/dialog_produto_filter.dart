import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';

import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class DialogProdutoFilter extends StatefulWidget {
  ProdutoFilter filter;
  DialogProdutoFilter(this.filter);
  @override
  _DialogProdutoFilterState createState() =>
      _DialogProdutoFilterState(this.filter);
}

class _DialogProdutoFilterState extends State<DialogProdutoFilter> {
  _DialogProdutoFilterState(this.filter);

  var subCategoriaController = GetIt.I.get<SubCategoriaController>();

  ProdutoFilter filter;

  @override
  void initState() {
    if (filter == null) {
      filter = ProdutoFilter();
    }
    subCategoriaController.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return builderConteudoListSubCategorias();
  }

  builderConteudoListSubCategorias() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<SubCategoria> categorias = subCategoriaController.subCategorias;
          if (subCategoriaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (categorias == null) {
            return CircularProgressorMini();
          }

          return builderListCategorias(categorias);
        },
      ),
    );
  }

  builderListCategorias(List<SubCategoria> categorias) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        SubCategoria c = categorias[index];

        return Column(
          children: [
            GestureDetector(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 20,
                  child: Icon(Icons.check_outlined),
                ),
                title: Text(c.nome),
              ),
              onTap: () {
                setState(() {
                  // filter.categoria = c.nome;
                  print("SubCategoria: ${filter.subCategoria}");
                });
              },
            ),
            Divider()
          ],
        );
      },
    );
  }
}

class AlertProdutoFilter {
  alert(BuildContext context, ProdutoFilter filter) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: DialogProdutoFilter(filter),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Aplicar"),
            )
          ],
        );
      },
    );
  }
}
