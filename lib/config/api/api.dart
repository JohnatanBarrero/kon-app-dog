
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konfio_app_dog/config/api/http_maganer.dart';

class Api {
  static final client = Modular.get<HttpManager>();

  static Future getApi(String path, {dynamic params}) async {
    final resp = await client.genDio.get(
      path,
      queryParameters: params,
    );
    return resp;
  }

  static Future postApi(String path, dynamic data, [Options? options]) async {
    final resp = await client.genDio.post(path, data: data, options: options);
    return resp;
  }

  static Future delApi(String path, dynamic data, [Options? options]) async {
    final resp = await client.genDio.delete(path, data: data, options: options);
    return resp;
  }

  static Future putApi(String path, dynamic data) async {
    final resp = await client.genDio.put(path, data: data);
    return resp;
  }
}