/*class MainServicesStates {}

class MainServicesInitialState extends MainServicesStates {}

class MainServicesLoadingState extends MainServicesStates {}

class MainServicesErrorState extends MainServicesStates {
  final String message;
  MainServicesErrorState(this.message);
}

class MainServicesSuccessState extends MainServicesStates {}
*/

import 'package:mechpro/feature/home/data/models/response/main_services_response/main_services_response.dart'; // تأكد من المسار الصحيح

abstract class MainServicesStates {}

class MainServicesInitialState extends MainServicesStates {}

class MainServicesLoadingState extends MainServicesStates {}

class MainServicesSuccessState extends MainServicesStates {
  final MainServicesResponse mainServicesResponse; // <--- تم إضافة هذا السطر
  MainServicesSuccessState(
    this.mainServicesResponse,
  ); // <--- وتم تعديل الـ constructor هنا
}

class MainServicesErrorState extends MainServicesStates {
  final String message;
  MainServicesErrorState(this.message);
}
