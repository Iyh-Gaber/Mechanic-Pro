import 'package:mechpro/feature/auto_body_repair/data/models/response/auto_body_response/auto_body_response.dart';

sealed class AutoBodyState {}

class AutoBodyInitial extends AutoBodyState {}

class AutoBodyLoadingState extends AutoBodyState {}

class AutoBodyErrorState extends AutoBodyState {
  final String message; // Add a final message field
  AutoBodyErrorState(this.message); // Update constructor
}

class AutoBodySuccessState extends AutoBodyState {
  final AutoBodyResponse response; // Add a final response field
  AutoBodySuccessState(this.response); // Update constructor
}
