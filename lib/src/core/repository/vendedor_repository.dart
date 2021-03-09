import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/vendedor.dart';

class VendedorRepository {
  CustonDio dio = CustonDio();

  Future<Vendedor> getById(int id) async {
    try {
      print("carregando vendedores by id");
      var response = await dio.client.get("/vendedores/$id");
      return Vendedor.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Vendedor>> getAllById(int id) async {
    try {
      print("carregando vendedores by id");
      var response = await dio.client.get("/vendedores/${id}");
      return (response.data as List).map((c) => Vendedor.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Vendedor>> getAllByNome(String nome) async {
    try {
      print("carregando vendedores by nome");
      var response = await dio.client.get("/vendedores/nome/${nome}");
      return (response.data as List).map((c) => Vendedor.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Vendedor>> getAll() async {
    try {
      print("carregando vendedores");
      var response = await dio.client.get("/vendedores");
      return (response.data as List).map((c) => Vendedor.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/vendedores/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/vendedores/update/$id", data: data);
    return response.statusCode;
  }

  Future<void> deleteFoto(String foto) async {
    try {
      var response = await dio.client.delete("/vendedores/delete/foto/$foto");
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
        .post(ConstantApi.urlList + "/vendedores/upload", data: formData);
    return response.toString();
  }
}
