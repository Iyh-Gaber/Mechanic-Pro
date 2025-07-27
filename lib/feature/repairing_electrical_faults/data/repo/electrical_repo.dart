import 'package:mechpro/feature/repairing_electrical_faults/data/models/response/electrical_response/electrical_response.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/dio_provider.dart';

class ElectricalRepo {
  Future<ElectricalResponse?> getElectricalServices() async {
    try {
      var response = await DioProvider.get(
        endPoint: ApiConstants.electricalfaults,
        headers: {},
      );
      if (response.statusCode == 200) {
        return ElectricalResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      //  log(e.toString());
      return null;
    }
  }
}
