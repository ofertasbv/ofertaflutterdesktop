import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/endereco_controller.dart';
import 'package:nosso/src/core/model/endereco.dart';
import 'package:nosso/src/paginas/endereco/endereco_create_page.dart';
import 'package:nosso/src/paginas/endereco/endereco_location.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class EnderecoList extends StatefulWidget {
  @override
  _EnderecoListState createState() => _EnderecoListState();
}

class _EnderecoListState extends State<EnderecoList>
    with AutomaticKeepAliveClientMixin<EnderecoList> {
  var enderecoController = GetIt.I.get<EnderecoController>();

  @override
  void initState() {
    enderecoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return enderecoController.getAll();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return builderConteudoList();
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Endereco> enderecos = enderecoController.enderecos;
          if (enderecoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (enderecos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(enderecos),
          );
        },
      ),
    );
  }

  ListView builderList(List<Endereco> enderecos) {
    double containerWidth = 160;
    double containerHeight = 30;

    return ListView.builder(
      itemCount: enderecos.length,
      itemBuilder: (context, index) {
        Endereco e = enderecos[index];

        return GestureDetector(
          child: ListTile(
            isThreeLine: true,
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
                radius:20,
                child: Icon(Icons.location_on_outlined),
              ),
            ),
            title: Text("${e.logradouro}, ${e.numero}"),
            subtitle: Text("${e.complemento}"),
            trailing: Container(
              height: 80,
              width: 50,
              child: buildPopupMenuButton(context, e),
            ),
          ),
          onTap: () {},
        );
      },
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(
      BuildContext context, Endereco e) {
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
                return EnderecoCreatePage(
                  endereco: e,
                );
              },
            ),
          );
        }
        if (valor == "detalhes") {
          print("detalhes");
          Navigator.of(context).pop();
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (BuildContext context) {
          //       return EnderecoLocation(endereco: e);
          //     },
          //   ),
          // );
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
          value: 'detalhes',
          child: ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text('detalhes'),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
