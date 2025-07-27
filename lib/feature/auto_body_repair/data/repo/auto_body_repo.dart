import 'package:easy_localization/easy_localization.dart';
import 'package:mechpro/feature/auto_body_repair/data/models/response/auto_body_response/auto_body_response.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/dio_provider.dart';

class AutoBodyRepo {
  Future<AutoBodyResponse?> getAutoBodyServices() async {
    try {
      var response = await DioProvider.get(
        endPoint: ApiConstants.autoBodyRepair,
        headers: {},
      );
      if (response.statusCode == 200) {
        return AutoBodyResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      //  log(e.toString());
      return null;
    }
  }
}
