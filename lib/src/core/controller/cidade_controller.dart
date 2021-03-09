import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/cidade.dart';
import 'package:nosso/src/core/repository/cidade_repository.dart';

part 'cidade_controller.g.dart';

class CidadeController = CidadeControllerBase with _$CidadeController;

abstract class CidadeControllerBase with Store {
  CidadeRepository cidadeRepository;

  CidadeControllerBase() {
    cidadeRepository = CidadeRepository();
  }

  @observable
  List<Cidade> cidades;

  @observable
  int cidade;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<Cidade>> getAll() async {
    try {
      cidades = await cidadeRepository.getAll();
      return cidades;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Cidade>> getAllById(int id) async {
    try {
      cidades = await cidadeRepository.getAllById(id);
      return cidades;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Cidade>> getAllByEstadoId(int id) async {
    try {
      cidades = await cidadeRepository.getAllByEstadoId(id);
      return cidades;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Cidade p) async {
    try {
      cidade = await cidadeRepository.create(p.toJson());
      if (cidade == null) {
        mensagem = "sem dados";
      } else {
        return cidade;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Cidade p) async {
    try {
      cidade = await cidadeRepository.update(id, p.toJson());
      return cidade;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
