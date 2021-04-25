import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/caixafluxo.dart';

class CaixaFluxoRepository {
  CustonDio dio = CustonDio();

  Future<List<CaixaFluxo>> getAllById(int id) async {
    try {
      print("carregando caixafluxos by id");
      var response = await dio.client.get("/caixafluxos/${id}");
      return (response.data as List)
          .map((c) => CaixaFluxo.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<CaixaFluxo>> getAll() async {
    try {
      print("carregando caixafluxos");
      var response = await dio.client.get("/caixafluxos");
      return (response.data as List)
          .map((c) => CaixaFluxo.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<double> getSomaTotalEntrada(int id) async {
    try {
      print("carregando caixafluxos total entradas");
      var response = await dio.client.get("/caixafluxos/totalEntrada/${id}");
      return response.data;
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<double> getSomaTotalSaida(int id) async {
    try {
      print("carregando caixafluxos total saidas");
      var response = await dio.client.get("/caixafluxos/totalSaida/${id}");
      return response.data;
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/caixafluxos/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/caixafluxos/update/$id", data: data);
    return response.statusCode;
  }
}
