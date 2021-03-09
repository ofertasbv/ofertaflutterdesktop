import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/tamanho.dart';

class TamanhoRepository {
  CustonDio dio = CustonDio();

  Future<List<Tamanho>> getAllById(int id) async {
    try {
      print("carregando tamanhos by id");
      var response = await dio.client.get("/tamanhos/${id}");
      return (response.data as List).map((c) => Tamanho.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Tamanho>> getAll() async {
    try {
      print("carregando tamanhos");
      var response = await dio.client.get("/tamanhos");
      return (response.data as List).map((c) => Tamanho.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/tamanhos/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/tamanhos/update/$id", data: data);
    return response.statusCode;
  }
}
