abstract class LoginEvent {}

class OnLogin extends LoginEvent {
  final String email;
  final String password;

  OnLogin({this.email, this.password});
}

class OnLogout extends LoginEvent {
  OnLogout();
}
