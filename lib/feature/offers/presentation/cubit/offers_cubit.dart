
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/offers/data/repo/offers_repo.dart';
import 'package:mechpro/feature/offers/presentation/cubit/offers_state.dart';

class OffersCubit extends Cubit<OffersState> {

OffersCubit() : super(OffersInitial());

  Future<void> getOffers() async{
    emit(OffersLoading());

try {
      final value = await OffersRepo.getOffers(); 
      if (value != null) {
        emit(OffersSuccess(value)); 
      } else {
        emit(OffersError('Failed to load selling original parts.'));
      }
    } catch (e) {
      emit(OffersError('An error occurred: $e'));
    }


  }



}