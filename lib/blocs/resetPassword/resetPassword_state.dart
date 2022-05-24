abstract class ResetState {}

class InitialResetState extends ResetState {}

class ResetLoading extends ResetState {}

class ResetFail extends ResetState {
  final String message;

  ResetFail(this.message);
}

class ResetSuccess extends ResetState {

}

class AfterResetLoading extends ResetState {}

class AfterResetFail extends ResetState {
  final String message;

  AfterResetFail(this.message);
}

class AfterResetSuccess extends ResetState {}
