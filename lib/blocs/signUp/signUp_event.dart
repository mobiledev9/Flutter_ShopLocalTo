

abstract class SignUpEvent {}

class OnSignUp extends SignUpEvent {
  final String username;
  final String email;
  final String phone;
  final String password;
  final String location;

  OnSignUp({this.username, this.email, this.phone,this.password,this.location,  });
}

class AfterSignUp extends SignUpEvent {
  AfterSignUp();
}