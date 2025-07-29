
import 'package:mechpro/feature/offers/data/models/response/offers_response/offers_response.dart';

abstract class OffersState {}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersSuccess extends OffersState {
  final OffersResponse offerResponse; // **هذا هو السطر الذي يجب أن يكون موجودًا**
  OffersSuccess(this.offerResponse);
}

class OffersError extends OffersState {
  final String message; // **هذا هو السطر الذي يجب أن يكون موجودًا**
  OffersError(this.message);
}
