/*import 'package:mechpro/core/constants/api_constants.dart';
import 'package:mechpro/core/services/dio_provider.dart';
import 'package:mechpro/feature/home/data/models/response/main_services_response/main_services_response.dart';

class MainServicesRepo {
  static Future<MainServicesResponse?> getMainServices() async {
    try {
      var response = await DioProvider.get(endPoint: ApiConstants.mainServices);
      if (response.statusCode == 200) {
        return MainServicesResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      // log(e.toString());
      return null;
    }
  }
}
*/




/*
import 'dart:convert'; // لا تنسَ استيراد هذا المكتبة للتعامل مع JSON

import 'package:mechpro/core/constants/api_constants.dart';
import 'package:mechpro/core/services/dio_provider.dart';
import 'package:mechpro/feature/home/data/models/response/main_services_response/main_services_response.dart';

class MainServicesRepo {
  // يفضل أن يكون غير ثابت (static) ليتم حقنه بسهولة للاختبار
  // إذا كنت تريد استخدامه كـ static، لا مشكلة كبيرة هنا حاليًا، لكنه ليس أفضل ممارسة للـ Cubit
  static Future<MainServicesResponse?> getMainServices() async {
    try {
      var response = await DioProvider.get(endPoint: ApiConstants.mainServices);

      // هنا يتم التعامل مع المشكلة الأساسية:
      // إذا كانت البيانات نصية (String)، يجب فك تشفيرها إلى Map
      if (response.statusCode == 200) {
        if (response.data is String) {
          // جرب فك تشفير البيانات النصية إلى JSON
          try {
            final decodedData = json.decode(response.data as String);
            // تأكد أن البيانات بعد فك التشفير هي Map<String, dynamic>
            if (decodedData is Map<String, dynamic>) {
              return MainServicesResponse.fromJson(decodedData);
            } else {
              // إذا كانت ليست Map بعد فك التشفير، سجل الخطأ
              print('Error: Decoded data is not a Map<String, dynamic>. Type: ${decodedData.runtimeType}');
              return null;
            }
          } catch (e) {
            // خطأ في فك تشفير JSON (الـ String ليس JSON صالحًا)
            print('Error decoding JSON string: $e. Raw data: ${response.data}');
            return null;
          }
        } else if (response.data is Map<String, dynamic>) {
          // إذا كانت البيانات هي بالفعل Map<String, dynamic>، استخدمها مباشرة
          return MainServicesResponse.fromJson(response.data as Map<String, dynamic>);
        } else {
          // حالة غير متوقعة: البيانات ليست String ولا Map
          print('Error: Unexpected response data type: ${response.data.runtimeType}. Raw data: ${response.data}');
          return null;
        }
      } else {
        // حالة خطأ في الـ Status Code (غير 200)
        print('API Error: Status Code ${response.statusCode}. Response: ${response.data}');
        return null;
      }
    } on Exception catch (e) {
      // log(e.toString()); // استخدم log() إذا كنت تستخدم مكتبة logging
      print('Exception in MainServicesRepo.getMainServices: $e'); // اطبع الخطأ للمساعدة في التصحيح
      return null;
    }
  }
}
*/


import 'dart:convert'; // لا تنسَ استيراد هذا المكتبة للتعامل مع JSON

import 'package:mechpro/core/constants/api_constants.dart';
import 'package:mechpro/core/services/dio_provider.dart';
import 'package:mechpro/feature/home/data/models/response/main_services_response/main_services_response.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 👈 إضافة هذا الاستيراد لجلب الرمز

class MainServicesRepo {
  // يفضل أن يكون غير ثابت (static) ليتم حقنه بسهولة للاختبار
  // إذا كنت تريد استخدامه كـ static، لا مشكلة كبيرة هنا حاليًا، لكنه ليس أفضل ممارسة للـ Cubit
  static Future<MainServicesResponse?> getMainServices() async {
    try {
      // 1. استرجاع رمز المصادقة (Firebase ID Token)
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? firebaseToken = prefs.getString('firebase_user_id_token'); // 👈 المفتاح الذي استخدمته لحفظ الرمز

      // 🚨 للتحقق: اطبع الرمز لترى ما إذا تم استرجاعه
      print('DEBUG: Firebase Token from SharedPreferences in MainServicesRepo: $firebaseToken');

      // إذا لم يكن هناك رمز، فهذا يعني أن المستخدم غير مسجل دخول
      if (firebaseToken == null) {
        print('ERROR: Firebase token is NULL. User is not authenticated for backend API calls.');
        // يمكنك إظهار رسالة للمستخدم أو إعادة توجيهه لصفحة تسجيل الدخول
        return null;
      }

      // 2. إعداد الـ Headers مع رمز المصادقة
      final Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $firebaseToken', // 👈 هذا هو السطر الأهم!
      };

      // 🚨 للتحقق: اطبع الـ Headers التي سترسلها
      print('DEBUG: Headers sent to API: $headers');

      // 3. إرسال الطلب مع الـ Headers الجديدة
      // نفترض أن DioProvider.get تقبل معامل "headers"
      var response = await DioProvider.get(
        endPoint: ApiConstants.mainServices,
        headers: headers, // 👈 تمرير الـ Headers هنا
      );

      // 🚨 للتحقق: اطبع حالة الاستجابة والبيانات الخام
      print('DEBUG: API Response Status Code: ${response.statusCode}');
      print('DEBUG: API Raw Response Data (check for HTML): ${response.data}');

      // هنا يتم التعامل مع المشكلة الأساسية (إذا كانت البيانات نصية يجب فك تشفيرها):
      if (response.statusCode == 200) {
        if (response.data is String) {
          try {
            final decodedData = json.decode(response.data as String);
            if (decodedData is Map<String, dynamic>) {
              return MainServicesResponse.fromJson(decodedData);
            } else {
              print('Error: Decoded data is not a Map<String, dynamic>. Type: ${decodedData.runtimeType}. Raw data: ${response.data}');
              return null;
            }
          } catch (e) {
            print('Error decoding JSON string (data was not valid JSON): $e. Raw data: ${response.data}');
            return null;
          }
        } else if (response.data is Map<String, dynamic>) {
          return MainServicesResponse.fromJson(response.data as Map<String, dynamic>);
        } else {
          print('Error: Unexpected response data type: ${response.data.runtimeType}. Raw data: ${response.data}');
          return null;
        }
      } else {
        print('API Error: Status Code ${response.statusCode}. Response: ${response.data}');
        return null;
      }
    } on Exception catch (e) {
      print('Exception in MainServicesRepo.getMainServices: $e');
      return null;
    }
  }
}