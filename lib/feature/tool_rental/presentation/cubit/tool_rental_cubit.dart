import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/tool_rental/data/repo/tool_rental_repo.dart';
import 'package:mechpro/feature/tool_rental/presentation/cubit/tool_rental_state.dart';

class ToolRentalCubit extends Cubit<ToolRentalStates> {
  ToolRentalCubit() : super(ToolRentalInitialState());

  Future<void> getToolRental() async {
    emit(ToolRentalLoadingState());
    try {
      final value = await ToolRentalRepo.getToolRental();
      if (value != null) {
        emit(ToolRentalSuccessState(value)); 
      } else {
        emit(ToolRentalErrorState('Failed to load selling original parts.'));
      }
    } catch (e) {
      emit(ToolRentalErrorState('An error occurred: $e'));
    }
  }
}
