import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';

class PedidoItemRepository {
  CustonDio dio = CustonDio();

  Future<List<PedidoItem>> getAllById(int id) async {
    try {
      print("carregando pedidoitens by id");
      var response = await dio.client.get("/pedidositens/${id}");
      return (response.data as List)
          .map((c) => PedidoItem.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<PedidoItem>> getAll() async {
    try {
      print("carregando pedidoitens");
      var response = await dio.client.get("/pedidositens");
      return (response.data as List)
          .map((c) => PedidoItem.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/pedidositens/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/pedidositens/update/$id", data: data);
    return response.statusCode;
  }

}
