import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/promocaotipo.dart';

class PromocaoTipoRepository {
  CustonDio dio = CustonDio();

  Future<List<PromocaoTipo>> getAllById(int id) async {
    try {
      print("carregando promoções tipos by id");
      var response = await dio.client.get("/promocaotipos/${id}");
      return (response.data as List)
          .map((c) => PromocaoTipo.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<PromocaoTipo>> getAll() async {
    try {
      print("carregando promoções tipos");
      var response = await dio.client.get("/promocaotipos");
      return (response.data as List)
          .map((c) => PromocaoTipo.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/promocaotipos/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response =
        await dio.client.put("/promocaotipos/update/$id", data: data);
    return response.statusCode;
  }
}
