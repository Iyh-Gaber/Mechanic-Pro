/*import 'package:bloc/bloc.dart';
import 'package:mechpro/feature/home/presentation/cubit/main_services_states.dart';

import '../../data/models/response/main_services_response/main_services_response.dart';
import '../../data/repo/main_services_repo.dart';

class MainServicesCubit extends Cubit<MainServicesStates> {
  MainServicesCubit() : super(MainServicesInitialState());
  MainServicesResponse? mainServicesResponse;
  getMainService() {
    emit(MainServicesLoadingState());
    MainServicesRepo.getMainServices().then((value) {
      if (value != null) {
        mainServicesResponse = value;
        emit(MainServicesSuccessState());
      } else {
        emit(MainServicesErrorState('something went wrong'));
      }
    });
  }
}
*/
/*
// مثال لـ MainServicesCubit (في ملف main_services_cubit.dart)
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/home/data/models/response/main_services_response/main_services_response.dart';
import 'package:mechpro/feature/home/data/repo/main_services_repo.dart';
 // تأكد من المسار الصحيح للـ repo
import 'package:mechpro/feature/home/presentation/cubit/main_services_states.dart';

import '../../data/repo/main_services_repo.dart';

class MainServicesCubit extends Cubit<MainServicesStates> {
  final MainServicesRepo mainServicesRepo; // افترض أن لديك HomeRepo لجلب البيانات

  MainServicesCubit(this.mainServicesRepo) : super(MainServicesInitialState()); // تهيئة الحالة الأولية

  MainServicesResponse? mainServicesResponse; // لتخزين الاستجابة

  Future<void> fetchMainServices() async {
    emit(MainServicesLoadingState()); // إصدار حالة التحميل

    try {
      final response = await MainServicesRepo.getMainServices(); // استدعاء دالة جلب الخدمات من الـ repo
      mainServicesResponse = response; // تخزين الاستجابة
      emit(MainServicesSuccessState(response!)); // إصدار حالة النجاح مع البيانات
    } catch (e) {
      emit(MainServicesErrorState(e.toString())); // إصدار حالة الخطأ
    }
  }
}
*/

/*

import 'package:bloc/bloc.dart';
import 'package:mechpro/feature/home/presentation/cubit/main_services_states.dart';

import '../../data/models/response/main_services_response/main_services_response.dart';
import '../../data/repo/main_services_repo.dart';

class MainServicesCubit extends Cubit<MainServicesStates> {
  MainServicesCubit(MainServicesRepo mainServicesRepo)
      : super(MainServicesInitialState());

  MainServicesResponse? mainServicesResponse;

  Future<void> fetchMainServices() async {
   
    emit(MainServicesLoadingState()); // إصدار حالة التحميل

    try {
      final value = await MainServicesRepo.getMainServices();
  

      if (value != null) {
        mainServicesResponse = value;
       
        emit(MainServicesSuccessState(
            value)); // تمرير الاستجابة (value) مع حالة النجاح
      } else {
        
        emit(MainServicesErrorState(
            'something went wrong: Null response from repo'));
      }
    } catch (e) {
     
      emit(MainServicesErrorState(e.toString()));
    }
  }
}
*/

import 'package:bloc/bloc.dart';
import 'package:mechpro/feature/home/presentation/cubit/main_services_states.dart';

import '../../data/models/response/main_services_response/main_services_response.dart';
import '../../data/repo/main_services_repo.dart';

class MainServicesCubit extends Cubit<MainServicesStates> {
  // استخدم متغير خاص لتخزين النسخة المحقونة من MainServicesRepo
  final MainServicesRepo _mainServicesRepo;

  // استقبل MainServicesRepo في المُنشئ وقم بتخزينه
  MainServicesCubit(this._mainServicesRepo) : super(MainServicesInitialState());

  // يمكن الاستغناء عن هذا المتغير إذا كنت تمرر البيانات مباشرة في SuccessState
  // MainServicesResponse? mainServicesResponse;

  Future<void> fetchMainServices() async {
    emit(MainServicesLoadingState()); // إصدار حالة التحميل

    try {
      // استخدم النسخة المحقونة من الـ Repo لإجراء الاستدعاء
      final value = await MainServicesRepo.getMainServices(); // <-- التعديل هنا

      if (value != null) {
        // إذا كنت ما زلت تحتاج لتخزينها في الكيوبيت (عادةً لا يلزم إذا كانت في الـ state)
        // mainServicesResponse = value;

        emit(
          MainServicesSuccessState(value),
        ); // تمرير الاستجابة (value) مع حالة النجاح
      } else {
        emit(
          MainServicesErrorState(
            'something went wrong: Null response from repository. Please try again.',
          ),
        ); // رسالة أوضح
      }
    } catch (e) {
      print(
        'Error in MainServicesCubit.fetchMainServices: $e',
      ); // طباعة الخطأ الكامل
      emit(
        MainServicesErrorState('An unexpected error occurred: ${e.toString()}'),
      ); // رسالة عامة للواجهة
    }
  }
}
