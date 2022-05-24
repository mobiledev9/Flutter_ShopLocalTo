
  
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:listar_flutter/service/authService.dart';


// class AuthBlocGoogle {
//   final _googleSignIn = GoogleSignIn(scopes: ['email']);
//   final AuthService _authService = AuthService();
//    Stream<User> get currentUser => _authService.currentUser;


// Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   // Create a new credential
//   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );
//  final result = await _authService.signInWithCredential(credential);
//       print('${result.user.displayName} is logged in.');
//       return result;
//   // Once signed in, return the UserCredential
//   // return await FirebaseAuth.instance.signInWithCredential(credential);
// }
//   logOut() {
//     _googleSignIn.signOut();
//     // _googleSignIn.disconnect();
// }
// }

  
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoplocalto/service/authService.dart';


// class AuthBlocGoogle {
//   final AuthService _authService = AuthService();
//   final googleSignin = GoogleSignIn(scopes: ['email']);

//   Stream<User> get currentUser => _authService.currentUser;

//   Future<User> loginGoogle() async {
//     try {
//       final GoogleSignInAccount googleUser = await googleSignin.signIn();
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//           idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

//       final result = await _authService.signInWithCredential(credential);
//       print('${result.user.displayName} is logged in.');
//       return result.user;
//     } catch (error) {
//       print(error);
//       return null;
//     }
//   }

//   logout() {
//     _authService.logout();
//     googleSignin.disconnect();
//   }
// }
class AuthBlocGoogle {
  // final _googleSignIn = GoogleSignIn(scopes: ['email']);
  final AuthService _authService = AuthService();
   Stream<User> get currentUser => _authService.currentUser;


// Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   // final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
//
//   // Obtain the auth details from the request
//   // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//   // Create a new credential
//   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );
//  final result = await _authService.signInWithCredential(credential);
//       print('${result.user.displayName} is logged in.');
//       return result;
//   // Once signed in, return the UserCredential
//   // return await FirebaseAuth.instance.signInWithCredential(credential);
// }
//   logOut() {
//     _googleSignIn.signOut();
//     _googleSignIn.disconnect();
//     print('logged out');
// }
}
