import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/arquivo.dart';

class ArquivoRepository {
  CustonDio dio = CustonDio();

  Future<List<Arquivo>> getAll() async {
    try {
      print("carregando arquivos");
      var response = await dio.client.get("/arquivos");
      return (response.data as List).map((c) => Arquivo.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Arquivo>> getAllById(int id) async {
    try {
      print("carregando arquivos by id");
      var response = await dio.client.get("/arquivos/${id}");
      return (response.data as List).map((c) => Arquivo.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/arquivos/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/arquivos/update/$id", data: data);
    return response.statusCode;
  }

  Future<void> deleteFoto(String foto) async {
    try {
      var response = await dio.client.delete("/arquivos/delete/foto/$foto");
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
        .post(ConstantApi.urlList + "/arquivos/upload", data: formData);
    return response.toString();
  }
}
