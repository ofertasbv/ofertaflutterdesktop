import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/categoria.dart';

class CategoriaRepository {
  CustonDio dio = CustonDio();

  Future<List<Categoria>> getAll() async {
    try {
      print("carregando categorias");
      var response = await dio.client.get("/categorias");
      return (response.data as List).map((c) => Categoria.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Categoria>> getAllById(int id) async {
    try {
      print("carregando categorias by id");
      var response = await dio.client.get("/categorias/${id}");
      return (response.data as List).map((c) => Categoria.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Categoria>> getAllByNome(String nome) async {
    try {
      print("carregando categorias by nome");
      var response = await dio.client.get("/categorias/nome/${nome}");
      return (response.data as List).map((c) => Categoria.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/categorias/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/categorias/update/$id", data: data);
    return response.statusCode;
  }

  Future<void> deleteFoto(String foto) async {
    try {
      var response = await dio.client.delete("/categorias/delete/foto/$foto");
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
        .post(ConstantApi.urlList + "/categorias/upload", data: formData);
    return response.toString();
  }
}
