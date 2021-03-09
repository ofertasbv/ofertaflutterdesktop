import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/controller/tamanho_controller.dart';
import 'package:nosso/src/core/model/tamanho.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class DialogTamanho extends StatefulWidget {
  @override
  _DialogTamanhoState createState() => _DialogTamanhoState();
}

class _DialogTamanhoState extends State<DialogTamanho> {
  var tamanhoController = GetIt.I.get<TamanhoController>();
  var produtoController = GetIt.I.get<ProdutoController>();

  bool clicadoTamanho = false;

  @override
  void initState() {
    tamanhoController.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildObserverTamanhos();
  }

  onSelectedTamanho(bool selected, Tamanho tamanho) {
    if (selected == true) {
      setState(() {
        produtoController.addTamanhos(tamanho);
      });
    } else {
      setState(() {
        produtoController.removerTamanhos(tamanho);
      });
    }
  }

  buildObserverTamanhos() {
    return Observer(
      builder: (context) {
        List<Tamanho> tamanhos = tamanhoController.tamanhos;
        if (tamanhoController.error != null) {
          return Text("Não foi possível carregados dados");
        }

        if (tamanhos == null) {
          return CircularProgressorMini();
        }

        return builderList(tamanhos);
      },
    );
  }

  builderList(List<Tamanho> tamanhos) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.separated(
      itemCount: tamanhos.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        Tamanho c = tamanhos[index];

        return CheckboxListTile(
          value:
              produtoController.tamanhoSelecionados.contains(tamanhos[index]),
          onChanged: (bool select) {
            clicadoTamanho = select;
            onSelectedTamanho(clicadoTamanho, c);
            print("Clicado: ${clicadoTamanho} - ${c.descricao}");
            for (Tamanho t in produtoController.tamanhoSelecionados) {
              print("Lista: ${t.descricao}");
            }
          },
          title: Text("${c.descricao}"),
        );
      },
    );
  }
}

class AlertTamanho {
  alert(BuildContext context, List<Tamanho> tamanhos) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: DialogTamanho(),
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
