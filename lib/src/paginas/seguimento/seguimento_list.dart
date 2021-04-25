import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/seguimento_controller.dart';
import 'package:nosso/src/core/model/seguimento.dart';
import 'package:nosso/src/paginas/categoria/categoria_page.dart';
import 'package:nosso/src/util/container/container_seguimento.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class SeguimentoList extends StatefulWidget {
  @override
  _SeguimentoListState createState() => _SeguimentoListState();
}

class _SeguimentoListState extends State<SeguimentoList>
    with AutomaticKeepAliveClientMixin<SeguimentoList> {
  var seguimentoController = GetIt.I.get<SeguimentoController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    seguimentoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return seguimentoController.getAll();
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      seguimentoController.getAll();
    } else {
      nome = nomeController.text;
      seguimentoController.getAllByNome(nome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.grey[200],
            padding: EdgeInsets.all(0),
            child: ListTile(
              subtitle: TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: "busca por seguimentos",
                  prefixIcon: Icon(Icons.search_outlined),
                  suffixIcon: IconButton(
                    onPressed: () => nomeController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                  ),
                ),
                onChanged: filterByNome,
              ),
            ),
          ),
          SizedBox(height: 0),
          Expanded(
            child: Container(
              color: Colors.white,
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
          List<Seguimento> seguimentos = seguimentoController.seguimentos;
          if (seguimentoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (seguimentos == null) {
            return CircularProgressorMini();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(seguimentos),
          );
        },
      ),
    );
  }

  builderList(List<Seguimento> seguimentos) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: seguimentos.length,
      itemBuilder: (context, index) {
        Seguimento c = seguimentos[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: ContainerSeguimento(seguimentoController, c),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoriaPage(s: c);
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
