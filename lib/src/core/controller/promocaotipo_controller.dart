import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/promocaotipo.dart';
import 'package:nosso/src/core/repository/promocaoTipo_repository.dart';

part 'promocaotipo_controller.g.dart';

class PromocaoTipoController = PromocaoTipoControllerBase
    with _$PromocaoTipoController;

abstract class PromocaoTipoControllerBase with Store {
  PromocaoTipoRepository promocaoTipoRepository;

  PromocaoTipoControllerBase() {
    promocaoTipoRepository = PromocaoTipoRepository();
  }

  @observable
  List<PromocaoTipo> promocaoTipos;

  @observable
  int promocaoTipo;

  @observable
  PromocaoTipo promocaoTipoSelecionada;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<PromocaoTipo>> getAll() async {
    try {
      promocaoTipos = await promocaoTipoRepository.getAll();
      return promocaoTipos;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(PromocaoTipo p) async {
    try {
      promocaoTipo = await promocaoTipoRepository.create(p.toJson());
      if (promocaoTipo == null) {
        mensagem = "sem dados";
      } else {
        return promocaoTipo;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, PromocaoTipo p) async {
    try {
      promocaoTipo = await promocaoTipoRepository.update(id, p.toJson());
      return promocaoTipo;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
