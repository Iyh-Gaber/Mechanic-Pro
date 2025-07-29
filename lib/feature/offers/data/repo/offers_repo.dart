import 'package:mechpro/core/constants/api_constants.dart';
import 'package:mechpro/core/services/dio_provider.dart';
import 'package:mechpro/feature/offers/data/models/response/offers_response/offers_response.dart';

class OffersRepo {
  static Future<OffersResponse?> getOffers() async {
    try {
var response = await DioProvider.get(endPoint: ApiConstants.offers);
    
    if (response.statusCode == 200 && response.data != null) {
      return OffersResponse.fromJson(response.data);
      
    }else {
      return null;
    }
      
    }on Exception catch (e) {
      return null;
    }
  }
}
