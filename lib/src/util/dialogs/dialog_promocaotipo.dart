import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/promocaotipo_controller.dart';
import 'package:nosso/src/core/model/promocaotipo.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class DialogPromocaoTipo extends StatefulWidget {
  PromocaoTipo promocaoTipo;
  DialogPromocaoTipo(this.promocaoTipo);

  @override
  _DialogPromocaoTipoState createState() => _DialogPromocaoTipoState(this.promocaoTipo);
}

class _DialogPromocaoTipoState extends State<DialogPromocaoTipo> {
  _DialogPromocaoTipoState(this.promocaoTipo);
  var promocaoTipoController = GetIt.I.get<PromocaoTipoController>();

  PromocaoTipo promocaoTipo;

  @override
  void initState() {
    promocaoTipoController.getAll();
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
          List<PromocaoTipo> promocaoTipos =
              promocaoTipoController.promocaoTipos;
          if (promocaoTipoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (promocaoTipos == null) {
            return CircularProgressorMini();
          }

          return builderListLojas(promocaoTipos);
        },
      ),
    );
  }

  builderListLojas(List<PromocaoTipo> promocaoTipos) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: promocaoTipos.length,
      itemBuilder: (context, index) {
        PromocaoTipo c = promocaoTipos[index];

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
                  child: CircleAvatar(),
                ),
                title: Text(c.descricao),
              ),
              onTap: () {
                promocaoTipoController.promocaoTipoSelecionada = c;
                print(
                    "Loja: ${promocaoTipoController.promocaoTipoSelecionada.descricao}");
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

class AlertPromocaoTipo {
  alert(BuildContext context, PromocaoTipo promocaoTipo) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: DialogPromocaoTipo(promocaoTipo),
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
