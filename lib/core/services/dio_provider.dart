/*import 'package:dio/dio.dart';

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
*/
// lib/core/network/dio_provider.dart
// lib/core/network/dio_provider.dart
// lib/core/network/dio_provider.dart
/*
import 'package:dio/dio.dart';
import '../constants/api_constants.dart'; // تأكد من صحة هذا المسار

class DioProvider {
  // 🌟🌟🌟 إعادة Dio كـ static 🌟🌟🌟
  static late Dio _dio;

  // 🌟🌟🌟 دالة init() ستكون static لتهيئة Dio 🌟🌟🌟
  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl, // تأكد من أن baseUrl معرف في ApiConstants
        connectTimeout: const Duration(milliseconds: 30000), // 30 ثانية
        receiveTimeout: const Duration(milliseconds: 30000), // 30 ثانية
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': 'Bearer YOUR_AUTH_TOKEN', // أضف إذا كنت تستخدم Token
        },
      ),
    );
    // إضافة LogInterceptor للمساعدة في تتبع الطلبات والاستجابات
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  // 🌟🌟🌟 جميع دوال الـ HTTP ستكون static الآن 🌟🌟🌟
  static Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? params, required Map<String, dynamic> headers,
  }) async {
    try {
      final response = await _dio.get(endPoint, queryParameters: params);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  static Future<Response> post({
    required String endPoint,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.post(endPoint, data: params);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  static Future<Response> put({
    required String endPoint,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.put(endPoint, data: params);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  static Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await _dio.delete(endPoint, data: params);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // دالة مساعدة لمعالجة أخطاء Dio (يمكن أن تكون static أيضاً)
  static Exception _handleDioError(DioException e) {
    String message = 'An unknown error occurred.';
    if (e.response != null) {
      if (e.response?.data != null && e.response?.data is Map && e.response?.data.containsKey('message')) {
        message = e.response?.data['message'];
      } else if (e.response?.statusMessage != null) {
        message = e.response!.statusMessage!;
      }
    } else if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
      message = 'Connection timed out. Please check your internet connection.';
    } else if (e.type == DioExceptionType.unknown) {
      message = 'No internet connection or server unreachable.';
    } else {
      message = e.message ?? message;
    }
    return Exception(message);
  }
}
*/

import 'package:dio/dio.dart';

class DioProvider {
  // هذا هو المتغير الذي يجب تهيئته. كلمة 'late' تعني "سأقوم بتهيئته لاحقاً".
  static late Dio _dio;

  // 1. تم تغيير اسم الدالة من 'init' إلى 'initialize' لتكون أكثر وضوحاً.
  //    وتمت إضافة LogInterceptor لتسجيل تفاصيل الطلبات والاستجابات، وهو مفيد جداً للتصحيح.
  static void initialize() {
    // استخدم 'void' بدلاً من 'init' إذا لم تعد قيمة
    _dio = Dio(
      BaseOptions(
        // تأكد أن هذا الرابط صحيح ويحتوي على البروتوكول (http:// أو https://)
        baseUrl: 'http://www.MechPro.somee.com/',
        // يمكنك إضافة مهلات هنا إذا لزم الأمر
        // connectTimeout: const Duration(seconds: 30),
        // receiveTimeout: const Duration(seconds: 30),
      ),
    );

    // إضافة LogInterceptor لتسجيل تفاصيل الطلبات والاستجابات في الكونسول
    _dio.interceptors.add(LogInterceptor(
      requestBody: true, // تسجيل جسم الطلب (data)
      responseBody: true, // تسجيل جسم الاستجابة (data)
      requestHeader: true, // تسجيل رؤوس الطلب (headers)
      responseHeader: true, // تسجيل رؤوس الاستجابة (headers)
      logPrint: (obj) {
        // يمكنك استخدام 'print' العادي أو logger خاص بك
        print("DIO_LOG: $obj");
      },
    ));
  }

  // دوال لطلبات HTTP
  static Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? params, // استخدم params لـ query parameters
    Map<String, dynamic>? headers,
  }) async {
    // استخدم queryParameters لـ GET requests إذا كنت تمررها في الـ URL
    // استخدم data إذا كان الـ API يتوقع body لطلب GET (نادراً)
    return await _dio.get(
      endPoint,
      queryParameters:
          params, // عادة ما تكون الـ params في GET هي queryParameters
      options: Options(headers: headers),
    );
  }

  static Future<Response> post({
    required String endPoint,
    dynamic data, // استخدم 'dynamic data' بدلاً من 'params' لـ POST body
    Map<String, dynamic>? headers,
    required Map<String, dynamic> params,
  }) async {
    // بالنسبة لـ POST، عادة ما تكون البيانات في 'data' وليس 'params'
    return await _dio.post(
      endPoint,
      data: data, // البيانات التي يتم إرسالها في جسم الطلب
      options: Options(headers: headers),
    );
  }

  static Future<Response> update({
    required String endPoint,
    dynamic data, // استخدم 'dynamic data' لـ PUT body
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.put(
      endPoint,
      data: data, // البيانات التي يتم إرسالها في جسم الطلب
      options: Options(headers: headers),
    );
  }

  static Future<Response> delete({
    required String endPoint,
    dynamic data, // يمكن أن يكون لـ DELETE أيضاً body (نادراً)
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.delete(
      endPoint,
      data: data, // البيانات التي يتم إرسالها في جسم الطلب
      options: Options(headers: headers),
    );
  }
}
