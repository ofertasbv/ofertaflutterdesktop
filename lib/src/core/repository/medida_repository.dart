import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/medida.dart';
import 'package:nosso/src/core/model/subcategoria.dart';

class MedidaRepository {
  CustonDio dio = CustonDio();

  Future<List<Medida>> getAll() async {
    try {
      print("carregando medidas");
      var response = await dio.client.get("/medidas");
      return (response.data as List).map((c) => Medida.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Medida>> getAllById(int id) async {
    try {
      print("carregando medidas by id");
      var response = await dio.client.get("/medidas/${id}");
      return (response.data as List).map((c) => Medida.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Medida>> getAllByNome(String nome) async {
    try {
      print("carregando medidas by nome");
      var response = await dio.client.get("/medidas/nome/${nome}");
      return (response.data as List)
          .map((c) => Medida.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/medidas/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/medidas/update/$id", data: data);
    return response.statusCode;
  }
}
