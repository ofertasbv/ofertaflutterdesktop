import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/paginas/loja/loja_create_page.dart';
import 'package:nosso/src/paginas/loja/loja_detalhes_tab.dart';
import 'package:nosso/src/paginas/produto/produto_table.dart';
import 'package:nosso/src/paginas/promocao/promocao_table.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/filter/promocao_filter.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class LojaTable extends StatefulWidget {
  @override
  _LojaTableState createState() => _LojaTableState();
}

class _LojaTableState extends State<LojaTable>
    with AutomaticKeepAliveClientMixin<LojaTable> {
  var lojaController = GetIt.I.get<LojaController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    lojaController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return lojaController.getAll();
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      lojaController.getAll();
    } else {
      nome = nomeController.text;
      lojaController.getAllByNome(nome);
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
            height: 60,
            width: double.infinity,
            color: Colors.grey[200],
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
                onChanged: filterByNome,
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
          List<Loja> lojas = lojaController.lojas;
          if (lojaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (lojas == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(lojas),
          );
        },
      ),
    );
  }

  buildTable(List<Loja> lojas) {
    return ListView(
      children: [
        PaginatedDataTable(
          rowsPerPage: 8,
          showCheckboxColumn: true,
          sortColumnIndex: 1,
          sortAscending: true,
          showFirstLastButtons: true,
          columns: [
            DataColumn(label: Text("Código")),
            DataColumn(label: Text("Foto")),
            DataColumn(label: Text("Nome")),
            DataColumn(label: Text("Cnpj")),
            DataColumn(label: Text("Editar")),
            DataColumn(label: Text("Detalhes")),
            DataColumn(label: Text("Produtos")),
            DataColumn(label: Text("Promoções")),
          ],
          source: DataSource(lojas, context),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DataSource extends DataTableSource {
  var lojaController = GetIt.I.get<LojaController>();
  BuildContext context;
  List<Loja> lojas;
  int selectedCount = 0;

  DataSource(this.lojas, this.context);

  ProdutoFilter produtoFilter = ProdutoFilter();
  PromocaoFilter promocaoFilter = PromocaoFilter();

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= lojas.length) return null;
    Loja p = lojas[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(CircleAvatar(
          backgroundColor: Colors.grey[200],
          radius: 20,
        )),
        DataCell(Text("${p.nome}")),
        DataCell(Text(p.cnpj)),
        DataCell(IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LojaCreatePage(
                    loja: p,
                  );
                },
              ),
            );
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LojaDetalhesTab(p);
                },
              ),
            );
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            produtoFilter.loja = p.id;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoTable(filter: this.produtoFilter);
                },
              ),
            );
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            promocaoFilter.loja = p.id;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoTable(promocaoFilter: this.promocaoFilter);
                },
              ),
            );
          },
        )),
      ],
    );
  }

  @override
  int get rowCount => lojas.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
