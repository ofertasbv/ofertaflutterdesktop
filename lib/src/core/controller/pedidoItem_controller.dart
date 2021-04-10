import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/core/repository/pedidoItem_repository.dart';
import 'package:nosso/src/paginas/pedidoitem/carrinho_item.dart';
import 'package:nosso/src/util/filter/pedidoitem_filter.dart';

part 'pedidoItem_controller.g.dart';

class PedidoItemController = PedidoItemControllerBase
    with _$PedidoItemController;

abstract class PedidoItemControllerBase with Store {
  PedidoItemRepository pedidoItemRepository;
  CarrinhoItem carrinhoItem;

  PedidoItemControllerBase() {
    carrinhoItem = CarrinhoItem();
    pedidoItemRepository = PedidoItemRepository();
  }

  @observable
  int quantidade = 1;

  @observable
  double valorUnitario = 0;

  @observable
  double valorTotal = 0;

  @observable
  double desconto = 0;

  @observable
  double total = 0;

  @observable
  double totalDesconto = 0;

  @observable
  List<PedidoItem> pedidoItens;

  @observable
  List<PedidoItem> itens = List<PedidoItem>();

  @observable
  int pedidoitem;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<PedidoItem>> getAll() async {
    try {
      pedidoItens = await pedidoItemRepository.getAll();
      return pedidoItens;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<PedidoItem>> getFilter(PedidoItemFilter filter) async {
    try {
      pedidoItens = await pedidoItemRepository.getFilter(filter);
      return pedidoItens;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(PedidoItem p) async {
    try {
      pedidoitem = await pedidoItemRepository.create(p.toJson());
      if (pedidoitem == null) {
        mensagem = "sem dados";
      } else {
        return pedidoitem;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, PedidoItem p) async {
    try {
      pedidoitem = await pedidoItemRepository.update(id, p.toJson());
      return pedidoitem;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  List<PedidoItem> pedidosItens() {
    try {
      return itens = carrinhoItem.itens;
    } catch (e) {
      error = e;
    }
  }

  @action
  adicionar(PedidoItem item) {
    carrinhoItem.adicionar(item);
  }

  @action
  isExisteItem(PedidoItem item) {
    return carrinhoItem.isExisteItem(item);
  }

  @action
  incremento(PedidoItem item) {
    carrinhoItem.incremento(item);
  }

  @action
  decremento(PedidoItem item) {
    carrinhoItem.decremento(item);
  }

  @action
  remove(PedidoItem item) {
    carrinhoItem.itens.remove(item);
    carrinhoItem.calculateTotal();
  }

  @action
  calculateTotal() {
    return this.total = carrinhoItem.calculateTotal();
  }

  @action
  calculateDesconto() {
    carrinhoItem.calculateDesconto();
  }
}
