
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/tamanho.dart';
import 'package:nosso/src/core/repository/tamanho_repository.dart';

part 'tamanho_controller.g.dart';

class TamanhoController = TamanhoControllerBase with _$TamanhoController;
abstract class TamanhoControllerBase with Store{

  TamanhoRepository tamanhoRepository;

  TamanhoControllerBase() {
    tamanhoRepository = TamanhoRepository();
  }

  @observable
  List<Tamanho> tamanhos;

  @observable
  int tamanho;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<Tamanho>> getAll() async {
    try {
      tamanhos = await tamanhoRepository.getAll();
      return tamanhos;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Tamanho p) async {
    try {
      tamanho = await tamanhoRepository.create(p.toJson());
      if (tamanho == null) {
        mensagem = "sem dados";
      } else {
        return tamanho;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Tamanho p) async {
    try {
      tamanho = await tamanhoRepository.update(id, p.toJson());
      return tamanho;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}