import 'package:bloc/bloc.dart';
import 'package:mechpro/feature/home/presentation/cubit/main_services_states.dart';

import '../../data/models/response/main_services_response/main_services_response.dart';
import '../../data/repo/main_services_repo.dart';

class MainServicesCubit extends Cubit<MainServicesStates> {
  MainServicesCubit() : super(MainServicesInitialState());
MainServicesResponse? mainServicesResponse;
  getmainServices() {
    emit(MainServicesLoadingState());
    MainServicesRepo.mainServices().then((value) {
      if (value != null) {
        mainServicesResponse = value;
        emit(MainServicesSuccessState());
      } else {
        emit(MainServicesErrorState('something went wrong'));
      }
    });
  }
}
