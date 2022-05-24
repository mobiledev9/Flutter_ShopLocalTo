abstract class AuthenticationState {}

class InitialAuthenticationState extends AuthenticationState {}

class AuthenticationBeginCheck extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationFail extends AuthenticationState {}

class AuthenticationSignupSuccess extends AuthenticationState{}

class AuthenticationUpdateSuccess extends AuthenticationState{}

// class AuthenticationResetSuccess extends AuthenticationState{}