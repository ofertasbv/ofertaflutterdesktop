import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/core/model/promocaotipo.dart';
import 'package:nosso/src/paginas/produto/produto_tab.dart';
import 'package:nosso/src/paginas/produto/produto_table.dart';
import 'package:nosso/src/paginas/promocao/promocao_create_page.dart';
import 'package:nosso/src/paginas/promocao/promocao_detalhes_tab.dart';
import 'package:nosso/src/util/filter/promocao_filter.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PromocaoTable extends StatefulWidget {
  @override
  _PromocaoTableState createState() => _PromocaoTableState();
}

class _PromocaoTableState extends State<PromocaoTable> {
  var promocaoController = GetIt.I.get<PromoCaoController>();
  var nomeController = TextEditingController();

  PromocaoFilter filter = PromocaoFilter();
  Promocao promocao;
  PromocaoTipo promocaoTipo;
  Loja loja;

  @override
  void initState() {
    if (filter == null) {
      filter = PromocaoFilter();
      promocao = Promocao();
      promocaoTipo = PromocaoTipo();
      loja = Loja();
    }

    promocaoController.getAll();
    super.initState();
  }

  pesquisarFilter() {
    print("pesquisa data inicio: ${filter.dataInicio}");
    print("pesquisa data encerramento: ${filter.dataFinal}");
    print("pesquisa nomePrmoção: ${filter.nomePromocao}");
    print("pesquisa promocaoTipo: ${filter.promocaoTipo}");
    print("pesquisa loja: ${filter.loja}");
    print("pesquisa...");
    promocaoController.getFilter(filter);
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('dd/MM/yyyy');
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.grey[100],
            padding: EdgeInsets.all(0),
            child: TextFormField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: "busca por promoções",
                prefixIcon: Icon(Icons.search_outlined),
                suffixIcon: IconButton(
                  onPressed: () => nomeController.clear(),
                  icon: Icon(Icons.clear),
                ),
              ),
              onChanged: (nome) {
                filter.nomePromocao = nomeController.text;
                print("promoção nome: ${nome}");
                print("promoção filter: ${filter.nomePromocao}");
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 50,
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 500,
                  color: Colors.grey[200],
                  child: DateTimeField(
                    format: dateFormat,
                    onChanged: (DateTime dataInicio) {
                      setState(() {
                        String convertedDateInicio =
                            "${dataInicio.day.toString().padLeft(2, '0')}/${dataInicio.month.toString().padLeft(2, '0')}/${dataInicio.year.toString()}";
                        filter.dataInicio = convertedDateInicio;
                        print("dataInicio: ${filter.dataFinal}");
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Início da promoção",
                      hintText: "99/09/9999",
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      suffixIcon: Icon(Icons.close),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple[900]),
                        gapPadding: 1,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        initialDate: currentValue ?? DateTime.now(),
                        locale: Locale('pt', 'BR'),
                        lastDate: DateTime(2030),
                      );
                    },
                  ),
                ),
                Container(
                  width: 500,
                  color: Colors.grey[200],
                  child: DateTimeField(
                    onChanged: (DateTime dataFinal) {
                      setState(() {
                        String convertedDateFinal =
                            "${dataFinal.day.toString().padLeft(2, '0')}/${dataFinal.month.toString().padLeft(2, '0')}/${dataFinal.year.toString()}";
                        filter.dataFinal = convertedDateFinal;
                        print("dataFinal: ${filter.dataFinal}");
                      });
                    },
                    format: dateFormat,
                    decoration: InputDecoration(
                      labelText: "Encerramento da promoção",
                      hintText: "99/09/9999",
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      suffixIcon: Icon(Icons.close),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple[900]),
                        gapPadding: 1,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        initialDate: currentValue ?? DateTime.now(),
                        locale: Locale('pt', 'BR'),
                        lastDate: DateTime(2030),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton.icon(
                  onPressed: () {
                    pesquisarFilter();
                  },
                  icon: Icon(Icons.search),
                  label: Text("Realizar pesquisa"),
                ),
                RaisedButton.icon(
                  onPressed: () {
                    promocaoController.getAll();
                  },
                  icon: Icon(Icons.refresh),
                  label: Text("Atualizar pesquisa"),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
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

          return builderTable(promocoes);
        },
      ),
    );
  }

  builderTable(List<Promocao> promocoes) {
    return ListView(
      children: [
        PaginatedDataTable(
          rowsPerPage: 8,
          showCheckboxColumn: true,
          sortColumnIndex: 1,
          sortAscending: true,
          showFirstLastButtons: true,
          columns: [
            DataColumn(label: Text("Cód")),
            DataColumn(label: Text("Foto")),
            DataColumn(label: Text("Nome")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Início")),
            DataColumn(label: Text("Encerramento")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
            DataColumn(label: Text("Produtos")),
          ],
          source: DataSource(promocoes, context),
        ),
      ],
    );
  }
}

class DataSource extends DataTableSource {
  var promocaoController = GetIt.I.get<PromoCaoController>();
  BuildContext context;
  List<Promocao> promocoes;
  int selectedCount = 0;
  var dateFormat = DateFormat('dd/MM/yyyy');

  DataSource(this.promocoes, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= promocoes.length) return null;
    Promocao p = promocoes[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(
          p.foto != null
              ? CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "${promocaoController.arquivo + p.foto}",
                  ),
                )
              : CircleAvatar(),
        ),
        DataCell(Text(p.nome)),
        DataCell(CircleAvatar(
          backgroundColor:
              p.status == true ? Colors.green[600] : Colors.red[600],
          child: Text("${p.status.toString().substring(0, 1).toUpperCase()}"),
        )),
        DataCell(Text("${dateFormat.format(p.dataInicio)}")),
        DataCell(Text("${dateFormat.format(p.dataFinal)}")),
        DataCell(IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoDetalhesTab(p);
                },
              ),
            );
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoCreatePage(
                    promocao: p,
                  );
                },
              ),
            );
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.shopping_basket_outlined),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoTab();
                },
              ),
            );
          },
        )),
      ],
    );
  }

  @override
  int get rowCount => promocoes.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
