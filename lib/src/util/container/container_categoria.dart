import 'package:flutter/material.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/paginas/categoria/categoria_create_page.dart';

class ContainerCategoria extends StatelessWidget {
  CategoriaController categoriaController;
  Categoria p;

  ContainerCategoria(this.categoriaController, this.p);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      leading: Container(
        padding: EdgeInsets.all(1),
        child: p.foto != null
            ? CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 20,
                backgroundImage: NetworkImage(
                  "${categoriaController.arquivo + p.foto}",
                ),
              )
            : CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 20,
              ),
      ),
      title: Text(p.nome),
      subtitle: Text("${p.seguimento.nome}"),
      trailing: CircleAvatar(
        backgroundColor: Colors.grey[100],
        child: Text(p.subCategorias.length.toString()),
      ),
    );
  }
}
