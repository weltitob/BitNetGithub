import 'package:bitnet/backbone/services/base_controller/base_service.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'dio_exception.dart';
import 'interceptors/logger_interceptor.dart';

class DioClient extends BaseService {
  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30000),
        receiveTimeout: const Duration(seconds: 30000),
        responseType: ResponseType.json,
        validateStatus: (status) => true,
        // baseUrl: BASEURL,
      ),
    )..interceptors.addAll([
        LoggerInterceptor(),
      ]);
    _dio.interceptors.add(
      RetryInterceptor(dio: _dio, retries: 2, retryDelays: [
        const Duration(seconds: 1),
        const Duration(seconds: 2),
        const Duration(seconds: 3),
      ]),
    );
  }

  Future<Response> get(
      {Map<String, dynamic>? data,
      required String url,
      Map<String, dynamic>? headers}) async {
    try {
      var response = await _dio.get(url, options: Options(headers: headers));
      return response;
    } on DioException catch (err) {
      final errorMessage = DioDynamicException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<Response> post(
      {var data, required String url, Map<String, dynamic>? headers}) async {
    try {
      var response =
          await _dio.post(url, data: data, options: Options(headers: headers));
      return response;
    } on DioException catch (err) {
      String errorMessage = '';
      if (err.response != null) {
        errorMessage = err.response!.data['message'];
        debugPrint(errorMessage);
      } else {
        errorMessage = DioDynamicException.fromDioError(err).toString();
      }
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<Response> put(
      {Map<String, dynamic>? data,
      required String url,
      Map<String, dynamic>? headers}) async {
    try {
      final response =
          await _dio.put(url, data: data, options: Options(headers: headers));
      return response;
    } on DioException catch (err) {
      String errorMessage = '';
      if (err.response != null) {
        errorMessage = err.response!.data['message'];
      } else {
        errorMessage = DioDynamicException.fromDioError(err).toString();
      }
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<Response> delete(
      {Map<String, dynamic>? data,
      required String url,
      Map<String, dynamic>? headers}) async {
    try {
      var response = await _dio.delete(url, options: Options(headers: headers));
      return response;
    } on DioException catch (err) {
      final errorMessage = DioDynamicException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<Response> patch(
      {var data, required String url, Map<String, dynamic>? headers}) async {
    try {
      var response =
          await _dio.patch(url, data: data, options: Options(headers: headers));
      return response;
    } on DioException catch (err) {
      String errorMessage = '';
      if (err.response != null) {
        errorMessage = err.response!.data['message'];
        debugPrint(errorMessage);
      } else {
        errorMessage = DioDynamicException.fromDioError(err).toString();
      }
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<Response> uploadFile(
      {required String url,
      required Map<String, dynamic> data,
      required List<MultipartFile> files,
      Map<String, dynamic>? headers}) async {
    try {
      var formData = FormData.fromMap(data);
      for (var file in files) {
        formData.files.add(MapEntry("upload[]", file));
      }
      var response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (err) {
      String errorMessage = '';
      if (err.response != null) {
        errorMessage = err.response!.data['message'];
      } else {
        errorMessage = DioDynamicException.fromDioError(err).toString();
      }
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }
}
