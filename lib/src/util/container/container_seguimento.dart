
import 'package:flutter/material.dart';
import 'Dart:math';
import 'package:nosso/src/core/controller/seguimento_controller.dart';
import 'package:nosso/src/core/model/seguimento.dart';

class ContainerSeguimento extends StatelessWidget {
  SeguimentoController seguimentoController;
  Seguimento p;

  ContainerSeguimento(this.seguimentoController, this.p);

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      leading: Container(
        padding: EdgeInsets.all(1),
        child: CircleAvatar(
          backgroundColor: Color((random.nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1),
          radius: 25,
          child: Icon(Icons.wallet_giftcard_outlined),
        ),
      ),
      title: Text(p.nome),
      subtitle: Text("${p.id}"),
      trailing: Container(
        height: 80,
        width: 50,
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: Text("${p.categorias.length}"),
        ),
      ),
    );
  }
}
