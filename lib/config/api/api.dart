import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konfio_app_dog/config/api/http_maganer.dart';

class Api {
  final HttpManager client;

  // Permitir inyección de dependencias para pruebas
  Api({HttpManager? httpManager}) : client = httpManager ?? Modular.get<HttpManager>();

  Future<Response> getApi(String path, {dynamic params}) async {
    return await client.genDio.get(path, queryParameters: params);
  }

  Future<Response> postApi(String path, dynamic data, [Options? options]) async {
    return await client.genDio.post(path, data: data, options: options);
  }

  Future<Response> delApi(String path, dynamic data, [Options? options]) async {
    return await client.genDio.delete(path, data: data, options: options);
  }

  Future<Response> putApi(String path, dynamic data) async {
    return await client.genDio.put(path, data: data);
  }
}
