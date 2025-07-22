
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/cubit/selling_state.dart';
/*
import '../../data/repo/selling_repo.dart';

class SellingCubit extends Cubit<SellingStates> {
  SellingCubit() : super(SellingInitialState());
 
 getSelling(){
    emit(SellingLoadingState());
    SellingRepo.getSelling().then((value) {
      if (value != null) {
        emit(SellingSuccessState());
      } else {
        emit(SellingErrorState('something went wrong'));
      }
    });




  }

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/cubit/selling_state.dart';
import '../../data/repo/selling_repo.dart';
// استيراد SellingResponse

class SellingCubit extends Cubit<SellingStates> {
  SellingCubit() : super(SellingInitialState());

  Future<void> getSelling() async { // جعلها Future<void>
    emit(SellingLoadingState());
    try {
      final value = await SellingRepo.getSelling(); // استخدم await
      if (value != null) {
        emit(SellingSuccessState(value)); // مرّر SellingResponse
      } else {
        emit(SellingErrorState('Failed to load selling original parts.'));
      }
    } catch (e) {
      emit(SellingErrorState('An error occurred: $e'));
    }
  }
}





