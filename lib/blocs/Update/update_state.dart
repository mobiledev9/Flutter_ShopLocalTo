abstract class UpdateState {}

class InitialUpdateState extends UpdateState {}

class UpdateProfileLoading extends UpdateState {
}

class UpdateFail extends UpdateState {
  final String message;

  UpdateFail(this.message);
}

class UpdateSuccess extends UpdateState {

}

class AfterUpdateLoading extends UpdateState {}

class AfterUpdateFail extends UpdateState {
  final String message;

  AfterUpdateFail(this.message);
}

class AfterUpdateSuccess extends UpdateState {}
