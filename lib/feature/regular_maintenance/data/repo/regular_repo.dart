

import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/dio_provider.dart';
import '../models/response/regular_response/regular_response.dart';

class RegularMaintenanceRepo {
  static Future<RegularResponse?> getRegularServices() async {
    try {
      var response = await DioProvider.get(endPoint: ApiConstants.regularMaintenanceServices);
      if (response.statusCode == 200) {
        return RegularResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
     //  log(e.toString());
      return null;
    }
  }
}
