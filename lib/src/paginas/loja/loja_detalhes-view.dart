import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:url_launcher/url_launcher.dart';

class LojaDetalhesView extends StatefulWidget {
  Loja p;

  LojaDetalhesView(this.p);

  @override
  _LojaDetalhesViewState createState() => _LojaDetalhesViewState();
}

class _LojaDetalhesViewState extends State<LojaDetalhesView> {
  var selectedCard = 'WEIGHT';
  var lojaController = GetIt.I.get<LojaController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Loja p = widget.p;
    return buildContainer(p);
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'u-nosso',
    path: 'ofertasbv@gmail.com',
    queryParameters: {'subject': 'Receba ofertas todos os dias!'},
  );

  buildContainer(Loja p) {
    var dateFormat = DateFormat('dd/MM/yyyy');
    return ListView(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: p.foto != null
              ? Image.network(
                  lojaController.arquivo + p.foto,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  ConstantApi.urlLogo,
                  fit: BoxFit.cover,
                ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ListTile(
                title: Text(p.nome),
                subtitle: Text("${p.telefone}"),
                trailing: CircleAvatar(
                  backgroundColor: Colors.blue[400],
                  foregroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      launch("tel: ${p.telefone}");
                    },
                    icon: Icon(Icons.phone),
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
