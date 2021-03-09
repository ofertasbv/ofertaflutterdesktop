import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/caixaentrada.dart';
import 'package:nosso/src/core/repository/caixaentrada_repository.dart';

part 'caixafluxoentrada_controller.g.dart';

class CaixafluxoentradaController = CaixafluxoentradaControllerBase
    with _$CaixafluxoentradaController;

abstract class CaixafluxoentradaControllerBase with Store {
  CaixaEntradaRepository caixaEntradaRepository;

  CaixafluxoEntradaControllerBase() {
    caixaEntradaRepository = CaixaEntradaRepository();
  }

  @observable
  List<CaixaFluxoEntrada> caixaEntradas;

  @observable
  int caixaEntrada;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<CaixaFluxoEntrada>> getAll() async {
    try {
      caixaEntradas = await caixaEntradaRepository.getAll();
      return caixaEntradas;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(CaixaFluxoEntrada p) async {
    try {
      caixaEntrada = await caixaEntradaRepository.create(p.toJson());
      if (caixaEntrada == null) {
        mensagem = "sem dados";
      } else {
        return caixaEntrada;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, CaixaFluxoEntrada p) async {
    try {
      caixaEntrada = await caixaEntradaRepository.update(id, p.toJson());
      return caixaEntrada;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
