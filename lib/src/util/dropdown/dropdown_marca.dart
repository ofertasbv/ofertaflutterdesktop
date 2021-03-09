import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/marca_controller.dart';
import 'package:nosso/src/core/model/marca.dart';
import 'package:nosso/src/util/dialogs/dialog_marca.dart';

class DropDownMarca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var marcaController = GetIt.I.get<MarcaController>();
    AlertMarca alertMarca = AlertMarca();

    return Observer(
      builder: (context) {
        Marca marca = marcaController.marcaSelecionada;

        return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              title: Text("Marca *"),
              subtitle: marca == null
                  ? Text("Selecione uma marca")
                  : Text(marca.nome),
              leading: Icon(Icons.list_alt_outlined),
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onTap: () {
                alertMarca.alert(context, marca);
              },
            ),
          ),
        );
      },
    );
  }
}
