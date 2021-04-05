import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/cliente_controller.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/controller/pedido_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/cliente.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/pedido.dart';
import 'package:nosso/src/paginas/pagamento/pagamento_create_page.dart';
import 'package:nosso/src/paginas/pedido/pedido_create_page.dart';
import 'package:nosso/src/util/filter/pedido_filter.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class PedidoTable extends StatefulWidget {
  @override
  _PedidoTableState createState() => _PedidoTableState();
}

class _PedidoTableState extends State<PedidoTable> {
  var pedidoController = GetIt.I.get<PedidoController>();
  var produtoController = GetIt.I.get<ProdutoController>();
  var lojaController = GetIt.I.get<LojaController>();
  var clienteController = GetIt.I.get<ClienteController>();
  var descricaoController = TextEditingController();

  PedidoFilter filter;
  Pedido pedido;
  Loja loja;
  Cliente cliente;

  @override
  void initState() {
    if (filter == null) {
      filter = PedidoFilter();
      pedido = Pedido();
      loja = Loja();
      cliente = Cliente();
      pedidoController.getAll();
    } else {
      pedidoController.getFilter(filter);
    }

    lojaController.getAll();
    clienteController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return pedidoController.getAll();
  }

  bool isLoading = true;

  pesquisarFilter() {
    print("pesquisa data dataRegistro: ${filter.dataRegistro}");
    print("pesquisa data dataEntrega: ${filter.dataEntrega}");
    print("pesquisa descricao: ${filter.descricao}");
    print("pesquisa pedidoStatus: ${filter.pedidoStatus}");
    print("pesquisa cliente: ${filter.cliente}");
    print("pesquisa loja: ${filter.loja}");
    print("pesquisa...");
    pedidoController.getFilter(filter);
  }

  builderConteudoListClientes() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Cliente> clientes = clienteController.clientes;
          if (clienteController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (clientes == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Cliente>(
            label: "Selecione clientes",
            popupTitle: Center(child: Text("Clientes")),
            items: clientes,
            showSearchBox: true,
            itemAsString: (Cliente c) => c.nome,
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            onChanged: (Cliente c) {
              setState(() {
                pedido.cliente = c;
                print("Cliente: ${pedido.cliente.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por cliente",
            ),
          );
        },
      ),
    );
  }

  builderConteudoListLojas() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Loja> lojas = lojaController.lojas;
          if (lojaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (lojas == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Loja>(
            label: "Selecione lojas",
            popupTitle: Center(child: Text("Lojas")),
            items: lojas,
            showSearchBox: true,
            itemAsString: (Loja s) => s.nome,
            isFilteredOnline: true,
            showClearButton: true,
            onChanged: (Loja l) {
              setState(() {
                loja = l;
                filter.loja = loja.id;
                print("loja nome: ${loja.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por loja",
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('dd-MM-yyyy');
    return Container(
      child: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.grey[100],
            padding: EdgeInsets.all(0),
            child: TextFormField(
              controller: descricaoController,
              decoration: InputDecoration(
                labelText: "busca por promoções",
                prefixIcon: Icon(Icons.search_outlined),
                suffixIcon: IconButton(
                  onPressed: () => descricaoController.clear(),
                  icon: Icon(Icons.clear),
                ),
              ),
              onChanged: (nome) {
                filter.descricao = descricaoController.text;
                print("por descrição: ${nome}");
                print("descrição filter: ${filter.descricao}");
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
                    onChanged: (DateTime dataRegistro) {
                      setState(() {
                        String convertedDateRegistro =
                            "${dataRegistro.day.toString().padLeft(2, '0')}-${dataRegistro.month.toString().padLeft(2, '0')}-${dataRegistro.year.toString()}";
                        filter.dataRegistro = convertedDateRegistro;
                        print("dataRegistro: ${filter.dataRegistro}");
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Data Registro",
                      hintText: "99/09/9999",
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      suffixIcon: Icon(Icons.close),
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
                    onChanged: (DateTime dataRegistro) {
                      setState(() {
                        String convertedDateEntrega =
                            "${dataRegistro.day.toString().padLeft(2, '0')}-${dataRegistro.month.toString().padLeft(2, '0')}-${dataRegistro.year.toString()}";
                        filter.dataEntrega = convertedDateEntrega;
                        print("dataEntraga: ${filter.dataEntrega}");
                      });
                    },
                    format: dateFormat,
                    decoration: InputDecoration(
                      labelText: "Data Entrega",
                      hintText: "99/09/9999",
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      suffixIcon: Icon(Icons.close),
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
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 500,
                  color: Colors.grey[200],
                  child: builderConteudoListClientes(),
                ),
                Container(
                  width: 500,
                  color: Colors.grey[200],
                  child: builderConteudoListLojas(),
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
                    pedidoController.getAll();
                    filter = new PedidoFilter();
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
          )),
        ],
      ),
    );
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Pedido> pedidos = pedidoController.pedidos;
          if (pedidoController.error != null) {
            return Text("Não foi possível buscar permissões");
          }

          if (pedidos == null) {
            return Center(
              child: CircularProgressor(),
            );
          }

          return buildTable(pedidos);
        },
      ),
    );
  }

  buildTable(List<Pedido> pedidos) {
    return ListView(
      children: [
        PaginatedDataTable(
          rowsPerPage: 8,
          showCheckboxColumn: true,
          sortColumnIndex: 1,
          sortAscending: true,
          showFirstLastButtons: true,
          columnSpacing: 10,
          columns: [
            DataColumn(label: Text("Cód")),
            DataColumn(label: Text("Descrição.")),
            DataColumn(label: Text("Valor")),
            DataColumn(label: Text("Cliente")),
            DataColumn(label: Text("Loja")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
            DataColumn(label: Text("Itens")),
            DataColumn(label: Text("Pagamento")),
          ],
          source: DataSource(pedidos, context),
        ),
      ],
    );
  }
}

class DataSource extends DataTableSource {
  var pedidoController = GetIt.I.get<PedidoController>();
  BuildContext context;
  List<Pedido> pedidos;
  int selectedCount = 0;

  DataSource(this.pedidos, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= pedidos.length) return null;
    Pedido p = pedidos[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.descricao}")),
        DataCell(Text(
          "${p.valorTotal}",
          style: TextStyle(color: Colors.red),
        )),
        DataCell(Text("${p.cliente.nome}")),
        DataCell(Text("${p.loja.nome}")),
        DataCell(Text("${p.pedidoStatus}")),
        DataCell(IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PedidoCreatePage(
                    pedido: p,
                  );
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
                  return PedidoCreatePage(
                    pedido: p,
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
                  return PedidoCreatePage(
                    pedido: p,
                  );
                },
              ),
            );
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.credit_card_outlined),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PagamentoCreatePage();
                },
              ),
            );
          },
        )),
      ],
    );
  }

  @override
  int get rowCount => pedidos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
