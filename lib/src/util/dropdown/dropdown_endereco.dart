import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/endereco_controller.dart';
import 'package:nosso/src/core/model/endereco.dart';
import 'package:nosso/src/paginas/endereco/endereco_search.dart';

class DropDownEndereco extends StatelessWidget {
  Endereco endereco;
  DropDownEndereco(this.endereco);

  @override
  Widget build(BuildContext context) {
    var enderecoController = GetIt.I.get<EnderecoController>();
    return Observer(
      builder: (context) {
        Endereco endereco = enderecoController.enderecoSelecionado;

        return Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              title: Text("Endereço *"),
              subtitle: endereco == null
                  ? Text("Selecione um endereço")
                  : Text("${endereco.logradouro}, ${endereco.numero} - ${endereco.complemento}"),
              leading: Icon(Icons.location_on_outlined),
              trailing: Icon(Icons.arrow_drop_down_sharp),
              onTap: () {
                showSearch(
                  context: context,
                  delegate: EnderecoSearchDelegate(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
