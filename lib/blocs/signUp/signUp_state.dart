abstract class SignUpState {}

class InitialSignUpState extends SignUpState {}

class SignUpLoading extends SignUpState {
}

class SignUpFail extends SignUpState {
  final String message;

  SignUpFail(this.message);
}

class SignUpSuccess extends SignUpState {

}

class AfterSignUpLoading extends SignUpState {}

class AfterSignUpFail extends SignUpState {
  final String message;

  AfterSignUpFail(this.message);
}

class AfterSignUpSuccess extends SignUpState {}
