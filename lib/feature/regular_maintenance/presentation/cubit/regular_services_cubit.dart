import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/regular_maintenance/data/repo/regular_repo.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/cubit/regular_services_state.dart';

class RegularServicesCubit extends Cubit<RegularServicesState> {
  RegularServicesCubit(this.regularMaintenanceRepo) : super(RegularServicesInitial());

  RegularMaintenanceRepo regularMaintenanceRepo ;
 Future<void> getRegularServices() async {
    emit(RegularServicesLoadingState());

    try {
      final response = await RegularMaintenanceRepo.getRegularServices();
      if (response != null) {
        emit(RegularServicesSuccessState(response));
      } else {
        emit(RegularServicesErrorState('something went wrong'));
      }
    } catch (e) {
      emit(RegularServicesErrorState(e.toString()));
    }
   
  }
  




}