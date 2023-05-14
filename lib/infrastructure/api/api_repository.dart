import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:triathlon_tracker/core/logger.dart';
import 'package:triathlon_tracker/data/session_manager.dart';
import 'package:triathlon_tracker/infrastructure/api/loggin_interceptor.dart';

const String _baseUrl = 'http://185.219.43.33:3000';

@LazySingleton()
class APIRepository {
  final BaseOptions _baseOptions = BaseOptions(
    baseUrl: _baseUrl,
    contentType: ContentType.json.toString(),
    responseType: ResponseType.plain,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );
  final SessionManager _sessionManager;

  late Dio _dio;

  APIRepository(this._sessionManager) {
    _dio = Dio(_baseOptions);
    _dio.interceptors.add(LoggingInterceptor());
  }

  _setAuthToken() {
    if (_sessionManager.token != null) {
      _dio.options.headers['Authorization'] = _sessionManager.token;
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<Either<String, Response>> getData(
    String endpoint, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> data = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    try {
      _setAuthToken();
      final response = await _dio.fetch<dynamic>(
        _setStreamType<dynamic>(
          Options(
            method: 'GET',
            headers: headers,
            extra: {},
          ).compose(
            _dio.options,
            endpoint,
            queryParameters: queryParameters,
            data: data,
          ),
        ),
      );
      return right(response);
    } catch (e) {
      logger.severe(e);
      return left('Что-то пошло не так...');
    }
  }

  Future<Either<String, Response>> postData(
    String endpoint, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> data = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    try {
      _setAuthToken();
      final response = await _dio.fetch<dynamic>(
        _setStreamType<dynamic>(
          Options(
            method: 'POST',
            headers: headers,
            extra: {},
          ).compose(
            _dio.options,
            endpoint,
            queryParameters: queryParameters,
            data: data,
          ),
        ),
      );
      return right(response);
    } catch (e) {
      logger.severe(e);
      return left('Что-то пошло не так...');
    }
  }

  Future<Either<String, Response>> putData(
    String endpoint, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> data = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    try {
      _setAuthToken();
      final response = await _dio.fetch<dynamic>(
        _setStreamType<dynamic>(
          Options(
            method: 'PUT',
            headers: headers,
            extra: {},
          ).compose(
            _dio.options,
            endpoint,
            queryParameters: queryParameters,
            data: data,
          ),
        ),
      );
      return right(response);
    } catch (e) {
      return left('Что-то пошло не так...');
    }
  }

  Future<Either<String, Response>> deleteData(
    String endpoint, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> data = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    try {
      _setAuthToken();
      final response = await _dio.fetch<dynamic>(
        _setStreamType<dynamic>(
          Options(
            method: 'DELETE',
            headers: headers,
            extra: {},
          ).compose(
            _dio.options,
            endpoint,
            queryParameters: queryParameters,
            data: data,
          ),
        ),
      );
      return right(response);
    } catch (e) {
      return left('Что-то пошло не так...');
    }
  }

  Future<Either<String, Response>> patchData(
    String endpoint, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> data = const {},
    FormData? formData,
    Map<String, dynamic> headers = const {},
  }) async {
    try {
      _setAuthToken();
      final response = await _dio.fetch<dynamic>(
        _setStreamType<dynamic>(
          Options(
            method: 'PATCH',
            headers: headers,
            extra: {},
          ).compose(
            _dio.options,
            endpoint,
            queryParameters: queryParameters,
            data: formData ?? data,
          ),
        ),
      );
      return right(response);
    } catch (e) {
      return left('Что-то пошло не так...');
    }
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
