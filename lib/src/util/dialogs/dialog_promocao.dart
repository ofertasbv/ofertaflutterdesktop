import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class DialogPromocao extends StatefulWidget {
  Promocao promocao;
  DialogPromocao(this.promocao);
  @override
  _DialogPromocaoState createState() => _DialogPromocaoState(this.promocao);
}

class _DialogPromocaoState extends State<DialogPromocao> {
  _DialogPromocaoState(this.promocao);

  var promocaoController = GetIt.I.get<PromoCaoController>();

  Promocao promocao;

  @override
  void initState() {
    promocaoController.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return builderConteudoListPromocao();
  }

  /* ===================  PROMOÇÃO LISTA ===================  */

  builderConteudoListPromocao() {
    return Container(
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

          return builderListPromocoes(promocoes);
        },
      ),
    );
  }

  builderListPromocoes(List<Promocao> promocoes) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: promocoes.length,
      itemBuilder: (context, index) {
        Promocao c = promocoes[index];

        return Column(
          children: [
            GestureDetector(
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.grey[900]],
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: c.foto != null
                      ? CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          radius: 20,
                          backgroundImage: NetworkImage(
                            "${promocaoController.arquivo + c.foto}",
                          ),
                        )
                      : CircleAvatar(),
                ),
                title: Text(c.nome),
              ),
              onTap: () {
                promocaoController.promocaoSelecionada = c;
                print("Loja: ${promocaoController.promocaoSelecionada.nome}");
                Navigator.of(context).pop();
              },
            ),
            Divider()
          ],
        );
      },
    );
  }
}

class AlertPromocao {
  alert(BuildContext context, Promocao promocao) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: DialogPromocao(promocao),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("ok"),
            )
          ],
        );
      },
    );
  }
}
