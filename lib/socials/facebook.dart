//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:shoplocalto/service/authService.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as JSON;
//
// class AuthBlocFacebook {
//   final authService = AuthService();
//   final fb = FacebookLogin();
//   final facebookLogin = FacebookLogin();
//
//   Stream<User> get currentUser => authService.currentUser;
//
//
//   Future<UserCredential> signInWithFacebook() async {
//
//     final LoginResult result = await FacebookAuth.instance.login(permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
//
//       loginBehavior: LoginBehavior.dialogOnly,
//
//     );
//     User user;
//     if(result.status == LoginStatus.success){
//       // Create a credential from the access token
//       final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken.token);
//       // Once signed in, return the UserCredential
//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     }
//     return null;
//   }
//
//   //
//   // Future<User> loginFacebook() async {
//   //   print("Logging in with Facebook");
//   //
//   //   final FacebookLoginResult res = await facebookLogin.logIn(['email']);
//   //
//   //   print(res.status);
//   //
//   //   switch (res.status) {
//   //     case FacebookLoginStatus.loggedIn:
//   //       print("Login Successful");
//   //
//   //       //Get Token
//   //       final FacebookAccessToken fbToken = res.accessToken;
//   //
//   //       //Convert to Auth Credential
//   //       final AuthCredential credential =
//   //           FacebookAuthProvider.credential(fbToken.token);
//   //       print(fbToken.token);
//   //
//   //       final result = await authService.signInWithCredential(credential);
//   //       print('${result.user.displayName} is now logged in.');
//   //       print('${result.user.photoURL} is now logged in.');
//   //       return result.user;
//   //       break;
//   //     case FacebookLoginStatus.cancelledByUser:
//   //       print("The user cancelled the login");
//   //       return null;
//   //       break;
//   //     case FacebookLoginStatus.error:
//   //       print("There was an error");
//   //       return null;
//   //       break;
//   //     default:
//   //       return null;
//   //   }
//   // }
//   //  loginWithFB() async {
//   //   final result = await facebookLogin.logIn(['email']);
//   //
//   //   switch (result.status) {
//   //     case FacebookLoginStatus.loggedIn:
//   //
//   //       final token = result.accessToken.token;
//   //       // final AuthCredential credential =
//   //       //     FacebookAuthProvider.credential(token);
//   //       final graphResponse = await http.get(
//   //           Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token'));
//   //       final profile = JSON.jsonDecode(graphResponse.body);
//   //       print(profile['name']);
//   //       print(token);
//   //       // final res = await authService.signInWithCredential(credential);
//   //       return profile;
//   //
//   //     case FacebookLoginStatus.cancelledByUser:
//   //       break;
//   //     case FacebookLoginStatus.error:
//   //       break;
//   //   }
//   // }
//   //
//   logout() async {
//     facebookLogin.logOut();
//     authService.logout();
//     await FirebaseAuth.instance.signOut();
//     fb.logOut();
//     print('logged out of fb');
//   }
// }
