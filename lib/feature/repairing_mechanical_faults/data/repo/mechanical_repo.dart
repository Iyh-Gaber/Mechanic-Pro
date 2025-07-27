import 'package:mechpro/feature/repairing_mechanical_faults/data/models/response/mechanical_response/mechanical_response.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/dio_provider.dart';

class MechanicalRepo {
  static Future<MechanicalResponse?> getMechanicalFaults() async {
    try {
      var response = await DioProvider.get(
        endPoint: ApiConstants.mechanicalFaults,
      );

      if (response.statusCode == 200 && response.data != null) {
        // تحليل استجابة JSON إلى SellingResponse
        return MechanicalResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      print('Error fetching mechanical Faults: $e');
      return null;
    }
  }
}
