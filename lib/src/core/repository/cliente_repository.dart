import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/cliente.dart';

class ClienteRepository {
  CustonDio dio = CustonDio();

  Future<Cliente> getById(int id) async {
    try {
      print("carregando cliente by id");
      var response = await dio.client.get("/clientes/$id");
      return Cliente.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Cliente>> getAllById(int id) async {
    try {
      print("carregando clientes by id");
      var response = await dio.client.get("/clientes/${id}");
      return (response.data as List).map((c) => Cliente.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Cliente>> getAllByNome(String nome) async {
    try {
      print("carregando clientes by nome");
      var response = await dio.client.get("/clientes/nome/${nome}");
      return (response.data as List).map((c) => Cliente.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Cliente>> getAll() async {
    try {
      print("carregando clientes");
      var response = await dio.client.get("/clientes");
      return (response.data as List).map((c) => Cliente.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/clientes/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/clientes/update/$id", data: data);
    return response.statusCode;
  }

  Future<void> deleteFoto(String foto) async {
    try {
      var response = await dio.client.delete("/clientes/delete/foto/$foto");
      return response.statusCode;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<String> upload(File file, String fileName) async {
    var arquivo = file.path;

    var paramentros = {
      "foto": await MultipartFile.fromFile(arquivo, filename: fileName)
    };

    FormData formData = FormData.fromMap(paramentros);
    var response = await dio.client
        .post(ConstantApi.urlList + "/clientes/upload", data: formData);
    return response.toString();
  }
}
