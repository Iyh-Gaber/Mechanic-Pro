/*import 'package:dio/dio.dart';
import 'package:mechpro/core/constants/api_constants.dart';
// 🌟🌟🌟 تأكد من صحة هذا المسار لـ DioProvider 🌟🌟🌟
// هذا هو المسار الذي اتفقنا عليه
import 'package:mechpro/feature/orders/data/models/request/order_model/order_model.dart';
import 'package:mechpro/feature/orders/data/models/response/order_response/order_response.dart';
//import 'package:mechpro/feature/orders/data/models/response/order_response/data.dart';

import '../../../../core/services/dio_provider.dart';

// 🌟🌟🌟 هذا الاستيراد قد يكون زائدًا أو خاطئًا إذا كان يشير لنفس الملف 🌟🌟🌟
// import 'package:mechpro/feature/orders/data/repo/order_repo.dart';

class OrdersRepo {
  OrdersRepo();

  Future<OrderResponse> createOrder(OrderModel order) async {
    try {
      final response = await DioProvider.post(
        endPoint:
            ApiConstants.makeOrder, // 🌟 تأكد من استخدام createOrderEndpoint 🌟
        params: order.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return OrderResponse.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error:
              'Failed to create order: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      String errorMessage =
          'Failed to create order. Please check your internet connection or try again later.';
      if (e.response != null) {
        errorMessage = e.response?.data['message'] ??
            e.response?.statusMessage ??
            errorMessage;
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<List<DataOrder>> getOrdersFromApi() async {
    try {
      final response = await DioProvider.get(
        // 🌟🌟🌟 إزالة headers: {} لأن دالة DioProvider.get لا تستقبلها 🌟🌟🌟
        endPoint: ApiConstants.makeOrder,
        headers: {}, // 🌟 تأكد من استخدام getOrdersEndpoint 🌟
      );

      if (response.statusCode == 200) {
        final apiResponse =
            OrderResponse.fromJson(response.data as Map<String, dynamic>);
        if (apiResponse.isSuccess == true && apiResponse.data != null) {
          return apiResponse.data!;
        } else {
          String errorMessage = apiResponse.successMessage ??
              'Failed to fetch orders: API returned non-success.';
          if (apiResponse.errorList != null &&
              apiResponse.errorList!.isNotEmpty) {
            errorMessage += ' Errors: ${apiResponse.errorList!.join(', ')}';
          }
          throw Exception(errorMessage);
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error:
              'Failed to fetch orders: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      String errorMessage =
          'Failed to fetch orders. Please check your internet connection or try again later.';
      if (e.response != null) {
        errorMessage = e.response?.data['message'] ??
            e.response?.statusMessage ??
            errorMessage;
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
}
*/



import 'dart:convert'; // ضروري لتحويل JSON إذا كانت البيانات نصية
import 'package:dio/dio.dart';
import 'package:mechpro/core/constants/api_constants.dart';
import 'package:mechpro/core/services/dio_provider.dart'; // تأكد أن هذا المسار صحيح
import 'package:mechpro/feature/orders/data/models/request/order_model/order_model.dart';
import 'package:mechpro/feature/orders/data/models/response/order_response/order_response.dart';
import 'package:mechpro/feature/orders/data/models/response/order_response/data.dart'; // نفترض أن 'DataOrder' موجود هنا
import 'package:shared_preferences/shared_preferences.dart'; // مطلوب لجلب توكن Firebase

// قم بإزالة هذا الاستيراد إذا لم يكن مطلوباً فعلياً ويشير إلى نفس الملف
// import 'package:mechpro/feature/orders/data/repo/order_repo.dart';

class OrdersRepo {
  OrdersRepo(); // الكونستركتور جيد

  // دالة مساعدة لجلب الـ Headers الخاصة بالمصادقة
  Future<Map<String, dynamic>> _getAuthHeaders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? firebaseToken = prefs.getString('firebase_user_id_token');

    if (firebaseToken == null) {
      print('ERROR: Firebase token is NULL. Cannot make authenticated API call.');
      // يمكنك إلقاء استثناء (throw Exception) هنا أو إرجاع خريطة فارغة اعتماداً على استراتيجية معالجة الأخطاء لديك
      throw Exception('المستخدم غير مصادق. لم يتم العثور على توكن Firebase.');
    }

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $firebaseToken', // هذا يضيف التوكن في الـ Header
    };
  }

  /// تنشئ طلباً جديداً بإرسال طلب POST إلى الـ API.
  Future<OrderResponse> createOrder(OrderModel order) async {
    try {
      final headers = await _getAuthHeaders(); // جلب الـ Headers المصادق عليها

      final response = await DioProvider.post(
        endPoint: ApiConstants.makeOrder, // يجب أن تكون هذه هي نقطة النهاية الصحيحة لإنشاء الطلبات
        data: order.toJson(), // استخدم 'data' لجسم طلب POST، وليس 'params'
        headers: headers, params: {}, // تمرير الـ Headers المصادق عليها
      );

      // التحقق من رموز حالة النجاح (200 OK, 201 Created)
      if (response.statusCode == 200 || response.statusCode == 201) {
        // التأكد من تحليل البيانات بشكل صحيح من استجابة String محتملة
        if (response.data is String) {
          final decodedData = json.decode(response.data as String);
          return OrderResponse.fromJson(decodedData as Map<String, dynamic>);
        } else if (response.data is Map<String, dynamic>) {
          return OrderResponse.fromJson(response.data as Map<String, dynamic>);
        } else {
          throw Exception('نوع بيانات استجابة غير متوقع لـ createOrder: ${response.data.runtimeType}');
        }
      } else {
        // معالجة رموز الحالة غير 200/201، ولكن ليست استثناءات Dio التي يتم التقاطها أدناه
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'فشل إنشاء الطلب: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      // DioException تلتقط أخطاء الشبكة، وأخطاء المهلة، وأخطاء الخادم (مثل 4xx, 5xx)
      String errorMessage = 'فشل إنشاء الطلب. يرجى التحقق من اتصالك بالإنترنت أو المحاولة لاحقاً.';
      if (e.response != null) {
        // محاولة الحصول على رسالة خطأ أكثر تحديداً من استجابة الـ API
        errorMessage = e.response?.data?['message'] ?? e.response?.data?['error'] ?? e.response?.statusMessage ?? errorMessage;
        print('خطأ Dio في createOrder (الحالة: ${e.response?.statusCode}): $errorMessage. الاستجابة الخام: ${e.response?.data}');
      } else {
        // خطأ في الشبكة أو مهلة
        errorMessage = e.message ?? errorMessage;
        print('خطأ Dio في createOrder (لا توجد استجابة): $errorMessage');
      }
      throw Exception(errorMessage); // إلقاء استثناء عام للطبقات الأعلى
    } catch (e) {
      // التقاط أي أخطاء أخرى غير متوقعة
      print('حدث خطأ غير متوقع في createOrder: $e');
      throw Exception('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  /// تجلب قائمة بالطلبات عن طريق إرسال طلب GET إلى الـ API.
  Future<List<DataOrder>> getOrdersFromApi() async {
    try {
      final headers = await _getAuthHeaders(); // جلب الـ Headers المصادق عليها

      final response = await DioProvider.get(
        endPoint: ApiConstants.getOrders, // 🌟 تأكد أن هذه هي نقطة النهاية الصحيحة لجلب الطلبات!
        // لا توجد 'params' هنا ما لم يكن طلب GET الخاص بك يتوقع query parameters
        headers: headers, params: {}, // تمرير الـ Headers المصادق عليها
      );

      if (response.statusCode == 200) {
        // التأكد من تحليل البيانات بشكل صحيح من استجابة String محتملة
        Map<String, dynamic> responseData;
        if (response.data is String) {
          responseData = json.decode(response.data as String) as Map<String, dynamic>;
        } else if (response.data is Map<String, dynamic>) {
          responseData = response.data as Map<String, dynamic>;
        } else {
          throw Exception('نوع بيانات استجابة غير متوقع لـ getOrdersFromApi: ${response.data.runtimeType}');
        }

        final apiResponse = OrderResponse.fromJson(responseData);

        if (apiResponse.isSuccess == true && apiResponse.data != null) {
          // نفترض أن حقل 'data' في OrderResponse هو List<DataOrder>
          return apiResponse.data!;
        } else {
          String errorMessage = apiResponse.successMessage ?? 'فشل جلب الطلبات: الـ API أعادت حالة غير نجاح.';
          if (apiResponse.errorList != null && apiResponse.errorList!.isNotEmpty) {
            errorMessage += ' الأخطاء: ${apiResponse.errorList!.join(', ')}';
          }
          print('الـ API أعادت حالة غير نجاح لـ getOrdersFromApi: $errorMessage');
          throw Exception(errorMessage);
        }
      } else {
        // معالجة رموز الحالة غير 200
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'فشل جلب الطلبات: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'فشل جلب الطلبات. يرجى التحقق من اتصالك بالإنترنت أو المحاولة لاحقاً.';
      if (e.response != null) {
        errorMessage = e.response?.data?['message'] ?? e.response?.data?['error'] ?? e.response?.statusMessage ?? errorMessage;
        print('خطأ Dio في getOrdersFromApi (الحالة: ${e.response?.statusCode}): $errorMessage. الاستجابة الخام: ${e.response?.data}');
      } else {
        errorMessage = e.message ?? errorMessage;
        print('خطأ Dio في getOrdersFromApi (لا توجد استجابة): $errorMessage');
      }
      throw Exception(errorMessage);
    } catch (e) {
      print('حدث خطأ غير متوقع في getOrdersFromApi: $e');
      throw Exception('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }
}