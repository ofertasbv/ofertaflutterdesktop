import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/model/promocao.dart';

class PromocaoDetalhesInfo extends StatefulWidget {
  Promocao p;

  PromocaoDetalhesInfo(this.p);

  @override
  _PromocaoDetalhesInfoState createState() => _PromocaoDetalhesInfoState();
}

class _PromocaoDetalhesInfoState extends State<PromocaoDetalhesInfo> {
  Promocao p;

  @override
  Widget build(BuildContext context) {
    p = widget.p;

    return buildContainer(p);
  }

  buildContainer(Promocao p) {
    var dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return ListView(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                child: Container(
                  padding: EdgeInsets.all(0),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        title: Text("Promoção"),
                        subtitle: Text("${p.nome}"),
                        trailing: Icon(Icons.check_outlined),
                        leading: Icon(Icons.add_alert_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Descrição"),
                        subtitle: Text("${p.descricao}"),
                        trailing: Icon(Icons.check_outlined),
                        leading: Icon(Icons.textsms_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Data Registro"),
                        subtitle: Text("${dateFormat.format(p.dataRegistro)}"),
                        trailing: Icon(Icons.check_outlined),
                        leading: Icon(Icons.calendar_today_outlined),
                      ),
                      ListTile(
                        title: Text("Loja"),
                        subtitle: Text("${p.loja.nome}"),
                        trailing: Icon(Icons.check_outlined),
                        leading: Icon(Icons.local_convenience_store_outlined),
                      ),
                      ListTile(
                        title: Text("Validade"),
                        subtitle: Text(
                            "${dateFormat.format(p.dataInicio)} até ${dateFormat.format(p.dataFinal)}"),
                        trailing: Icon(Icons.check_outlined),
                        leading: Icon(Icons.calendar_today_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Desconto"),
                        subtitle: Text("R\$ ${p.desconto}"),
                        trailing: Icon(Icons.check_outlined),
                        leading: Icon(Icons.monetization_on_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
