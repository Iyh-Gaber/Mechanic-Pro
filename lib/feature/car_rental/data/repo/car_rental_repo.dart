import 'package:mechpro/feature/car_rental/data/models/response/car_rental_response/car_rental_response.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/dio_provider.dart';

class CarRentalRepo {
  static Future<CarRentalResponse?> getCarRental() async {
    try {
      var response = await DioProvider.get(endPoint: ApiConstants.carRental);
      if (response.statusCode == 200 && response.data != null) {
        return CarRentalResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      return null;
    }
  }
}
