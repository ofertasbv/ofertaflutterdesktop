import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class DialogLoja extends StatefulWidget {
  Loja loja;
  DialogLoja(this.loja);

  @override
  _DialogLojaState createState() => _DialogLojaState(this.loja);
}

class _DialogLojaState extends State<DialogLoja> {
  _DialogLojaState(this.loja);
  var lojaController = GetIt.I.get<LojaController>();

  Loja loja;

  @override
  void initState() {
    lojaController.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return builderConteudoListLojas();
  }

  builderConteudoListLojas() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Loja> lojas = lojaController.lojas;
          if (lojaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (lojas == null) {
            return CircularProgressorMini();
          }

          return builderListLojas(lojas);
        },
      ),
    );
  }

  builderListLojas(List<Loja> lojas) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: lojas.length,
      itemBuilder: (context, index) {
        Loja c = lojas[index];

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
                  child: c.foto != null
                      ? CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          radius: 20,
                          backgroundImage: NetworkImage(
                            "${lojaController.arquivo + c.foto}",
                          ),
                        )
                      : CircleAvatar(),
                ),
                title: Text(c.nome),
              ),
              onTap: () {
                lojaController.lojaSelecionada = c;
                print("Loja: ${lojaController.lojaSelecionada.nome}");
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

class AlertLoja {
  alert(BuildContext context, Loja loja) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: DialogLoja(loja),
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
