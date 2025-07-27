import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/repairing_electrical_faults/data/repo/electrical_repo.dart';
import 'package:mechpro/feature/repairing_electrical_faults/presentation/cubit/electrical_state.dart';

import '../../../regular_maintenance/presentation/cubit/regular_services_state.dart';

class ElectricalCubit extends Cubit<ElectricalState> {
  final ElectricalRepo electricalRepo;

  ElectricalCubit(this.electricalRepo) : super(ElectricalInitial());

  Future<void> getElectricalServices() async {
    emit(ElectricalLoadingState());

    try {
      final response = await electricalRepo.getElectricalServices(); // ✅ صحيح

      if (response != null) {
        emit(ElectricalSuccessState(response));
      } else {
        emit(ElectricalErrorState('Something went wrong: API returned null.'));
      }
    } catch (e) {
      emit(ElectricalErrorState(e.toString()));
    }
  }
}
