import 'package:dio/dio.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:konfio_app_dog/config/flavor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpManager {
  static final HttpManager _singleton = HttpManager._internal();
  factory HttpManager() {
    return _singleton;
  }

  HttpManager._internal();

  final Dio _genDio = Dio()
    ..interceptors.add(AppInterceptorGeneraLog().prettyDioLogger);

  Dio get genDio => _genDio;

  init() {
    genDio.options.baseUrl =
        FlavorConfig.instance.variables[FlavorKeys.mainUrl];
    genDio.options.headers = {
      Headers.contentTypeHeader: Headers.jsonContentType,
      Headers.acceptHeader: Headers.jsonContentType,
    };
  }
}

class AppInterceptorGeneraLog {
  final _prettyDioLogger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: false,
    responseHeader: false,
    compact: false,
  );
  PrettyDioLogger get prettyDioLogger => _prettyDioLogger;
}
