abstract class CreateAccountAuthEvent {}

class CreateAccountEvent extends CreateAccountAuthEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String fullname;
  final String phonenumber;
  final String country;
  final String city;
  final String houseNo;
  final String streetNo;
  final String postalCode;
  final String blockNo;

  CreateAccountEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.fullname,
    required this.phonenumber,
    required this.country,
    required this.city,
    required this.houseNo,
    required this.streetNo,
    required this.postalCode,
    required this.blockNo,
  });
}

class CreateAccountSuccessEvent extends CreateAccountAuthEvent {}

class CreateAccountFailureEvent extends CreateAccountAuthEvent {
  final String error;

  CreateAccountFailureEvent(this.error);
}
