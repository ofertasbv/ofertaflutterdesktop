import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/util/dialogs/dialog_loja.dart';

class DropDownLoja extends StatelessWidget {
  Loja loja;

  DropDownLoja(this.loja);

  @override
  Widget build(BuildContext context) {
    var lojaController = GetIt.I.get<LojaController>();
    AlertLoja alertLoja = AlertLoja();

    return Observer(
      builder: (context) {
        Loja loja = lojaController.lojaSelecionada;

        return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              title: Text("Loja *"),
              subtitle:
                  loja == null ? Text("Selecione uma loja") : Text(loja.nome),
              leading: Icon(Icons.list_alt_outlined),
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onTap: () {
                alertLoja.alert(context, loja);
              },
            ),
          ),
        );
      },
    );
  }
}
