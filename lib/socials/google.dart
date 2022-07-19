


  
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoplocalto/service/authService.dart';



class AuthBlocGoogle {

  final AuthService _authService = AuthService();
   Stream<User> get currentUser => _authService.currentUser;


}
