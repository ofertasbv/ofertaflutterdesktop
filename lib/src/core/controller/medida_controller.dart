import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/medida.dart';
import 'package:nosso/src/core/repository/medida_repository.dart';

part 'medida_controller.g.dart';

class MedidaController = MedidaControllerBase with _$MedidaController;

abstract class MedidaControllerBase with Store {
  MedidaRepository medidaRepository;

  MedidaControllerBase() {
    medidaRepository = MedidaRepository();
  }

  @observable
  List<Medida> medidas;

  @observable
  int marca;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @observable
  Medida medidaselecionada;

  @action
  Future<List<Medida>> getAll() async {
    try {
      medidas = await medidaRepository.getAll();
      return medidas;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Medida>> getAllByNome(String nome) async {
    try {
      medidas = await medidaRepository.getAllByNome(nome);
      return medidas;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Medida p) async {
    try {
      marca = await medidaRepository.create(p.toJson());
      if (marca == null) {
        mensagem = "sem dados";
      } else {
        return marca;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Medida p) async {
    try {
      marca = await medidaRepository.update(id, p.toJson());
      return marca;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
