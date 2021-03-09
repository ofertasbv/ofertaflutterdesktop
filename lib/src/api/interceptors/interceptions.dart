
import 'package:dio/dio.dart';

class CustonInterceptions extends InterceptorsWrapper{
  @override
  Future onRequest(RequestOptions options) {
    print("REQUEST[${options.method}] => PATH: ${options.path}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print("RESPONSE[${response.statusCode}] => PATH: ${response.request.path}");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError e) {
    print("ERROR[${e.response.statusCode}] => PATH: ${e.request.path}");
    return super.onError(e);
  }
}