abstract class PasswordVisibilityState {
  final bool isPasswordVisible;

  PasswordVisibilityState({required this.isPasswordVisible});
}

class PasswordVisibilityInitial extends PasswordVisibilityState {
  PasswordVisibilityInitial() : super(isPasswordVisible: false);
}

class PasswordVisibilityToggled extends PasswordVisibilityState {
  PasswordVisibilityToggled(bool isVisible)
      : super(isPasswordVisible: isVisible);
}
