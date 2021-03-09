import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/pedido.dart';
import 'package:nosso/src/core/repository/pedido_repository.dart';

part 'pedido_controller.g.dart';

class PedidoController = PedidoControllerBase with _$PedidoController;

abstract class PedidoControllerBase with Store {
  PedidoRepository pedidoRepository;

  PedidoControllerBase() {
    pedidoRepository = PedidoRepository();
  }

  @observable
  double valorTotal = 0;

  @observable
  double desconto = 0;

  @observable
  double total = 0;

  @observable
  double totalDesconto = 0;

  @observable
  List<Pedido> pedidos;

  @observable
  int pedido;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<Pedido>> getAll() async {
    try {
      pedidos = await pedidoRepository.getAll();
      return pedidos;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Pedido p) async {
    try {
      pedido = await pedidoRepository.create(p.toJson());
      if (pedido == null) {
        mensagem = "sem dados";
      } else {
        return pedido;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Pedido p) async {
    try {
      pedido = await pedidoRepository.update(id, p.toJson());
      return pedido;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  double calculateDesconto() {
    this.totalDesconto = total - desconto;
    return totalDesconto;
  }
}
