import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/core/repository/subcategoria_repository.dart';

part 'subcategoria_controller.g.dart';

class SubCategoriaController = SubCategoriaControllerBase
    with _$SubCategoriaController;

abstract class SubCategoriaControllerBase with Store {
  SubCategoriaRepository subCategoriaRepository;

  SubCategoriaControllerBase() {
    subCategoriaRepository = SubCategoriaRepository();
  }

  @observable
  List<SubCategoria> subCategorias;

  @observable
  int subCategoria;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @observable
  Categoria categoriaSelecionada;

  @observable
  SubCategoria subCategoriaSelecionada;

  @action
  Future<List<SubCategoria>> getAll() async {
    try {
      subCategorias = await subCategoriaRepository.getAll();
      return subCategorias;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<SubCategoria>> getAllByNome(String nome) async {
    try {
      subCategorias = await subCategoriaRepository.getAllByNome(nome);
      return subCategorias;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<SubCategoria>> getAllByCategoriaById(int id) async {
    try {
      subCategorias = await subCategoriaRepository.getAllByCategoriaById(id);
      return subCategorias;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(SubCategoria p) async {
    try {
      subCategoria = await subCategoriaRepository.create(p.toJson());
      if (subCategoria == null) {
        mensagem = "sem dados";
      } else {
        return subCategoria;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, SubCategoria p) async {
    try {
      subCategoria = await subCategoriaRepository.update(id, p.toJson());
      return subCategoria;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
