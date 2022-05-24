abstract class ResetEvent {}

class OnReset extends ResetEvent {
  final String password;
  final String confirmpassword;

OnReset({this.confirmpassword,this.password});
}

class AfterReset extends ResetEvent {
  AfterReset();
}