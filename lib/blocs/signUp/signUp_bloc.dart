import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/authentication/bloc.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shoplocalto/blocs/signUp/bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthBloc authBloc;

  SignUpBloc({
    @required this.authBloc,
  }) : assert(authBloc != null);

  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

  @override
  SignUpState get initialState => InitialSignUpState();

  @override
  Stream<SignUpState> mapEventToState(event) async* {
    ///Event for login
    if (event is OnSignUp) {
      ///Notify loading to UI
      yield SignUpLoading();

      await Future.delayed(Duration(seconds: 0));

      ///Fetch API
      final dynamic result = await Api.signup(
        username: event.username,
        email: event.email,
        phone: event.phone,
        password: event.password,
        location: event.location,
      );
       print('event.email at signup bloc:${event.email}');
      flutterSecureStorage.write(key: 'username1',value: event.username);
      flutterSecureStorage.write(key: 'email1', value: event.email);
      flutterSecureStorage.write(key: 'phone1', value: event.phone);
      flutterSecureStorage.write(key: 'location1', value: event.location);
      Future<String> value = flutterSecureStorage.read(key: 'email') ;
      print('/////////////////////////////');
      print(value.toString());

       @override
  // ignore: unused_element
  String toString() {
    return value.toString();
  }

      ///Case API fail but not have token
      if (result['status']!= "failed") {
        ///Login API success
        final UserModel user = UserModel.fromJson(result);
print('update success');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          authBloc.add(AuthenticationSignupSave(user));

          ///Notify loading to UI
          yield SignUpSuccess();
        } catch (error) {
          ///Notify loading to UI
          yield SignUpFail(error.toString());
        }
      } else {
        ///Notify loading to UI
        yield SignUpFail('update failed');
      }
    }

    ///Event for logout
    if (event is AfterSignUp) {
      yield AfterSignUpLoading();
      try {
        ///Begin start AuthBloc Event OnProcessLogout
        authBloc.add(AuthenticationClear());

        ///Notify loading to UI
        yield AfterSignUpSuccess();
      } catch (error) {
        ///Notify loading to UI
        yield AfterSignUpFail(error.toString());
      }
    }
  }
}
