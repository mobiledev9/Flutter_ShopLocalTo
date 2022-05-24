import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/authentication/bloc.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shoplocalto/blocs/socialglLogin/socialglLogin_event.dart';
import 'package:shoplocalto/blocs/socialglLogin/socialglLogin_state.dart';

class SocialglLoginBloc extends Bloc<SocialglLoginEvent, SocialglLoginState> {
  final AuthBloc authBloc;

  SocialglLoginBloc({
    @required this.authBloc,
  }) : assert(authBloc != null);

  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

  @override
  SocialglLoginState get initialState => InitialSocialglLoginState();

  @override
  Stream<SocialglLoginState> mapEventToState(event) async* {
    ///Event for login
    if (event is OnSocialglLogin) {
      ///Notify loading to UI
      yield SocialglLoginLoading();

      await Future.delayed(Duration(seconds: 0));

      ///Fetch API
      final dynamic result = await Api.socialLogin(
        name:event.name,
        email: event.email,
        provider: event.provider,
        provider_id: event.provider_id,
        profile_image: event.profile_image, 
      );

      print('event.username at login bloc:${event.name}');
      print('event.username at login bloc:${event.email}');
      print('event.username at login bloc:${event.profile_image}');
      print('event.username at login bloc:${event.provider}');
      print('event.username at login bloc:${event.provider_id}');
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
print('update success');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          authBloc.add(AuthenticationSave(user));

          ///Notify loading to UI
          yield SocialglLoginSuccess();
        } catch (error) {
          ///Notify loading to UI
          yield SocialglLoginFail(error.toString());
        }
      } else {
        ///Notify loading to UI
        yield SocialglLoginFail('update failed');
      }
    }

    ///Event for logout
    if (event is AfterSocialglLogin) {
      yield AfterSocialglLoginLoading();
      try {
        ///Begin start AuthBloc Event OnProcessLogout
        authBloc.add(AuthenticationClear());

        ///Notify loading to UI
        yield AfterSocialglLoginSuccess();
      } catch (error) {
        ///Notify loading to UI
        yield AfterSocialglLoginFail(error.toString());
      }
    }
  }
}
