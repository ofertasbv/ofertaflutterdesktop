import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/caixa_controller.dart';
import 'package:nosso/src/core/controller/marca_controller.dart';
import 'package:nosso/src/core/model/caixa.dart';
import 'package:nosso/src/core/model/marca.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class DialogCaixa extends StatefulWidget {
  Caixa caixa;
  DialogCaixa(this.caixa);

  @override
  _DialogCaixaState createState() => _DialogCaixaState(this.caixa);
}

class _DialogCaixaState extends State<DialogCaixa> {
  _DialogCaixaState(this.caixa);

  var caixaController = GetIt.I.get<CaixaController>();
  Caixa caixa;

  @override
  void initState() {
    caixaController.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return builderConteudoListMarca();
  }

  builderConteudoListMarca() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Caixa> caixas = caixaController.caixas;
          if (caixaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (caixas == null) {
            return CircularProgressorMini();
          }

          return builderListMarcas(caixas);
        },
      ),
    );
  }

  builderListMarcas(List<Caixa> caixas) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: caixas.length,
      itemBuilder: (context, index) {
        Caixa c = caixas[index];

        return Column(
          children: [
            GestureDetector(
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.grey[900]],
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 15,
                    child: Text(
                      c.descricao.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                title: Text(c.descricao),
              ),
              onTap: () {
                caixaController.caixaSelecionado = c;
                print("Marca: ${caixaController.caixaSelecionado.descricao}");
                Navigator.of(context).pop();
              },
            ),
            Divider()
          ],
        );
      },
    );
  }
}

class AlertCaixa {
  alert(BuildContext context, Caixa caixa) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: DialogCaixa(caixa),
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
