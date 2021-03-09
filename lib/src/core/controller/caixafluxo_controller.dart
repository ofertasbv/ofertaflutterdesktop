import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/caixafluxo.dart';
import 'package:nosso/src/core/repository/caixafluxo_repository.dart';

part 'caixafluxo_controller.g.dart';

class CaixafluxoController = CaixafluxoControllerBase
    with _$CaixafluxoController;

abstract class CaixafluxoControllerBase with Store {
  CaixaFluxoRepository caixaFluxoRepository;

  CaixafluxoControllerBase() {
    caixaFluxoRepository = CaixaFluxoRepository();
  }

  @observable
  List<CaixaFluxo> caixaFluxos;

  @observable
  int caixaFluxo;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<CaixaFluxo>> getAll() async {
    try {
      caixaFluxos = await caixaFluxoRepository.getAll();
      return caixaFluxos;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(CaixaFluxo p) async {
    try {
      caixaFluxo = await caixaFluxoRepository.create(p.toJson());
      if (caixaFluxo == null) {
        mensagem = "sem dados";
      } else {
        return caixaFluxo;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, CaixaFluxo p) async {
    try {
      caixaFluxo = await caixaFluxoRepository.update(id, p.toJson());
      return caixaFluxo;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
