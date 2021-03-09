

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/core/model/permissao.dart';
import 'package:nosso/src/core/repository/permissao_repository.dart';

part 'permissao_controller.g.dart';

class PermissaoController = PermissaoControllerBase with _$PermissaoController;

abstract class PermissaoControllerBase with Store {
  PermissaoRepository permissaoRepository;

  PermissaoControllerBase() {
    permissaoRepository = PermissaoRepository();
  }

  @observable
  List<Permissao> permissoes;

  @observable
  int permissao;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @action
  Future<List<Permissao>> getAll() async {
    try {
      permissoes = await permissaoRepository.getAll();
      return permissoes;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Permissao p) async {
    try {
      permissao = await permissaoRepository.create(p.toJson());
      if (permissao == null) {
        mensagem = "sem dados";
      } else {
        return permissao;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Permissao p) async {
    try {
      permissao = await permissaoRepository.update(id, p.toJson());
      return permissao;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }
}
