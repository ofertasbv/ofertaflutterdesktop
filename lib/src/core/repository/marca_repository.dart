import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/marca.dart';

class MarcaRepository {
  CustonDio dio = CustonDio();

  Future<List<Marca>> getAllById(int id) async {
    try {
      print("carregando marcas by id");
      var response = await dio.client.get("/marcas/${id}");
      return (response.data as List).map((c) => Marca.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Marca>> getAll() async {
    try {
      print("carregando marcas");
      var response = await dio.client.get("/marcas");
      return (response.data as List).map((c) => Marca.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/marcas/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/marcas/update/$id", data: data);
    return response.statusCode;
  }
}
