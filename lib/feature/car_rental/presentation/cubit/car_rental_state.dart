import 'package:mechpro/feature/car_rental/data/models/response/car_rental_response/car_rental_response.dart';

abstract class CarRentalStates {}

class CarRentalInitialState extends CarRentalStates {}

class CarRentalLoadingState extends CarRentalStates {}

class CarRentalSuccessState extends CarRentalStates {
  final CarRentalResponse carRentalResponse;
  CarRentalSuccessState(this.carRentalResponse);
}

class CarRentalErrorState extends CarRentalStates {
  final String error;
  CarRentalErrorState(this.error);
}
