abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess(this.message); // Represents a successful sign-in
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error); // Represents a sign-in failure
}
