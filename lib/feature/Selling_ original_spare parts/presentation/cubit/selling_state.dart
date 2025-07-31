

import '../../data/models/response/selling_response/selling_response.dart';

abstract class SellingStates {}

class SellingInitialState extends SellingStates {}

class SellingLoadingState extends SellingStates {}

class SellingSuccessState extends SellingStates {
  final SellingResponse sellingResponse; // أضف هذا السطر
  SellingSuccessState(this.sellingResponse); // عدّل المُنشئ
}

class SellingErrorState extends SellingStates {
  final String error;
  SellingErrorState(this.error);
}
