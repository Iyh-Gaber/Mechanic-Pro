/* class AuthStates {}

class AuthInitState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthErrorState extends AuthStates {
  String error;

  AuthErrorState( {required this.error});
}

class PasswordVisibleState extends AuthStates {
  late final bool isPasswordVisible;
  late final bool isConfirmPasswordVisible;

  PasswordVisibleState(
      {required this.isPasswordVisible,
      required this.isConfirmPasswordVisible});
}
*/

// lib/feature/auth/presintation/cubit/auth_states.dart

// Abstract base class for all authentication states
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// Initial state, also used to manage the login/register mode
class AuthInitial extends AuthState {
  final bool isLoginMode;
  const AuthInitial({this.isLoginMode = true});

  @override
  List<Object> get props => [isLoginMode];
}

// State when an authentication operation is in progress (e.g., signing in, registering)
class AuthLoading extends AuthState {
  final bool isLoginMode; // To keep track of the current mode during loading
  const AuthLoading({required this.isLoginMode});

  @override
  List<Object> get props => [isLoginMode];
}

// State when an authentication operation is successful
class AuthSuccess extends AuthState {}

// State when an authentication operation fails
class AuthError extends AuthState {
  final String message;
  final bool isLoginMode; // To revert the UI to the correct mode after an error
  const AuthError(this.message, {required this.isLoginMode});

  @override
  List<Object> get props => [message, isLoginMode];
}
