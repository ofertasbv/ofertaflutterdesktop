import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/util/dialogs/dialog_subcategoria.dart';

class DropDownSubCategoria extends StatelessWidget {
  SubCategoria subCategoria;
  DropDownSubCategoria(this.subCategoria);

  @override
  Widget build(BuildContext context) {
    var subCategoriaController = GetIt.I.get<SubCategoriaController>();
    AlertSubCategoria alertSubCateria = AlertSubCategoria();

    return Observer(
      builder: (context) {
        SubCategoria subCategoria =
            subCategoriaController.subCategoriaSelecionada;

        return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              title: Text("SubCategoria *"),
              subtitle: subCategoria == null
                  ? Text("Selecione uma SubCategoria")
                  : Text(subCategoria.nome),
              leading: Icon(Icons.list_alt_outlined),
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onTap: () {
                alertSubCateria.alert(context, subCategoria);
              },
            ),
          ),
        );
      },
    );
  }
}
