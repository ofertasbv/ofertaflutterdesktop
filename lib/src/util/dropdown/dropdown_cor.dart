import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/cor.dart';
import 'package:nosso/src/util/dialogs/dialog_cor.dart';

class DropDownCor extends StatelessWidget {
  List<Cor> cores;
  DropDownCor(this.cores);

  @override
  Widget build(BuildContext context) {
    var produtoController = GetIt.I.get<ProdutoController>();
    AlertCor alertCor = AlertCor();

    return Observer(
      builder: (context) {
        List<Cor> cores = produtoController.corSelecionadas;

        return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              title: Text("Cores *"),
              subtitle: cores.isEmpty
                  ? Text("Selecione cores")
                  : Text("${cores.map((e) => e.descricao)}"),
              leading: Icon(Icons.list_alt_outlined),
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onTap: () {
                alertCor.alert(context, cores);
              },
            ),
          ),
        );
      },
    );
  }
}
