import '../../data/models/response/mechanical_response/mechanical_response.dart';

abstract class MechanicalStates {}

class MechanicalInitialState extends MechanicalStates {}

class MechanicalLoadingState extends MechanicalStates {}

class MechanicalSuccessState extends MechanicalStates {
  final MechanicalResponse value; // تأكد أن النوع هو MechanicalResponse

  MechanicalSuccessState(this.value); // استقبل القيمة مباشرة
}

class MechanicalErrorState extends MechanicalStates {
  final String error;
  MechanicalErrorState(this.error);
}
