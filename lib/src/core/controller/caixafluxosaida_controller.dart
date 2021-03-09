import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/caixasaida.dart';
import 'package:nosso/src/core/repository/caixasaida_repository.dart';

part 'caixafluxosaida_controller.g.dart';

class CaixafluxosaidaController = CaixafluxosaidaControllerBase
    with _$CaixafluxosaidaController;

abstract class CaixafluxosaidaControllerBase with Store {
  CaixaSaidaRepository caixaSaidaRepository;

  CaixafluxoSaidaControllerBase() {
    caixaSaidaRepository = CaixaSaidaRepository();
  }

  @observable
  List<CaixaFluxoSaida> caixaSaidas;

  @observable
  int caixaSaida;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<CaixaFluxoSaida>> getAll() async {
    try {
      caixaSaidas = await caixaSaidaRepository.getAll();
      return caixaSaidas;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(CaixaFluxoSaida p) async {
    try {
      caixaSaida = await caixaSaidaRepository.create(p.toJson());
      if (caixaSaida == null) {
        mensagem = "sem dados";
      } else {
        return caixaSaida;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, CaixaFluxoSaida p) async {
    try {
      caixaSaida = await caixaSaidaRepository.update(id, p.toJson());
      return caixaSaida;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
