import 'package:mechpro/core/constants/api_constants.dart';
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
