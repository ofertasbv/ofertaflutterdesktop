import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/cor.dart';
import 'package:nosso/src/core/repository/cor_repository.dart';

part 'cor_controller.g.dart';

class CorController = CorControllerBase with _$CorController;

abstract class CorControllerBase with Store {
  CorRepository corRepository;

  CorControllerBase() {
    corRepository = CorRepository();
  }

  @observable
  List<Cor> cores;

  @observable
  int cor;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<Cor>> getAll() async {
    try {
      cores = await corRepository.getAll();
      return cores;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Cor p) async {
    try {
      cor = await corRepository.create(p.toJson());
      if (cor == null) {
        mensagem = "sem dados";
      } else {
        return cor;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Cor p) async {
    try {
      cor = await corRepository.update(id, p.toJson());
      return cor;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
