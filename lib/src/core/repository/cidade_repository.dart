import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/cidade.dart';

class CidadeRepository {
  CustonDio dio = CustonDio();

  Future<List<Cidade>> getAll() async {
    try {
      print("carregando cidades");
      var response = await dio.client.get("/cidades");
      return (response.data as List).map((c) => Cidade.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Cidade>> getAllById(int id) async {
    try {
      print("carregando cidades by id");
      var response = await dio.client.get("/cidades/${id}");
      return (response.data as List).map((c) => Cidade.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Cidade>> getAllByEstadoId(int id) async {
    try {
      print("carregando cidades por estado");
      var response = await dio.client.get("/cidades/estado/$id");
      return (response.data as List).map((c) => Cidade.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/cidades/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/cidades/update/$id", data: data);
    return response.statusCode;
  }

  static Future<FormData> upload(File file, String fileName) async {
    var arquivo = file.path;
    var fileDir = file.path;

    var paramentros = {
      "file": await MultipartFile.fromFile(fileDir, filename: fileName)
    };

    FormData formData = FormData.fromMap(paramentros);

    var response = await Dio()
        .post(ConstantApi.urlList + "/cidades/upload", data: formData);
    print("RESPONSE: $response");
    print("fileDir: $fileDir");
    return formData;
  }
}
