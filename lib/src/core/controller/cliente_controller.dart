import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/model/cliente.dart';
import 'package:nosso/src/core/repository/cliente_repository.dart';

part 'cliente_controller.g.dart';

class ClienteController = ClienteControllerBase with _$ClienteController;

abstract class ClienteControllerBase with Store {
  ClienteRepository clienteRepository;

  ClienteControllerBase() {
    clienteRepository = ClienteRepository();
  }

  @observable
  List<Cliente> clientes;

  @observable
  int cliente;

  @observable
  var formData;

  @observable
  bool senhaVisivel = false;

  @observable
  Cliente clienteSelecionado;

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
  Future<List<Cliente>> getAll() async {
    try {
      clientes = await clienteRepository.getAll();
      return clientes;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Cliente>> getAllByNome(String nome) async {
    try {
      clientes = await clienteRepository.getAllByNome(nome);
      return clientes;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<Cliente> getById(int id) async {
    try {
      clienteSelecionado = await clienteRepository.getById(id);
      return clienteSelecionado;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<List<Cliente>> getAllById(int id) async {
    try {
      clientes = await clienteRepository.getAllById(id);
      return clientes;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<int> create(Cliente p) async {
    try {
      cliente = await clienteRepository.create(p.toJson());
      if (cliente == null) {
        mensagem = "sem dados";
      } else {
        return cliente;
      }
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<int> update(int id, Cliente p) async {
    try {
      cliente = await clienteRepository.update(id, p.toJson());
      return cliente;
    } on DioError catch (e) {
      mensagem = e.message;
      dioError = e;
    }
  }

  @action
  Future<String> upload(File foto, String fileName) async {
    try {
      formData = await clienteRepository.upload(foto, fileName);
      return formData;
    } catch (e) {
      error = e;
    }
  }

  @action
  Future<void> deleteFoto(String foto) async {
    try {
      await clienteRepository.deleteFoto(foto);
    } catch (e) {
      error = e;
    }
  }
}
