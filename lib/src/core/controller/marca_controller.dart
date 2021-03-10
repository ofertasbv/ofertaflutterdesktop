import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/marca.dart';
import 'package:nosso/src/core/repository/marca_repository.dart';

part 'marca_controller.g.dart';

class MarcaController = MarcaControllerBase with _$MarcaController;

abstract class MarcaControllerBase with Store {
  MarcaRepository marcaRepository;

  MarcaControllerBase() {
    marcaRepository = MarcaRepository();
  }

  @observable
  List<Marca> marcas;

  @observable
  int marca;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @observable
  Marca marcaSelecionada;

  @action
  Future<List<Marca>> getAll() async {
    try {
      marcas = await marcaRepository.getAll();
      return marcas;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Marca>> getAllByNome(String nome) async {
    try {
      marcas = await marcaRepository.getAllByNome(nome);
      return marcas;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Marca p) async {
    try {
      marca = await marcaRepository.create(p.toJson());
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
  Future<int> update(int id, Marca p) async {
    try {
      marca = await marcaRepository.update(id, p.toJson());
      return marca;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
