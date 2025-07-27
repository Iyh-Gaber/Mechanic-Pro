import 'package:mechpro/feature/regular_maintenance/data/models/response/regular_response/regular_response.dart';
import 'package:mechpro/feature/repairing_electrical_faults/data/models/response/electrical_response/electrical_response.dart';

sealed class ElectricalState {}

class ElectricalInitial extends ElectricalState {}

class ElectricalLoadingState extends ElectricalState {}

class ElectricalErrorState extends ElectricalState {
  final String message; // Add a final message field
  ElectricalErrorState(this.message); // Update constructor
}

class ElectricalSuccessState extends ElectricalState {
  final ElectricalResponse response; // Add a final response field
  ElectricalSuccessState(this.response); // Update constructor
}
