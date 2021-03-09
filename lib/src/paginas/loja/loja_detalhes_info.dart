import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/promocao.dart';

class LojaDetalhesInfo extends StatefulWidget {
  Loja p;

  LojaDetalhesInfo(this.p);

  @override
  _LojaDetalhesInfoState createState() => _LojaDetalhesInfoState();
}

class _LojaDetalhesInfoState extends State<LojaDetalhesInfo> {
  Loja p;

  @override
  Widget build(BuildContext context) {
    p = widget.p;

    return buildContainer(p);
  }

  buildContainer(Loja p) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');

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
                        title: Text("Loja"),
                        subtitle: Text("${p.nome}"),
                        trailing: Icon(Icons.check_outlined),
                        leading: Icon(Icons.add_alert_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Razão social"),
                        subtitle: Text("${p.razaoSocial}"),
                        trailing: Icon(Icons.check_outlined),
                        leading: Icon(Icons.textsms_outlined),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("CNPJ"),
                        subtitle: Text("${p.cnpj}"),
                        trailing: Icon(Icons.check_outlined),
                        leading: Icon(Icons.textsms_outlined),
                      ),
                      Divider(),
                      // ListTile(
                      //   title: Text("Data Registro"),
                      //   subtitle: Text("${dateFormat.format(p.dataRegistro)}"),
                      //   trailing: Icon(Icons.check_outlined),
                      //   leading: Icon(Icons.calendar_today_outlined),
                      // ),
                      Divider(),
                      p.enderecos.isNotEmpty
                          ? ListTile(
                              title: Text("Endereço"),
                              subtitle: Text("${p.enderecos[0].logradouro}"),
                              trailing: Icon(Icons.check_outlined),
                              leading: Icon(Icons.location_on_outlined),
                            )
                          : ListTile(
                              title: Text("sem endereços"),
                              trailing: Icon(Icons.add_location_outlined),
                              leading: Icon(Icons.location_disabled_outlined),
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
