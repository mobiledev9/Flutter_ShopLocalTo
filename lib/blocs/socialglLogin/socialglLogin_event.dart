

abstract class SocialglLoginEvent {}

class OnSocialglLogin extends SocialglLoginEvent {
  final String name;
  final String email;
  final String provider;
  final String provider_id;
  final String profile_image;

  OnSocialglLogin({this.name, this.email,this.provider,this.provider_id,this.profile_image});
}

class AfterSocialglLogin extends SocialglLoginEvent {
  AfterSocialglLogin();
}