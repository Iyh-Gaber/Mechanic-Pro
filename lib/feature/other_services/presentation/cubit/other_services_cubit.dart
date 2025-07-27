/*import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/other_services/presentation/cubit/other_services_state.dart';
import '../../data/repo/other_services_repo.dart';
class OtherServicesCubit extends Cubit<OtherServicesState> {
  OtherServicesCubit() : super(OtherServicesInitial());
     
     Future<void> getOtherServices()async{
      
      try{
        emit(OtherServicesLoading());
        final response=await OtherServicesRepo().getOtherServices();
        if(response!=null){
          emit(OtherServicesSuccess(response));
        }else{
          emit(OtherServicesError('something went wrong'));
        }
        }catch(e){
         emit(OtherServicesError('something went wrong'));
      }
    
     }
}
*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/other_services/presentation/cubit/other_services_state.dart';
import '../../data/repo/other_services_repo.dart';

class OtherServicesCubit extends Cubit<OtherServicesState> {
  OtherServicesCubit() : super(OtherServicesInitial());

  Future<void> getOtherServices() async {
    try {
      emit(OtherServicesLoading());
      final response = await OtherServicesRepo().getOtherServices();
      if (response != null && response.isSuccess == true) { // تأكد من isSuccess
        emit(OtherServicesSuccess(response));
      } else {
        // إذا كان response null أو isSuccess خاطئ، اعرض رسالة خطأ مناسبة
        emit(OtherServicesError(response?.successMessage ?? 'Failed to load services.'));
      }
    } catch (e) {
      emit(OtherServicesError(e.toString()));
    }
  }
}