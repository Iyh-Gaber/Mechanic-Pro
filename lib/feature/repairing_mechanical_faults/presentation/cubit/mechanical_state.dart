abstract class MechanicalStates {}

class MechanicalInitialState extends MechanicalStates {}

class MechanicalLoadingState extends MechanicalStates {}

class MechanicalSuccessState extends MechanicalStates {}

class MechanicalErrorState extends MechanicalStates {
  final String error;
  MechanicalErrorState(this.error);
}