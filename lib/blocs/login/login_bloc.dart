import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/authentication/bloc.dart';
import 'package:shoplocalto/blocs/login/bloc.dart';
import 'package:shoplocalto/models/model.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc authBloc;

  LoginBloc({
    @required this.authBloc,
  }) : assert(authBloc != null);

  @override
  LoginState get initialState => InitialLoginState();
  // GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    // final facebookLogin = new FacebookLogin();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Stream<LoginState> mapEventToState(event) async* {
    ///Event for login
    if (event is OnLogin) {
      ///Notify loading to UI
      yield LoginLoading();

      await Future.delayed(Duration(seconds: 1));

      ///Fetch API
      final dynamic result = await Api.login(
        email: event.email,
        password: event.password,
      );
      print('event.username at login bloc:${event.email}');
      print('event.password at login bloc:${event.password}');
      print('${result['message']}');
      print(state);
      dynamic token = result['access_token'];
      FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
      flutterSecureStorage.write(key: 'token', value: token);


      print('result is result access_token:$token');

      ///Case API fail but not have token
      if (result['access_token'] != null) {
        ///Login API success
        final UserModel user = UserModel.fromJson(result);
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          authBloc.add(AuthenticationSave(user));
          // authBloc.add(AuthenticationCheckDone(user));
          print(
              '..............................................................................$user');

          ///Notify loading to UI
          yield LoginSuccess();
        } catch (error) {
          ///Notify loading to UI
          yield LoginFail(error.toString());
        }
      } else {
        ///Notify loading to UI
        yield LoginFail(result['message']);

        print('login attempt result failed: $result');
      }
    }

    ///Event for logout
    if (event is OnLogout) {
       yield LogoutLoading();
    final dynamic res = await Api.logOut();
    FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    flutterSecureStorage.write(key: 'token', value: null);
    if (res['message'] != null) {
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          authBloc.add(AuthenticationClear());

          ///Notify loading to UI
          yield LogoutSuccess();
        } catch (error) {
          ///Notify loading to UI
          yield LogoutFail(error.toString());
        }
      } 
    print('???????????????????  ${FirebaseAuth.instance.currentUser}');
   if(FirebaseAuth.instance.currentUser != null) {
    await FirebaseAuth.instance.signOut();
    print('signeed out');
   }
    }
  }
}
