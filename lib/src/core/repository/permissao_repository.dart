import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/permissao.dart';

class PermissaoRepository {
  CustonDio dio = CustonDio();

  Future<List<Permissao>> getAllById(int id) async {
    try {
      print("carregando permissoes by id");
      var response = await dio.client.get("/permissoes/${id}");
      return (response.data as List).map((c) => Permissao.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Permissao>> getAll() async {
    try {
      print("carregando permissoes");
      var response = await dio.client.get("/permissoes");
      return (response.data as List).map((c) => Permissao.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/permissoes/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/permissoes/update/$id", data: data);
    return response.statusCode;
  }
}
