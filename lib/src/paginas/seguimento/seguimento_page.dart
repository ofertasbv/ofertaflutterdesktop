import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/seguimento_controller.dart';
import 'package:nosso/src/core/model/seguimento.dart';
import 'package:nosso/src/paginas/seguimento/seguimento_list.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class SeguimentoPage extends StatefulWidget {
  @override
  _SeguimentoPageState createState() => _SeguimentoPageState();
}

class _SeguimentoPageState extends State<SeguimentoPage> {
  var seguimentoController = GetIt.I.get<SeguimentoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("todos os seguimentos"),
        elevation: 0,
        titleSpacing: 50,
        actions: [
          Observer(
            builder: (context) {
              List<Seguimento> seguimentos = seguimentoController.seguimentos;
              if (seguimentoController.error != null) {
                return Text("Não foi possível carregados dados");
              }

              if (seguimentos == null) {
                return CircularProgressorMini();
              }

              return CircleAvatar(
                foregroundColor: Theme.of(context).accentColor,
                child: Text(
                  (seguimentoController.seguimentos.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 5),
          CircleAvatar(
            foregroundColor: Theme.of(context).accentColor,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {
                seguimentoController.getAll();
              },
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: SeguimentoList(),
      ),
    );
  }
}
