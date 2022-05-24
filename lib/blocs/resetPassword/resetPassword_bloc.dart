import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/authentication/bloc.dart';
import 'package:shoplocalto/blocs/resetPassword/bloc.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ResetBloc extends Bloc<ResetEvent, ResetState> {
  final AuthBloc authBloc;

  ResetBloc({
    @required this.authBloc,
  }) : assert(authBloc != null);

  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

  @override
  ResetState get initialState => InitialResetState();

  @override
  Stream<ResetState> mapEventToState(event) async* {
    ///Event for login
    if (event is OnReset) {
      ///Notify loading to UI
      yield ResetLoading();

      await Future.delayed(Duration(seconds: 1));

      ///Fetch API
      final dynamic result = await Api.editPassword(
        password: event.password,
        confirmpassword: event.confirmpassword,
      );
      flutterSecureStorage.write(key: 'password',value: event.password);
      flutterSecureStorage.write(key: 'password', value: event.confirmpassword);
      Future<String> value = flutterSecureStorage.read(key: 'password') ;
      print('/////////////////////////////');
      print(value.toString());

       @override
  // ignore: unused_element
  String toString() {
    return value.toString();
  }

      ///Case API fail but not have token
      if (result['status']!=null) {
        ///Login API success
        final UserModel user = UserModel.fromJson(result);
print('update success');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          authBloc.add(AuthenticationResetSave(user));

          ///Notify loading to UI
          yield ResetSuccess();
        } catch (error) {
          ///Notify loading to UI
          yield ResetFail(error.toString());
        }
      } else {
        ///Notify loading to UI
        yield ResetFail('update failed');
      }
    }

    ///Event for logout
    if (event is AfterReset) {
      yield AfterResetLoading();
      try {
        ///Begin start AuthBloc Event OnProcessLogout
        authBloc.add(AuthenticationClear());

        ///Notify loading to UI
        yield AfterResetSuccess();
      } catch (error) {
        ///Notify loading to UI
        yield AfterResetFail(error.toString());
      }
    }
  }
}
