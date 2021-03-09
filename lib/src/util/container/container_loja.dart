import 'package:flutter/material.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/paginas/loja/loja_create_page.dart';
import 'package:nosso/src/paginas/loja/loja_detalhes_tab.dart';

class ContainerLoja extends StatelessWidget {
  LojaController lojaController;
  Loja p;

  ContainerLoja(this.lojaController, this.p);

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
                  "${lojaController.arquivo + p.foto}",
                ),
              )
            : CircleAvatar(),
      ),
      title: Text(p.nome),
      subtitle: Text("${p.telefone}"),
      trailing: Container(
        height: 80,
        width: 50,
        child: buildPopupMenuButton(context, p),
      ),
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(BuildContext context, Loja p) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: Icon(Icons.more_vert),
      onSelected: (valor) {
        if (valor == "novo") {
          print("novo");
        }

        if (valor == "editar") {
          print("editar");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return LojaCreatePage(
                  loja: p,
                );
              },
            ),
          );
        }

        if (valor == "detalhes") {
          print("detalhes");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return LojaDetalhesTab(p);
              },
            ),
          );
        }

        if (valor == "delete") {
          print("delete");
        }

        if (valor == "local") {
          print("local");
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
          value: 'detalhes',
          child: ListTile(
            leading: Icon(Icons.search),
            title: Text('detalhes'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('delete'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'local',
          child: ListTile(
            leading: Icon(Icons.location_on),
            title: Text('local'),
          ),
        )
      ],
    );
  }
}
