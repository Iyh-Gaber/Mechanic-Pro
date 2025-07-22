 /* import 'package:mechpro/core/constants/api_constants.dart';

import '../../../../core/services/dio_provider.dart';

class SellingRepo {
 
static Future<SellingRepo?> getSelling() async {
    try {
      var response = await DioProvider.get(endPoint: ApiConstants.sellingOriginalParts);

      if (response.statusCode == 200) {
        return SellingRepo.getSelling();
      } else {
        return null;
      }
    } on Exception catch (e) {
      
    }
    return null;
  }


*/

import 'package:mechpro/core/constants/api_constants.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/data/models/response/selling_response/selling_response.dart';
import '../../../../core/services/dio_provider.dart';
// استيراد SellingResponse model

class SellingRepo {
  static Future<SellingResponse?> getSelling() async {
    try {
      var response = await DioProvider.get(endPoint: ApiConstants.sellingOriginalParts);

      if (response.statusCode == 200 && response.data != null) {
        // تحليل استجابة JSON إلى SellingResponse
        return SellingResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      // التعامل مع الاستثناء، مثل تسجيله أو إرجاع خطأ محدد
      print('Error fetching selling parts: $e');
      return null;
    }
  }
}









