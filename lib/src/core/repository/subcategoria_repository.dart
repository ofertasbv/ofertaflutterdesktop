import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/subcategoria.dart';

class SubCategoriaRepository {
  CustonDio dio = CustonDio();

  Future<List<SubCategoria>> getAll() async {
    try {
      print("carregando subcategorias");
      var response = await dio.client.get("/subcategorias");
      return (response.data as List)
          .map((c) => SubCategoria.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<SubCategoria>> getAllById(int id) async {
    try {
      print("carregando subcategorias by id");
      var response = await dio.client.get("/subcategorias/${id}");
      return (response.data as List)
          .map((c) => SubCategoria.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<SubCategoria>> getAllByNome(String nome) async {
    try {
      print("carregando subcategorias by nome");
      var response = await dio.client.get("/subcategorias/nome/${nome}");
      return (response.data as List)
          .map((c) => SubCategoria.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<SubCategoria>> getAllByCategoriaById(int id) async {
    try {
      print("carregando subcategorias da categoria");
      var response = await dio.client.get("/subcategorias/categoria/$id");
      return (response.data as List)
          .map((c) => SubCategoria.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/subcategorias/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response =
        await dio.client.put("/subcategorias/update/$id", data: data);
    return response.statusCode;
  }

  Future<void> deleteFoto(String foto) async {
    try {
      var response =
          await dio.client.delete("/subcategorias/delete/foto/$foto");
      return response.statusCode;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  static Future<FormData> upload(File file, String fileName) async {
    var arquivo = file.path;
    var fileDir = file.path;

    var paramentros = {
      "foto": await MultipartFile.fromFile(fileDir, filename: fileName)
    };

    FormData formData = FormData.fromMap(paramentros);

    var response = await Dio()
        .post(ConstantApi.urlList + "/subcategorias/upload", data: formData);
    print("RESPONSE: $response");
    print("fileDir: $fileDir");
    return formData;
  }
}
