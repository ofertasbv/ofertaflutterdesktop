import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/util/dialogs/dialog_categoria.dart';

class DropDownCategoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var categoriaController = GetIt.I.get<CategoriaController>();
    AlertCategoria alertCateria = AlertCategoria();

    return Observer(
      builder: (context) {
        Categoria categoria = categoriaController.categoriaSelecionada;

        return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              title: Text("Categoria *"),
              subtitle: categoria == null
                  ? Text("Selecione uma categoria")
                  : Text(categoriaController.categoriaSelecionada.nome),
              leading: Icon(Icons.list_alt_outlined),
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onTap: () {
                alertCateria.alert(context, categoria);
              },
            ),
          ),
        );
      },
    );
  }
}
