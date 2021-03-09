import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/loja.dart';

class LojaRepository {
  CustonDio dio = CustonDio();

  Future<List<Loja>> getAll() async {
    try {
      print("carregando lojas");
      var response = await dio.client.get("/lojas");
      return (response.data as List).map((c) => Loja.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<Loja> getById(int id) async {
    try {
      print("carregando loja by id");
      var response = await dio.client.get("/lojas/$id");
      return Loja.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Loja>> getAllById(int id) async {
    try {
      print("carregando lojas by id");
      var response = await dio.client.get("/lojas/${id}");
      return (response.data as List).map((c) => Loja.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Loja>> getAllNome(String nome) async {
    try {
      print("carregando lojas by nome");
      var response = await dio.client.get("/lojas/nome/${nome}");
      return (response.data as List).map((c) => Loja.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/lojas/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/lojas/update/$id", data: data);
    return response.statusCode;
  }

  Future<void> deleteFoto(String foto) async {
    try {
      var response = await dio.client.delete("/lojas/delete/foto/$foto");
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
        .post(ConstantApi.urlList + "/lojas/upload", data: formData);
    return response.toString();
  }
}
