import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/authentication/bloc.dart';
import 'package:shoplocalto/blocs/contactUs/contactUs_event.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../bloc.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final AuthBloc authBloc;

  ContactBloc({
    @required this.authBloc,
  }) : assert(authBloc != null);

  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

  @override
  ContactState get initialState => InitialContactState();

  @override
  Stream<ContactState> mapEventToState(event) async* {
    ///Event for login
    if (event is OnContact) {
      ///Notify loading to UI
      yield ContactLoading();

      await Future.delayed(Duration(seconds: 1));

      ///Fetch API
      final dynamic result = await Api.contactUs(
        username: event.name,
        email: event.email,
        comment: event.comment,
      );
      print(result['success']);
      print('event.email at signup bloc:${event.email}');
      flutterSecureStorage.write(key: 'username', value: event.name);
      flutterSecureStorage.write(key: 'email', value: event.email);
      Future<String> value = flutterSecureStorage.read(key: 'email');
      print('/////////////////////////////');
      print(value.toString());

      @override
      // ignore: unused_element
      String toString() {
        return value.toString();
      }

      ///Case API fail but not have token
      if (result['success'] != 'false') {
        ///Login API success
        final UserModel user = UserModel.fromJson(result);
        print('update success');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          authBloc.add(AuthenticationContactSave(user));

          ///Notify loading to UI
          yield ContactSuccess();
        } catch (error) {
          ///Notify loading to UI
          yield ContactFail(error.toString());
        }
      } else {
        ///Notify loading to UI
        yield ContactFail('update failed');
      }
    }

    ///Event for logout
    if (event is AfterContact) {
      yield AfterContactLoading();
      try {
        ///Begin start AuthBloc Event OnProcessLogout
        authBloc.add(AuthenticationClear());

        ///Notify loading to UI
        yield AfterContactSuccess();
      } catch (error) {
        ///Notify loading to UI
        yield AfterContactFail(error.toString());
      }
    }
  }
}
