import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/tamanho.dart';
import 'package:nosso/src/util/dialogs/dialog_tamanho.dart';

class DropDownTamanho extends StatelessWidget {
 List<Tamanho> tamanhos;
  DropDownTamanho(this.tamanhos);

  @override
  Widget build(BuildContext context) {
    var produtoController = GetIt.I.get<ProdutoController>();
    AlertTamanho alertTamanho = AlertTamanho();

    return Observer(
      builder: (context) {
        List<Tamanho> tamanhos = produtoController.tamanhoSelecionados;

        return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              title: Text("Tamnhos *"),
              subtitle: tamanhos.isEmpty
                  ? Text("Selecione tamanhos")
                  : Text("${tamanhos.map((e) => e.descricao)}"),
              leading: Icon(Icons.list_alt_outlined),
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onTap: () {
                alertTamanho.alert(context, tamanhos);
              },
            ),
          ),
        );
      },
    );
  }
}
