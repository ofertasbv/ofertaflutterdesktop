import 'package:dio/dio.dart';
import 'package:nosso/src/api/dio/custon_dio.dart';
import 'package:nosso/src/core/model/caixaentrada.dart';

class CaixaEntradaRepository {
  CustonDio dio = CustonDio();

  Future<List<CaixaFluxoEntrada>> getAllById(int id) async {
    try {
      print("carregando caixafluxoentradas by id");
      var response = await dio.client.get("/caixafluxoentradas/${id}");
      return (response.data as List)
          .map((c) => CaixaFluxoEntrada.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<CaixaFluxoEntrada>> getAll() async {
    try {
      print("carregando caixafluxoentradas");
      var response = await dio.client.get("/caixafluxoentradas");
      return (response.data as List)
          .map((c) => CaixaFluxoEntrada.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response =
        await dio.client.post("/caixafluxoentradas/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response =
        await dio.client.put("/caixafluxoentradas/update/$id", data: data);
    return response.statusCode;
  }
}
