import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pagamento_controller.dart';
import 'package:nosso/src/core/model/pagamento.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PagamentoTable extends StatefulWidget {
  @override
  _PagamentoTableState createState() => _PagamentoTableState();
}

class _PagamentoTableState extends State<PagamentoTable>
    with AutomaticKeepAliveClientMixin<PagamentoTable> {
  var pagamentoController = GetIt.I.get<PagamentoController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    pagamentoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return pagamentoController.getAll();
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
                  labelText: "busca por nome",
                  prefixIcon: Icon(Icons.search_outlined),
                  suffixIcon: IconButton(
                    onPressed: () => nomeController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                ),
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
          List<Pagamento> pagamentos = pagamentoController.pagamentos;
          if (pagamentoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (pagamentos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderTable(pagamentos),
          );
        },
      ),
    );
  }

  builderTable(List<Pagamento> pagamentos) {
    return DataTable(
      sortAscending: true,
      showCheckboxColumn: true,
      showBottomBorder: true,
      columnSpacing: 55,
      columns: [
        DataColumn(label: Text("Código")),
        DataColumn(label: Text("Quantidade")),
        DataColumn(label: Text("Forma")),
        DataColumn(label: Text("Tipo")),
        DataColumn(label: Text("Valor")),
        DataColumn(label: Text("Registro")),
        DataColumn(label: Text("Visualizar")),
        DataColumn(label: Text("Editar")),
        DataColumn(label: Text("Faturas")),
      ],
      rows: pagamentos
          .map(
            (p) => DataRow(
              onSelectChanged: (i) {
                setState(() {
                  // selecionaItem(p);
                });
              },
              cells: [
                DataCell(Text("${p.id}")),
                DataCell(Text("${p.quantidade}")),
                DataCell(Text(p.pagamentoForma)),
                DataCell(Text("${p.pagamentoTipo}")),
                DataCell(Text("${p.valor}")),
                DataCell(Text("${p.dataPagamento}")),
                DataCell(IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                )),
                DataCell(IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                )),
                DataCell(IconButton(
                  icon: Icon(Icons.monetization_on_outlined),
                  onPressed: () {},
                )),
              ],
            ),
          )
          .toList(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
