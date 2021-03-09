import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';

import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class DialogCategoria extends StatefulWidget {
  Categoria categoria;
  DialogCategoria(this.categoria);
  @override
  _DialogCategoriaState createState() => _DialogCategoriaState(this.categoria);
}

class _DialogCategoriaState extends State<DialogCategoria> {
  _DialogCategoriaState(this.categoria);

  var categoriaController = GetIt.I.get<CategoriaController>();

  Categoria categoria;

  @override
  void initState() {
    categoriaController.getAll();
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
          List<Categoria> categorias = categoriaController.categorias;
          if (categoriaController.error != null) {
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
                  child: c.foto != null
                      ? CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          radius: 20,
                          backgroundImage: NetworkImage(
                            "${categoriaController.arquivo + c.foto}",
                          ),
                        )
                      : CircleAvatar(),
                ),
                title: Text(c.nome),
              ),
              onTap: () {
                categoriaController.categoriaSelecionada = c;
                print(
                    "Categoria: ${categoriaController.categoriaSelecionada.nome}");
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

class AlertCategoria {
  alert(BuildContext context, Categoria categoria) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: DialogCategoria(categoria),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("ok"),
            )
          ],
        );
      },
    );
  }
}
