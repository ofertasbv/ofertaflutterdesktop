import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/model/vendedor.dart';
import 'package:nosso/src/core/repository/vendedor_repository.dart';

part 'vendedor_controller.g.dart';

class VendedorController = VendedorControllerBase with _$VendedorController;

abstract class VendedorControllerBase with Store {
  VendedorRepository vendedorRepository;

  VendedorControllerBase() {
    vendedorRepository = VendedorRepository();
  }

  @observable
  List<Vendedor> vendedores;

  @observable
  int vendedor;

  @observable
  var formData;

  @observable
  bool senhaVisivel = false;

  @observable
  Vendedor vendedoreSelecionado;

  @observable
  String arquivo = ConstantApi.urlArquivoCliente;

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

  @action
  Future<List<Vendedor>> getAll() async {
    try {
      vendedores = await vendedorRepository.getAll();
      return vendedores;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Vendedor>> getAllByNome(String nome) async {
    try {
      vendedores = await vendedorRepository.getAllByNome(nome);
      return vendedores;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<Vendedor> getById(int id) async {
    try {
      vendedoreSelecionado = await vendedorRepository.getById(id);
      return vendedoreSelecionado;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Vendedor>> getAllById(int id) async {
    try {
      vendedores = await vendedorRepository.getAllById(id);
      return vendedores;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Vendedor p) async {
    try {
      vendedor = await vendedorRepository.create(p.toJson());
      if (vendedor == null) {
        mensagem = "sem dados";
      } else {
        return vendedor;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Vendedor p) async {
    try {
      vendedor = await vendedorRepository.update(id, p.toJson());
      return vendedor;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<String> upload(File foto, String fileName) async {
    try {
      formData = await vendedorRepository.upload(foto, fileName);
      return formData;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<void> deleteFoto(String foto) async {
    try {
      await vendedorRepository.deleteFoto(foto);
    } catch (e) {
      error = e;
    }
  }
}
