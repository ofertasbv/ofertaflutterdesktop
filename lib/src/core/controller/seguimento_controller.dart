import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/core/model/seguimento.dart';
import 'package:nosso/src/core/repository/seguimento_repository.dart';

part 'seguimento_controller.g.dart';

class SeguimentoController = SeguimentoControllerBase with _$SeguimentoController;

abstract class SeguimentoControllerBase with Store {
  SeguimentoRepository seguimentoRepository;

  SeguimentoControllerBase() {
    seguimentoRepository = SeguimentoRepository();
  }

  @observable
  List<Seguimento> seguimentos;

  @observable
  int seguimento;

  @observable
  var formData;

  @observable
  Exception error;

  @observable
  DioError dioError;

  @observable
  String mensagem;

  @observable
  Categoria seguimentoselecionada;

  @observable
  String arquivo = ConstantApi.urlArquivoCategoria;

  @action
  Future<List<Seguimento>> getAll() async {
    try {
      seguimentos = await seguimentoRepository.getAll();
      return seguimentos;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Seguimento>> getAllByNome(String nome) async {
    try {
      seguimentos = await seguimentoRepository.getAllByNome(nome);
      return seguimentos;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Categoria p) async {
    try {
      seguimento = await seguimentoRepository.create(p.toJson());
      if (seguimento == null) {
        mensagem = "sem dados";
      } else {
        return seguimento;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Categoria p) async {
    try {
      seguimento = await seguimentoRepository.update(id, p.toJson());
      return seguimento;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<String> upload(File foto, String fileName) async {
    try {
      formData = await seguimentoRepository.upload(foto, fileName);
      return formData;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<void> deleteFoto(String foto) async {
    try {
      await seguimentoRepository.deleteFoto(foto);
    } catch (e) {
      error = e;
    }
  }
}
