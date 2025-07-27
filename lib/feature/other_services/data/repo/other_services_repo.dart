/*

import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/dio_provider.dart';
import '../models/response/other_services_response/other_services_response.dart';

 class OtherServicesRepo {


   Future<OtherServicesResponse?>       getOtherServices() async {
    try {
      var response = await DioProvider.get(
        endPoint: ApiConstants.otherServices,
        headers: {},
      );
      if (response.statusCode == 200) {
        return OtherServicesResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      //  log(e.toString());
      return null;
    }
  }













}
*/

import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/app_locale_storage.dart';
import '../../../../core/services/dio_provider.dart';
// **استيراد AppLocaleStorage**
import '../models/response/other_services_response/other_services_response.dart';
import 'dart:developer'; // لجلب log

class OtherServicesRepo {
  Future<OtherServicesResponse?> getOtherServices() async {
    try {
      final token = AppLocaleStorage.getDate('firebaseToken'); // جلب التوكن
      log('DEBUG: Firebase Token from AppLocaleStorage in OtherServicesRepo: $token'); // طباعة للتصحيح

      var response = await DioProvider.get(
        endPoint: ApiConstants.otherServices,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token', // إضافة التوكن
        },
      );
      if (response.statusCode == 200) {
        log('DEBUG: OtherServices API Response Status Code: ${response.statusCode}');
        log('DEBUG: OtherServices API Raw Response Data: ${response.data}');
        return OtherServicesResponse.fromJson(response.data);
      } else {
        log('DEBUG: OtherServices API Error Status Code: ${response.statusCode}');
        return null;
      }
    } on Exception catch (e) {
      log('ERROR: OtherServicesRepo Exception: ${e.toString()}');
      return null;
    }
  }
}