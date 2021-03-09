import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/pagamento.dart';
import 'package:nosso/src/core/repository/pagamento_repository.dart';

part 'pagamento_controller.g.dart';

class PagamentoController = PagamentoControllerBase with _$PagamentoController;

abstract class PagamentoControllerBase with Store {
  PagamentoRepository pagamentoRepository;

  PagamentoControllerBase() {
    pagamentoRepository = PagamentoRepository();
  }

  @observable
  List<Pagamento> pagamentos;

  @observable
  int pagamento;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<Pagamento>> getAll() async {
    try {
      pagamentos = await pagamentoRepository.getAll();
      return pagamentos;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Pagamento p) async {
    try {
      pagamento = await pagamentoRepository.create(p.toJson());
      if (pagamento == null) {
        mensagem = "sem dados";
      } else {
        return pagamento;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Pagamento p) async {
    try {
      pagamento = await pagamentoRepository.update(id, p.toJson());
      return pagamento;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
