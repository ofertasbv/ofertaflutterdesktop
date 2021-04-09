import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/paginas/produto/produto_page.dart';
import 'package:nosso/src/paginas/promocao/promocao_detalhes_tab.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class PromocaoListHome extends StatefulWidget {
  Loja p;

  PromocaoListHome({Key key, this.p}) : super(key: key);

  @override
  _PromocaoListHomeState createState() => _PromocaoListHomeState(p: this.p);
}

class _PromocaoListHomeState extends State<PromocaoListHome>
    with AutomaticKeepAliveClientMixin<PromocaoListHome> {
  var promocaoController = GetIt.I.get<PromoCaoController>();
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  Loja p;
  ProdutoFilter filter = ProdutoFilter();

  _PromocaoListHomeState({this.p});

  @override
  void initState() {
    promocaoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return promocaoController.getAll();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return builderConteudoList();
  }

  builderConteudoList() {
    return Container(
      height: 400,
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Promocao> promocoes = promocaoController.promocoes;
          if (promocaoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (promocoes == null) {
            return CircularProgressorMini();
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
    double containerWidth = 350;
    double containerHeight = 50;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: promocoes.length,
      itemBuilder: (context, index) {
        Promocao p = promocoes[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Card(
              child: AnimatedContainer(
                height: 400,
                width: containerWidth,
                duration: Duration(seconds: 1),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: p.foto != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                              ),
                              child: Image.network(
                                promocaoController.arquivo + p.foto,
                                fit: BoxFit.cover,
                                width: containerWidth,
                                height: 350,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                              ),
                              child: Image.asset(
                                ConstantApi.urlLogo,
                                fit: BoxFit.cover,
                                width: containerWidth,
                                height: 350,
                              ),
                            ),
                    ),
                    SizedBox(height: 0),
                    Container(
                      height: 95,
                      width: containerWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: ListTile(
                        title: Text(
                          p.nome.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        subtitle: Text(
                          p.loja.nome.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[800],
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
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
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
