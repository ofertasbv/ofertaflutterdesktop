import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/paginas/promocao/promocao_create_page.dart';
import 'package:nosso/src/paginas/promocao/promocao_detalhes_tab.dart';
import 'package:nosso/src/util/container/container_promocao.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class LojaPromocaoPage extends StatefulWidget {
  @override
  _LojaPromocaoPageState createState() => _LojaPromocaoPageState();
}

class _LojaPromocaoPageState extends State<LojaPromocaoPage> {
  var promocaoController = GetIt.I.get<PromoCaoController>();
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  @override
  void initState() {
    promocaoController.getAllByLoja(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas ofertas"),
        actions: [
          Observer(
            builder: (context) {
              if (promocaoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (promocaoController.promocoesByLoja == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.purple[800],
                child: Text(
                  (promocaoController.promocoesByLoja.length ?? 0).toString(),
                  style: TextStyle(color: Colors.yellow[900]),
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: builderConteudoList(),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return PromocaoCreatePage();
            }),
          );
        },
      ),
    );
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Promocao> promocoes = promocaoController.promocoesByLoja;
          if (promocaoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (promocoes == null) {
            return CircularProgressor();
          }

          return builderList(promocoes);
        },
      ),
    );
  }

  ListView builderList(List<Promocao> promocoes) {
    double containerWidth = 160;
    double containerHeight = 30;

    return ListView.builder(
      itemCount: promocoes.length,
      itemBuilder: (context, index) {
        Promocao p = promocoes[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: ContainerPromocao(promocaoController, p),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoDetalhesTab(p);
                },
              ),
            );
          },
        );
      },
    );
  }
}
