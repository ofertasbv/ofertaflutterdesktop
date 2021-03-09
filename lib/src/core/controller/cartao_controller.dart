import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/cartao.dart';
import 'package:nosso/src/core/repository/cartao_repository.dart';

part 'cartao_controller.g.dart';

class CartaoController = CartaoControllerBase with _$CartaoController;

abstract class CartaoControllerBase with Store {
  CartaoRepository cartaoRepository;
  CartaoControllerBase() {
    cartaoRepository = CartaoRepository();
  }

  @observable
  List<Cartao> cartoes;

  @observable
  int cartao;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<Cartao>> getAll() async {
    try {
      cartoes = await cartaoRepository.getAll();
      return cartoes;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Cartao p) async {
    try {
      cartao = await cartaoRepository.create(p.toJson());
      if (cartao == null) {
        mensagem = "sem dados";
      } else {
        return cartao;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Cartao p) async {
    try {
      cartao = await cartaoRepository.update(id, p.toJson());
      return cartao;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
