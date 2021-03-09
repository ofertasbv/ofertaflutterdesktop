import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/estado.dart';
import 'package:nosso/src/core/repository/estado_repository.dart';

part 'estado_controller.g.dart';

class EstadoController = EstadoControllerBase with _$EstadoController;

abstract class EstadoControllerBase with Store {
  EstadoRepository estadoRepository;

  EstadoControllerBase() {
    estadoRepository = EstadoRepository();
  }

  @observable
  List<Estado> estados;

  @observable
  int estado;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<Estado>> getAll() async {
    try {
      estados = await estadoRepository.getAll();
      return estados;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Estado p) async {
    try {
      estado = await estadoRepository.create(p.toJson());
      if (estado == null) {
        mensagem = "sem dados";
      } else {
        return estado;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Estado p) async {
    try {
      estado = await estadoRepository.update(id, p.toJson());
      return estado;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
