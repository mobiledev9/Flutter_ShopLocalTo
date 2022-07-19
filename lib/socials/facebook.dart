

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shoplocalto/service/authService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class AuthBlocFacebook {
  final authService = AuthService();
  final fb = FacebookLogin();
  final facebookLogin = FacebookLogin();

  Stream<User> get currentUser => authService.currentUser;


  Future<UserCredential> signInWithFacebook() async {

    final LoginResult result = await FacebookAuth.instance.login(permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],

      loginBehavior: LoginBehavior.webOnly,

    );
    User user;
    if(result.status == LoginStatus.success){
      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken.token);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }


  logout() async {
    facebookLogin.logOut();
    authService.logout();
    await FirebaseAuth.instance.signOut();
    fb.logOut();
    print('logged out of fb');
  }
}
