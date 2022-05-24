import 'package:shoplocalto/models/model.dart';

abstract class AuthenticationEvent {}

class AuthenticationCheck extends AuthenticationEvent {
}

class AuthenticationSave extends AuthenticationEvent {
  final UserModel user;

  AuthenticationSave(this.user);
}

class AuthenticationClear extends AuthenticationEvent {}
class AuthenticationSignupSave extends AuthenticationEvent {
  final UserModel user;

  AuthenticationSignupSave(this.user);
}
class AuthenticationUpdateSave extends AuthenticationEvent {
  final UserModel user;

  AuthenticationUpdateSave(this.user);
}
class AuthenticationResetSave extends AuthenticationEvent {
  final UserModel user;

  AuthenticationResetSave(this.user);
}

class AuthenticationContactSave extends AuthenticationEvent {
  final UserModel user;

  AuthenticationContactSave(this.user);
}
class AuthenticationChatSave extends AuthenticationEvent {
  final UserModel user;

  AuthenticationChatSave(this.user);
}
class AuthenticationSocialLoginSave extends AuthenticationEvent{
  final UserModel user;
  AuthenticationSocialLoginSave(this.user);
}
