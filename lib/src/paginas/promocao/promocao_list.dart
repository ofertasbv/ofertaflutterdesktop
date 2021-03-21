import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/paginas/produto/produto_page.dart';
import 'package:nosso/src/paginas/promocao/promocao_detalhes_tab.dart';
import 'package:nosso/src/util/container/container_promocao.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PromocaoList extends StatefulWidget {
  Loja p;

  PromocaoList({Key key, this.p}) : super(key: key);

  @override
  _PromocaoListState createState() => _PromocaoListState(p: this.p);
}

class _PromocaoListState extends State<PromocaoList>
    with AutomaticKeepAliveClientMixin<PromocaoList> {
  var promocaoController = GetIt.I.get<PromoCaoController>();
  var nomeController = TextEditingController();

  Loja p;
  ProdutoFilter filter = ProdutoFilter();

  _PromocaoListState({this.p});

  @override
  void initState() {
    promocaoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return promocaoController.getAll();
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      promocaoController.getAll();
    } else {
      nome = nomeController.text;
      promocaoController.getAllByNome(nome);
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
          SizedBox(height: 0),
          Container(
            height: 80,
            width: double.infinity,
            color: Colors.grey[200],
            padding: EdgeInsets.all(0),
            child: ListTile(
              subtitle: TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: "busca por promoções",
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
          SizedBox(height: 0),
          Expanded(
            child: Container(
              color: Colors.grey[200],
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
          List<Promocao> promocoes = promocaoController.promocoes;
          if (promocaoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (promocoes == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(promocoes),
          );
        },
      ),
    );
  }

  ListView builderList(List<Promocao> promocoes) {
    double containerWidth = 160;
    double containerHeight = 30;

    return ListView.separated(
      itemCount: promocoes.length,
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        Promocao p = promocoes[index];

        return Container(
          padding: EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: ContainerPromocao(promocaoController, p),
            ),
            onTap: () {
              filter.promocao = p.id;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProdutoPage(filter: filter);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
