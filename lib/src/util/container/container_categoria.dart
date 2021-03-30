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
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor
            ],
          ),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(35),
        ),
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
      subtitle: Text("código ${p.id}"),
      trailing: Container(
        height: 80,
        width: 50,
      ),
    );
  }
}
