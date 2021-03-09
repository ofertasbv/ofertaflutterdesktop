import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/caixasaida.dart';

class CaixaSaidaRepository {
  CustonDio dio = CustonDio();

  Future<List<CaixaFluxoSaida>> getAllById(int id) async {
    try {
      print("carregando caixafluxosaidas by id");
      var response = await dio.client.get("/caixafluxosaidas/${id}");
      return (response.data as List)
          .map((c) => CaixaFluxoSaida.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<CaixaFluxoSaida>> getAll() async {
    try {
      print("carregando caixafluxosaidas");
      var response = await dio.client.get("/caixafluxosaidas");
      return (response.data as List)
          .map((c) => CaixaFluxoSaida.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response =
        await dio.client.post("/caixafluxosaidas/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response =
        await dio.client.put("/caixafluxosaidas/update/$id", data: data);
    return response.statusCode;
  }
}
