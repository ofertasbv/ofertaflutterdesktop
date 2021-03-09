import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/model/arquivo.dart';
import 'package:nosso/src/core/repository/arquivo_repository.dart';

part 'arquivo_controller.g.dart';

class ArquivoController = ArquivoControllerBase with _$ArquivoController;

abstract class ArquivoControllerBase with Store {
  ArquivoRepository arquivoRepository;

  ArquivoControllerBase() {
    arquivoRepository = ArquivoRepository();
  }

  @observable
  List<Arquivo> arquivos;

  @observable
  int arquivo;

  @observable
  var formData;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @observable
  String arquivoFoto = ConstantApi.urlArquivoArquivo;

  @action
  Future<List<Arquivo>> getAll() async {
    try {
      arquivos = await arquivoRepository.getAll();
      return arquivos;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Arquivo p) async {
    try {
      arquivo = await arquivoRepository.create(p.toJson());
      if (arquivo == null) {
        mensagem = "sem dados";
      } else {
        return arquivo;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Arquivo p) async {
    try {
      arquivo = await arquivoRepository.update(id, p.toJson());
      return arquivo;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<String> upload(File foto, String fileName) async {
    try {
      formData = await arquivoRepository.upload(foto, fileName);
      return formData;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<void> deleteFoto(String foto) async {
    try {
      await arquivoRepository.deleteFoto(foto);
    } catch (e) {
      error = e;
    }
  }
}
