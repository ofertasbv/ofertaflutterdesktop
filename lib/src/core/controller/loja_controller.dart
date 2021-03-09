import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/repository/loja_repository.dart';

part 'loja_controller.g.dart';

class LojaController = LojaControllerBase with _$LojaController;

abstract class LojaControllerBase with Store {
  LojaRepository lojaRepository;

  LojaControllerBase() {
    lojaRepository = LojaRepository();
  }

  @observable
  List<Loja> lojas;

  @observable
  int loja;

  @observable
  var formData;

  @observable
  bool senhaVisivel = false;

  @action
  visualizarSenha() {
    senhaVisivel = !senhaVisivel;
  }

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @observable
  Loja lojaSelecionada;

  @observable
  String arquivo = ConstantApi.urlArquivoLoja;

  @action
  Future<Loja> getById(int id) async {
    try {
      lojaSelecionada = await lojaRepository.getById(id);
      return lojaSelecionada;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Loja>> getAllById(int id) async {
    try {
      lojas = await lojaRepository.getAllById(id);
      return lojas;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Loja>> getAllByNome(String nome) async {
    try {
      lojas = await lojaRepository.getAllNome(nome);
      return lojas;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Loja>> getAll() async {
    try {
      lojas = await lojaRepository.getAll();
      return lojas;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Loja p) async {
    try {
      loja = await lojaRepository.create(p.toJson());
      if (loja == null) {
        mensagem = "sem dados";
      } else {
        return loja;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Loja p) async {
    try {
      loja = await lojaRepository.update(id, p.toJson());
      return loja;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<String> upload(File foto, String fileName) async {
    try {
      formData = await lojaRepository.upload(foto, fileName);
      return formData;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<void> deleteFoto(String foto) async {
    try {
      await lojaRepository.deleteFoto(foto);
    } catch (e) {
      error = e;
    }
  }
}
