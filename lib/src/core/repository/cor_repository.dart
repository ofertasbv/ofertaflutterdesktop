import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/cor.dart';
import 'package:nosso/src/core/model/tamanho.dart';

class CorRepository {
  CustonDio dio = CustonDio();

  Future<List<Cor>> getAllById(int id) async {
    try {
      print("carregando cores by id");
      var response = await dio.client.get("/cores/${id}");
      return (response.data as List).map((c) => Cor.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Cor>> getAll() async {
    try {
      print("carregando cores");
      var response = await dio.client.get("/cores");
      return (response.data as List).map((c) => Cor.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/cores/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/cores/update/$id", data: data);
    return response.statusCode;
  }
}
