import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/model/subcategoria.dart';

class ContainerSubCategoria extends StatelessWidget {
  SubCategoriaController categoriaController;
  SubCategoria p;

  ContainerSubCategoria(this.categoriaController, this.p);

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      leading: Container(
        padding: EdgeInsets.all(1),
        child: CircleAvatar(
          backgroundColor: Color((random.nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1),
          child: Icon(Icons.wallet_giftcard),
          radius: 25,
        ),
      ),
      title: Text(p.nome),
      subtitle: Text("${p.categoria.nome}"),
      trailing: Container(
        height: 80,
        width: 50,
        child: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text("${p.produtos.length}"),
        ),
      ),
    );
  }
}
