

import 'package:mechpro/feature/tool_rental/data/models/response/tool_rental_response/tool_rental_response.dart';

abstract class ToolRentalStates {}

class ToolRentalInitialState extends ToolRentalStates {}

class ToolRentalLoadingState extends ToolRentalStates {}

class ToolRentalSuccessState extends ToolRentalStates {
  final ToolRentalResponse toolRentalResponse;
  ToolRentalSuccessState(this.toolRentalResponse);
}

class ToolRentalErrorState extends ToolRentalStates {
  final String error;
 ToolRentalErrorState(this.error);
}
