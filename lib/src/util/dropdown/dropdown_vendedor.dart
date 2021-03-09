import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/vendedor_controller.dart';
import 'package:nosso/src/core/model/vendedor.dart';
import 'package:nosso/src/util/dialogs/dialog_vendedor.dart';

class DropDownVendedor extends StatelessWidget {
  Vendedor vendedor;

  DropDownVendedor(this.vendedor);

  @override
  Widget build(BuildContext context) {
    var vendedorController = GetIt.I.get<VendedorController>();
    AlertVendedor alertVendedor = AlertVendedor();

    return Observer(
      builder: (context) {
        Vendedor vendedor = vendedorController.vendedoreSelecionado;

        return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              title: Text("Operador *"),
              subtitle: vendedor == null
                  ? Text("Selecione operador")
                  : Text(vendedor.nome),
              leading: Icon(Icons.person_add_alt),
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onTap: () {
                alertVendedor.alert(context, vendedor);
              },
            ),
          ),
        );
      },
    );
  }
}
