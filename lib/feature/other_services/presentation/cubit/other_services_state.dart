/*
import 'package:mechpro/feature/other_services/data/models/response/other_services_response/other_services_response.dart';

class OtherServicesState {}

class OtherServicesInitial extends OtherServicesState {}

class OtherServicesLoading extends OtherServicesState {}

class OtherServicesSuccess extends OtherServicesState {
  OtherServicesSuccess(OtherServicesResponse value);
}

class OtherServicesError extends OtherServicesState {
  OtherServicesError(String s);
}
*/

import 'package:mechpro/feature/other_services/data/models/response/other_services_response/other_services_response.dart';

sealed class OtherServicesState {}

class OtherServicesInitial extends OtherServicesState {}

class OtherServicesLoading extends OtherServicesState {}

class OtherServicesSuccess extends OtherServicesState {
  final OtherServicesResponse response; // ****** تم التعديل لإضافة final property ******
  OtherServicesSuccess(this.response);
}

class OtherServicesError extends OtherServicesState {
  final String message; // ****** تم التعديل لإضافة final property ******
  OtherServicesError(this.message);
}