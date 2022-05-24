

abstract class SocialLoginEvent {}

class OnSocialLogin extends SocialLoginEvent {
  final String name;
  final String email;
  final String provider;
  final String provider_id;
  final String profile_image;

  OnSocialLogin({this.name, this.email,this.provider,this.provider_id,this.profile_image});
}

class AfterSocialLogin extends SocialLoginEvent {
  AfterSocialLogin();
}
//  profile_image