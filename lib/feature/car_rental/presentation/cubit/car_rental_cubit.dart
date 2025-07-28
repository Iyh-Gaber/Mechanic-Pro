import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/car_rental/data/repo/car_rental_repo.dart';
import 'package:mechpro/feature/car_rental/presentation/cubit/car_rental_state.dart';

class CarRentalCubit extends Cubit<CarRentalStates> {
  CarRentalCubit() : super(CarRentalInitialState());

  Future<void> getCarRental() async {
    emit(CarRentalLoadingState());
    try {
      final value = await CarRentalRepo.getCarRental(); // استخدم await
      if (value != null) {
        emit(CarRentalSuccessState(value)); // مرّر SellingResponse
      } else {
        emit(CarRentalErrorState('Failed to load selling original parts.'));
      }
    } catch (e) {
      emit(CarRentalErrorState('An error occurred: $e'));
    }
  }
}
