import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/cartao.dart';

class CartaoRepository {
  CustonDio dio = CustonDio();

  Future<List<Cartao>> getAllById(int id) async {
    try {
      print("carregando cataoes by id");
      var response = await dio.client.get("/cataoes/${id}");
      return (response.data as List).map((c) => Cartao.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Cartao>> getAll() async {
    try {
      print("carregando cataoes");
      var response = await dio.client.get("/cataoes");
      return (response.data as List).map((c) => Cartao.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/cataoes/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/cataoes/update/$id", data: data);
    return response.statusCode;
  }
}
