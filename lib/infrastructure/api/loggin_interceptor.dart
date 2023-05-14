import 'package:dio/dio.dart';
import 'package:triathlon_tracker/core/logger.dart';

class LoggingInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.info(
        'REQUEST[${options.method}] => PATH: ${options.path} URI: ${options.uri}  HEADERS: ${options.headers} BODY: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.info(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} REAL_URI: ${response.realUri}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.info(
        'ERROR_CODE[${err.response?.statusCode}] ERROR: ${err.error} => PATH: ${err.requestOptions.path} ERROR_MESSAGE: ${err.message}');
    super.onError(err, handler);
  }
}
