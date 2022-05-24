abstract class SocialLoginState {}

class InitialSocialLoginState extends SocialLoginState {}

class SocialLoginLoading extends SocialLoginState {
}

class SocialLoginFail extends SocialLoginState {
  final String message;

  SocialLoginFail(this.message);
}

class SocialLoginSuccess extends SocialLoginState {

}

class AfterSocialLoginLoading extends SocialLoginState {}

class AfterSocialLoginFail extends SocialLoginState {
  final String message;

  AfterSocialLoginFail(this.message);
}

class AfterSocialLoginSuccess extends SocialLoginState {}
