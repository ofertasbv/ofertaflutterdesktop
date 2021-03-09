import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';

class CategoriaDialog extends StatefulWidget {
  Categoria c;

  CategoriaDialog({Key key, this.c}) : super(key: key);

  @override
  _CategoriaDialogState createState() => _CategoriaDialogState(categoria: c);
}

class _CategoriaDialogState extends State<CategoriaDialog> {
  CategoriaController categoriaController = GetIt.I.get<CategoriaController>();
  Future<List<Categoria>> categorias;

  _CategoriaDialogState({this.categoria});

  Categoria categoria;

  @override
  void initState() {
    categorias = categoriaController.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return alertSelectCategorias(context, categoria);
  }

  alertSelectCategorias(BuildContext context, Categoria c) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: CategoriaDialog(),
          ),
        );
      },
    );
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Categoria> categorias = categoriaController.categorias;
          if (categoriaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (categorias == null) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.indigo[900],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            );
          }

          return builderListCategorias(categorias);
        },
      ),
    );
  }

  builderListCategorias(List<Categoria> categorias) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        Categoria c = categorias[index];

        return Column(
          children: [
            GestureDetector(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    "${ConstantApi.urlArquivoCategoria + c.foto}",
                  ),
                ),
                title: Text(c.nome),
              ),
              onTap: () {
                setState(() {
                  categoria = c;
                  print("${categoria.nome}");
                });
                Navigator.of(context).pop();
              },
            ),
            Divider()
          ],
        );
      },
    );
  }
}
