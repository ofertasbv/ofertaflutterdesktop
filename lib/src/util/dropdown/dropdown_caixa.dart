import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/caixa_controller.dart';
import 'package:nosso/src/core/model/caixa.dart';
import 'package:nosso/src/util/dialogs/dialog_caixa.dart';

class DropDownCaixa extends StatelessWidget {
  Caixa caixa;

  DropDownCaixa(this.caixa);

  @override
  Widget build(BuildContext context) {
    var caixaController = GetIt.I.get<CaixaController>();
    AlertCaixa alertCaixa = AlertCaixa();

    return Observer(
      builder: (context) {
        Caixa caixa = caixaController.caixaSelecionado;

        return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              title: Text("Caixa *"),
              subtitle: caixa == null
                  ? Text("Selecione um caixa")
                  : Text(caixa.descricao),
              leading: Icon(Icons.computer_outlined),
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onTap: () {
                alertCaixa.alert(context, caixa);
              },
            ),
          ),
        );
      },
    );
  }
}
