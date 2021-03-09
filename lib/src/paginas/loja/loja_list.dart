import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/paginas/loja/loja_detalhes_tab.dart';
import 'package:nosso/src/util/container/container_loja.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class LojaList extends StatefulWidget {
  @override
  _LojaListState createState() => _LojaListState();
}

class _LojaListState extends State<LojaList>
    with AutomaticKeepAliveClientMixin<LojaList> {
  var lojaController = GetIt.I.get<LojaController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    lojaController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return lojaController.getAll();
  }

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      lojaController.getAll();
    } else {
      nome = nomeController.text;
      lojaController.getAllByNome(nome);
    }
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 0),
          Container(
            height: 80,
            width: double.infinity,
            color: Colors.grey[100],
            padding: EdgeInsets.all(5),
            child: ListTile(
              subtitle: TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: "busca por lojas",
                  prefixIcon: Icon(Icons.search_outlined),
                  suffixIcon: IconButton(
                    onPressed: () => nomeController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                ),
                onChanged: filterByNome,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: builderConteudoList(),
            ),
          ),
        ],
      ),
    );
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Loja> lojas = lojaController.lojas;
          if (lojaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (lojas == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(lojas),
          );
        },
      ),
    );
  }

  ListView builderList(List<Loja> lojas) {
    double containerWidth = 160;
    double containerHeight = 30;

    return ListView.builder(
      itemCount: lojas.length,
      itemBuilder: (context, index) {
        Loja p = lojas[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: ContainerLoja(lojaController, p),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LojaDetalhesTab(p);
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
