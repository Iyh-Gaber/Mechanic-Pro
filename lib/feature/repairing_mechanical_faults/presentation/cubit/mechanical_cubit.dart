import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mechpro/feature/repairing_mechanical_faults/presentation/cubit/mechanical_state.dart';

import '../../data/repo/mechanical_repo.dart';

class MechanicalCubit extends Cubit<MechanicalStates> {
  MechanicalCubit() : super(MechanicalInitialState());

  Future<void> getMechanical() async {
    emit(MechanicalLoadingState());
    try {
      final value = await MechanicalRepo.getMechanicalFaults();
      if (value != null) {
        emit(MechanicalSuccessState(value));
      } else {
        emit(MechanicalErrorState('something went wrong'));
      }
    } catch (e) {
      emit(MechanicalErrorState('something went wrong'));
    }
  }
}
