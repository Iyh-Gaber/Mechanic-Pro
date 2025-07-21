/*import 'package:mechpro/feature/regular_maintenance/data/models/response/regular_response/regular_response.dart';

sealed class RegularServicesState {}

class RegularServicesInitial extends RegularServicesState {}

class RegularServicesLoadingState extends RegularServicesState {}
class RegularServicesErrorState extends RegularServicesState {
  RegularServicesErrorState(String s);
  
}

class RegularServicesSuccessState extends RegularServicesState {
  RegularServicesSuccessState(RegularResponse response);
}
*/

import 'package:mechpro/feature/regular_maintenance/data/models/response/regular_response/regular_response.dart';

sealed class RegularServicesState {}

class RegularServicesInitial extends RegularServicesState {}

class RegularServicesLoadingState extends RegularServicesState {}

class RegularServicesErrorState extends RegularServicesState {
  final String message; // Add a final message field
  RegularServicesErrorState(this.message); // Update constructor
}

class RegularServicesSuccessState extends RegularServicesState {
  final RegularResponse response; // Add a final response field
  RegularServicesSuccessState(this.response); // Update constructor
}
