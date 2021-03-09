import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/caixa.dart';

class CaixaRepository {
  CustonDio dio = CustonDio();

  Future<List<Caixa>> getAllById(int id) async {
    try {
      print("carregando caixas by id");
      var response = await dio.client.get("/caixas/${id}");
      return (response.data as List).map((c) => Caixa.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Caixa>> getAll() async {
    try {
      print("carregando caixas");
      var response = await dio.client.get("/caixas");
      return (response.data as List).map((c) => Caixa.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/caixas/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/caixas/update/$id", data: data);
    return response.statusCode;
  }
}
