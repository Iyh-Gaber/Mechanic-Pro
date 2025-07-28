

 import 'package:mechpro/core/constants/api_constants.dart';
import 'package:mechpro/core/services/dio_provider.dart';
import 'package:mechpro/feature/tool_rental/data/models/response/tool_rental_response/tool_rental_response.dart';

class ToolRentalRepo {

 static Future<ToolRentalResponse?>    getToolRental()async
 {
   try {
     var response = await DioProvider.get(endPoint: ApiConstants.toolRental);
     if (response.statusCode == 200 && response.data != null) {
       return ToolRentalResponse.fromJson(response.data);
     } else {
       return null;
     }
   } on Exception catch (e) {
     return null;
   }




 }




 }
