abstract class CreateAccountAuthState {}

class CreateAccountAuthInitial extends CreateAccountAuthState {}

class CreateAccountAuthLoading extends CreateAccountAuthState {}

class CreateAccountAuthSuccess extends CreateAccountAuthState {
  final String message;

  CreateAccountAuthSuccess(this.message);
}

class CreateAccountAuthFailure extends CreateAccountAuthState {
  final String error;

  CreateAccountAuthFailure(this.error);
}
