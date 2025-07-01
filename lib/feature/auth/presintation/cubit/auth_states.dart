class AuthStates {}

class AuthInitState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String error;

  AuthErrorState({required this.error});
}

class PasswordVisibleState extends AuthStates {
  late final bool isPasswordVisible;
  late final bool isConfirmPasswordVisible;

  PasswordVisibleState(
      {required this.isPasswordVisible,
      required this.isConfirmPasswordVisible});
}
