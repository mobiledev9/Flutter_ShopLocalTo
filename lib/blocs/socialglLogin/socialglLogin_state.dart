abstract class SocialglLoginState {}

class InitialSocialglLoginState extends SocialglLoginState {}

class SocialglLoginLoading extends SocialglLoginState {
}

class SocialglLoginFail extends SocialglLoginState {
  final String message;

  SocialglLoginFail(this.message);
}

class SocialglLoginSuccess extends SocialglLoginState {

}

class AfterSocialglLoginLoading extends SocialglLoginState {}

class AfterSocialglLoginFail extends SocialglLoginState {
  final String message;

  AfterSocialglLoginFail(this.message);
}

class AfterSocialglLoginSuccess extends SocialglLoginState {}
