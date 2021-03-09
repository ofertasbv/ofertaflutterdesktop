import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/favorito.dart';
import 'package:nosso/src/core/repository/favorito_repository.dart';

part 'favorito_controller.g.dart';

class FavoritoController = FavoritoControllerBase with _$FavoritoController;

abstract class FavoritoControllerBase with Store {
  FavoritoRepository favoritoRepository;

  FavoritoControllerBase() {
    favoritoRepository = FavoritoRepository();
  }

  @observable
  List<Favorito> favoritos;

  @observable
  int favorito;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<Favorito>> getAll() async {
    try {
      favoritos = await favoritoRepository.getAll();
      return favoritos;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Favorito p) async {
    try {
      favorito = await favoritoRepository.create(p.toJson());
      if (favorito == null) {
        mensagem = "sem dados";
      } else {
        return favorito;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Favorito p) async {
    try {
      favorito = await favoritoRepository.update(id, p.toJson());
      return favorito;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
