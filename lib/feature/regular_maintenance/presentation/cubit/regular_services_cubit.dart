import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/regular_maintenance/data/repo/regular_repo.dart'; // تأكد من صحة هذا المسار
import 'package:mechpro/feature/regular_maintenance/presentation/cubit/regular_services_state.dart'; // تأكد من صحة هذا المسار

class RegularServicesCubit extends Cubit<RegularServicesState> {
  // 🌟🌟🌟 تأكد أن هذا الكائن هو نفسه الذي تم تمريره في constructor 🌟🌟🌟
  final RegularMaintenanceRepo regularMaintenanceRepo;

  RegularServicesCubit(
    this.regularMaintenanceRepo,
  ) // استقبل الـ Repo في الـ constructor
  : super(RegularServicesInitial());

  Future<void> getRegularServices() async {
    emit(RegularServicesLoadingState());

    try {
      // 🌟🌟🌟 التعديل هنا: استدعاء الدالة من الكائن (instance) 🌟🌟🌟
      final response = await regularMaintenanceRepo
          .getRegularServices(); // ✅ صحيح

      if (response != null) {
        emit(RegularServicesSuccessState(response));
      } else {
        emit(
          RegularServicesErrorState('Something went wrong: API returned null.'),
        );
      }
    } catch (e) {
      emit(RegularServicesErrorState(e.toString()));
    }
  }
}
