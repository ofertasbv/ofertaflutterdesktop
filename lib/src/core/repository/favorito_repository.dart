import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/favorito.dart';

class FavoritoRepository {
  CustonDio dio = CustonDio();

  Future<List<Favorito>> getAllById(int id) async {
    try {
      print("carregando favoritos by id");
      var response = await dio.client.get("/favoritos/${id}");
      return (response.data as List).map((c) => Favorito.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Favorito>> getAll() async {
    try {
      print("carregando tamanhos");
      var response = await dio.client.get("/favoritos");
      return (response.data as List).map((c) => Favorito.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/favoritos/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/favoritos/update/$id", data: data);
    return response.statusCode;
  }
}
