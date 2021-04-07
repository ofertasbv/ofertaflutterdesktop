import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/seguimento.dart';

class SeguimentoRepository {
  CustonDio dio = CustonDio();

  Future<List<Seguimento>> getAll() async {
    try {
      print("carregando seguimentos");
      var response = await dio.client.get("/seguimentos");
      return (response.data as List)
          .map((c) => Seguimento.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Seguimento>> getAllById(int id) async {
    try {
      print("carregando seguimentos by id");
      var response = await dio.client.get("/seguimentos/${id}");
      return (response.data as List)
          .map((c) => Seguimento.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Seguimento>> getAllByNome(String nome) async {
    try {
      print("carregando seguimentos by nome");
      var response = await dio.client.get("/seguimentos/nome/${nome}");
      return (response.data as List)
          .map((c) => Seguimento.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }


  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/seguimentos/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response =
        await dio.client.put("/seguimentos/update/$id", data: data);
    return response.statusCode;
  }

  Future<void> deleteFoto(String foto) async {
    try {
      var response =
          await dio.client.delete("/seguimentos/delete/foto/$foto");
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
        .post(ConstantApi.urlList + "/seguimentos/upload", data: formData);
    return response.toString();
  }
}
