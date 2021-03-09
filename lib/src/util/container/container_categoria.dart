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
            colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor],
          ),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(35),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          radius: 20,
          backgroundImage: NetworkImage(
            "${categoriaController.arquivo + p.foto}",
          ),
        ),
      ),
      title: Text(p.nome),
      subtitle: Text("código ${p.id}"),
      trailing: Container(
        height: 80,
        width: 50,
        child: buildPopupMenuButton(context, p),
      ),
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(
      BuildContext context, Categoria c) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: Icon(Icons.more_vert),
      onSelected: (valor) {
        if (valor == "novo") {
          print("novo");
        }
        if (valor == "editar") {
          print("editar");
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return CategoriaCreatePage(
                  categoria: c,
                );
              },
            ),
          );
        }
        if (valor == "delete") {
          print("delete");
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'novo',
          child: ListTile(
            leading: Icon(Icons.add),
            title: Text('novo'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'editar',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('editar'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
        )
      ],
    );
  }
}
