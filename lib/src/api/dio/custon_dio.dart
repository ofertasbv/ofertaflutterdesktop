

import 'package:dio/dio.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/api/interceptors/cache_interceptor.dart';
import 'package:nosso/src/api/interceptors/interceptions.dart';

class CustonDio {
  Dio client = Dio();

  CustonDio() {
    client.options.baseUrl = ConstantApi.urlList;

    client.interceptors.add(CustonInterceptions());
    client.interceptors.add(CacheInterceptor());
    client.options.connectTimeout = 5000;

  }
}
