import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/estado.dart';

class EstadoRepository {
  CustonDio dio = CustonDio();

  Future<List<Estado>> getAllById(int id) async {
    try {
      print("carregando estados by id");
      var response = await dio.client.get("/estados/${id}");
      return (response.data as List).map((c) => Estado.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Estado>> getAll() async {
    try {
      print("carregando estados");
      var response = await dio.client.get("/estados");
      return (response.data as List).map((c) => Estado.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/estados/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/estados/update/$id", data: data);
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
        .post(ConstantApi.urlList + "/estados/upload", data: formData);
    print("RESPONSE: $response");
    print("fileDir: $fileDir");
    return formData;
  }
}
