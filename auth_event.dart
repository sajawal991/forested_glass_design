abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String emailOrPhone;
  final String password;

  SignInEvent(this.emailOrPhone, this.password);
}
