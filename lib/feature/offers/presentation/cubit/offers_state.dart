

import 'package:mechpro/feature/offers/data/models/response/offers_response/offers_response.dart';

class OffersState {}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersSuccess extends OffersState {
  OffersSuccess(OffersResponse value);
}

class OffersError extends OffersState {
  OffersError(String s);
}