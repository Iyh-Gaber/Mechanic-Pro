abstract class SellingStates {}

class SellingInitialState extends SellingStates {}

class SellingLoadingState extends SellingStates {}

class SellingSuccessState extends SellingStates {}

class SellingErrorState extends SellingStates {
  final String error;
  SellingErrorState(this.error);
}
