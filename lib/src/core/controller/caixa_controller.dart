import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/caixa.dart';
import 'package:nosso/src/core/repository/caixa_repository.dart';

part 'caixa_controller.g.dart';

class CaixaController = CaixaControllerBase with _$CaixaController;

abstract class CaixaControllerBase with Store {
  CaixaRepository caixaRepository;

  CaixaControllerBase() {
    caixaRepository = CaixaRepository();
  }

  @observable
  List<Caixa> caixas;

  @observable
  int caixa;

  @observable
  Caixa caixaSelecionado;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<Caixa>> getAll() async {
    try {
      caixas = await caixaRepository.getAll();
      return caixas;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Caixa p) async {
    try {
      caixa = await caixaRepository.create(p.toJson());
      if (caixa == null) {
        mensagem = "sem dados";
      } else {
        return caixa;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Caixa p) async {
    try {
      caixa = await caixaRepository.update(id, p.toJson());
      return caixa;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
