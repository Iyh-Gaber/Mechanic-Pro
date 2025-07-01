import '../../data/models/response/main_services_response/datum.dart';

class MainServicesStates {}

class MainServicesInitialState extends MainServicesStates {}

class MainServicesLoadingState extends MainServicesStates {}

class MainServicesErrorState extends MainServicesStates {

final String message;
  MainServicesErrorState(this.message);

}

class MainServicesSuccessState extends MainServicesStates {


}