import 'package:dio/dio.dart';

class DioProvider {
  static late Dio _dio;
  static init() {
    _dio = Dio(
      BaseOptions(baseUrl: 'http://www.MechPro.somee.com/'),
    );
  }

  static Future<Response> get(
      {required String endPoint,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) async {
    return await _dio.get(
      endPoint,
      data: params,
      options: Options(headers: headers),
    );
  }

  static Future<Response> post(
      {required String endPoint,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) async {
    return await _dio.post(
      endPoint,
      data: params,
      options: Options(headers: headers),
    );
  }

  static Future<Response> update(
      {required String endPoint,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) async {
    return await _dio.put(
      endPoint,
      data: params,
      options: Options(headers: headers),
    );
  }

  static Future<Response> delete(
      {required String endPoint,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) async {
    return await _dio.delete(
      endPoint,
      data: params,
      options: Options(headers: headers),
    );
  }
}
