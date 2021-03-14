import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/core/repository/promocao_repository.dart';
import 'package:nosso/src/util/filter/promocao_filter.dart';

part 'promocao_controller.g.dart';

class PromoCaoController = PromoCaoControllerBase with _$PromoCaoController;

abstract class PromoCaoControllerBase with Store {
  PromocaoRepository promocaoRepository;

  PromoCaoControllerBase() {
    promocaoRepository = PromocaoRepository();
  }

  @observable
  List<Promocao> promocoes;

  @observable
  List<Promocao> promocoesByLoja;

  @observable
  int promocao;

  @observable
  var formData;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @observable
  Promocao promocaoSelecionada;

  @observable
  String arquivo = ConstantApi.urlArquivoPromocao;

  @action
  Future<List<Promocao>> getAll() async {
    try {
      promocoes = await promocaoRepository.getAll();
      return promocoes;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Promocao>> getFilter(PromocaoFilter filter) async {
    try {
      promocoes = await promocaoRepository.getFilter(filter);
      return promocoes;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Promocao>> getAllByNome(String nome) async {
    try {
      promocoes = await promocaoRepository.getAllByNome(nome);
      return promocoes;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Promocao>> getAllByLoja(int id) async {
    try {
      promocoesByLoja = await promocaoRepository.getAllByLojaById(id);
      return promocoesByLoja;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Promocao p) async {
    try {
      promocao = await promocaoRepository.create(p.toJson());
      if (promocao == null) {
        mensagem = "sem dados";
      } else {
        return promocao;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Promocao p) async {
    try {
      promocao = await promocaoRepository.update(id, p.toJson());
      return promocao;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<String> upload(File foto, String fileName) async {
    try {
      formData = await promocaoRepository.upload(foto, fileName);
      return formData;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<void> deleteFoto(String foto) async {
    try {
      await promocaoRepository.deleteFoto(foto);
    } catch (e) {
      error = e;
    }
  }
}
