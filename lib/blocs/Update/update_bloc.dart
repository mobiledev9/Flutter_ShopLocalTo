import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/authentication/bloc.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shoplocalto/blocs/Update/bloc.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final AuthBloc authBloc;

  UpdateBloc({
    @required this.authBloc,
  }) : assert(authBloc != null);

  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

  @override
  UpdateState get initialState => InitialUpdateState();

  @override
  Stream<UpdateState> mapEventToState(event) async* {
    ///Event for login
    if (event is OnUpdate) {
      ///Notify loading to UI
      yield UpdateProfileLoading();

      await Future.delayed(Duration(seconds: 0));

      ///Fetch API
      final dynamic result = await Api.editProfile(
        username: event.username,
        email: event.email,
        address:event.address,
        info:event.info,
        website:event.website,
        phone: event.phone,
        image: event.image,
      );
       print('event.email at signup bloc:${event.email}');
      flutterSecureStorage.write(key: 'username',value: event.username);
      flutterSecureStorage.write(key: 'email', value: event.email);
      flutterSecureStorage.write(key: 'address', value: event.address);
      flutterSecureStorage.write(key: 'info', value: event.info);
      flutterSecureStorage.write(key: 'website', value: event.website);
      flutterSecureStorage.write(key: 'phone', value: event.phone);
      Future<String> value = flutterSecureStorage.read(key: 'email') ;
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
          authBloc.add(AuthenticationUpdateSave(user));

          ///Notify loading to UI
          yield UpdateSuccess();
        } catch (error) {
          ///Notify loading to UI
          yield UpdateFail(error.toString());
        }
      } else {
        ///Notify loading to UI
        yield UpdateFail('update failed');
      }
    }

    ///Event for logout
    if (event is AfterUpdate) {
      yield AfterUpdateLoading();
      try {
        ///Begin start AuthBloc Event OnProcessLogout
        authBloc.add(AuthenticationClear());

        ///Notify loading to UI
        yield AfterUpdateSuccess();
      } catch (error) {
        ///Notify loading to UI
        yield AfterUpdateFail(error.toString());
      }
    }
  }
}
