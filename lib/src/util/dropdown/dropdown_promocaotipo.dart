import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/promocaotipo_controller.dart';
import 'package:nosso/src/core/model/promocaotipo.dart';
import 'package:nosso/src/util/dialogs/dialog_promocaotipo.dart';

class DropDownPromocaoTipo extends StatelessWidget {
  PromocaoTipo promocaoTipo;

  DropDownPromocaoTipo(this.promocaoTipo);

  @override
  Widget build(BuildContext context) {
    var promocaoTipoController = GetIt.I.get<PromocaoTipoController>();
    AlertPromocaoTipo alertPromocaoTipo = AlertPromocaoTipo();

    return Observer(
      builder: (context) {
        PromocaoTipo promocaoTipo =
            promocaoTipoController.promocaoTipoSelecionada;

        return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              title: Text("Tipo *"),
              subtitle: promocaoTipo == null
                  ? Text("Selecione um tipo")
                  : Text(promocaoTipo.descricao),
              leading: Icon(Icons.list_alt_outlined),
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onTap: () {
                alertPromocaoTipo.alert(context, promocaoTipo);
              },
            ),
          ),
        );
      },
    );
  }
}
