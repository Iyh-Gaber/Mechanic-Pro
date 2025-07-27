import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/auto_body_repair/data/repo/auto_body_repo.dart';
import 'package:mechpro/feature/auto_body_repair/presentation/cubit/auto_body_state.dart';

class AutoBodyCubit extends Cubit<AutoBodyState> {
  AutoBodyCubit() : super(AutoBodyInitial());

  Future<void> getAutoBodyServices() async {
    try {
      emit(AutoBodyLoadingState());
      final response = await AutoBodyRepo().getAutoBodyServices();
      if (response != null) {
        emit(AutoBodySuccessState(response));
      } else {
        emit(AutoBodyErrorState('Something went wrong'));
      }
    } catch (e) {
      emit(AutoBodyErrorState(e.toString()));
    }
  }
}
