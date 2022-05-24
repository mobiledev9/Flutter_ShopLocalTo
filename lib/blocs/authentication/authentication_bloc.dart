import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/api/http_manager.dart';
import 'package:shoplocalto/blocs/authentication/bloc.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/utils/utils.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(event) async* {
    print('////////////AuthenticationState.............$event');
    if (event is AuthenticationCheck) {
      ///Notify state AuthenticationBeginCheck
      yield AuthenticationBeginCheck();
      final hasToken = UtilPreferences.containsKey(Preferences.user);
      print(
          '////////////AuthenticationState.......................................................$hasToken');
      if (hasToken) {
        ///Getting data from Storage
        final getUserPreferences = UtilPreferences.getString(
          Preferences.user,
        );
        final user = UserModel.fromJson(jsonDecode(getUserPreferences));
        print(
            '<<<<<<<<<AuthenticationState.......................................................${user.token}');
        httpManager.baseOptions.headers = {};
        httpManager.baseOptions.headers["Authorization"] =
            "Bearer " + user.token;
        await Future.delayed(Duration(seconds: 1));
        final ResultApiModel result = await Api.validateToken();

        ///Fetch api success
        if (result.success) {
          ///Set user
          Application.user = user;
          yield AuthenticationSuccess();
        } else {
          ///Fetch api fail
          ///
          ///Delete user when can't verify token
          await UtilPreferences.remove(Preferences.user);

          ///Notify loading to UI
          yield AuthenticationFail();
        }
      } else {
        ///Notify loading to UI
        yield AuthenticationFail();
      }
    }

    if (event is AuthenticationSave) {
      ///Save to Storage phone
      final savePreferences = await UtilPreferences.setString(
        Preferences.user,
        jsonEncode(event.user.toJson()),
      );
      final getUserPreferences = UtilPreferences.getString(
        Preferences.user,
      );
      final user = UserModel.fromJson(jsonDecode(getUserPreferences));
      httpManager.baseOptions.headers = {};

      httpManager.baseOptions.headers["Authorization"] = "Bearer " + user.token;
      print(httpManager.baseOptions.headers.toString());
      print(
          '.............................................ooooooooo.................................$user');

      ///Check result save user
      if (savePreferences) {
        ///Notify loading to UI
        yield AuthenticationSuccess();
      } else {
        final String message = "Cannot save user data to storage phone";
        throw Exception(message);
      }
    }

     if (event is AuthenticationSocialLoginSave) {
      ///Save to Storage phone
      final savePreferences = await UtilPreferences.setString(
        Preferences.user,
        jsonEncode(event.user.toJson()),
      );
      final getUserPreferences = UtilPreferences.getString(
        Preferences.user,
      );
      final user = UserModel.fromJson(jsonDecode(getUserPreferences));
      httpManager.baseOptions.headers = {};

      httpManager.baseOptions.headers["Authorization"] = "Bearer " + user.token;
      print(httpManager.baseOptions.headers.toString());
      print(
          '.............................................ooooooooo.................................$user');

      ///Check result save user
      if (savePreferences) {
        ///Notify loading to UI
        yield AuthenticationSuccess();
      } else {
        final String message = "Cannot save user data to storage phone";
        throw Exception(message);
      }
    }

    if (event is AuthenticationClear) {
      ///Delete user
      final deletePreferences = await UtilPreferences.remove(Preferences.user);

      ///Check result delete user
      if (deletePreferences) {
        yield AuthenticationFail();
      } else {
        final String message = "Cannot delete user data to storage phone";
        throw Exception(message);
      }
    }
    // if (event is AuthenticationSignupSave) {
    //   ///Save to Storage phone
    //   final savePreferences = await UtilPreferences.setString(
    //     Preferences.user,
    //     jsonEncode(event.user.toJson()),
    //   );
    //   // final getUserPreferences = UtilPreferences.getString(
    //   //   Preferences.user,
    //   // );
    //   // final user = UserModel.fromJson(jsonDecode(getUserPreferences));
    //   // httpManager.baseOptions.headers = {};

    //   // httpManager.baseOptions.headers["Authorization"] = "Bearer " + user.token;
    //   // print(httpManager.baseOptions.headers.toString());

    //   ///Check result save user
    //   if (savePreferences) {
    //     ///Notify loading to UI
    //     yield AuthenticationSignupSuccess();
    //   } else {
    //     final String message = "Cannot save user data to storage phone";
    //     throw Exception(message);
    //   }
    // }
    //  if (event is AuthenticationUpdateSave) {
    //   ///Save to Storage phone
    //   final savePreferences = await UtilPreferences.setString(
    //     Preferences.user,
    //     jsonEncode(event.user.toJson()),
    //   );
    //   ///Check result save user
    //   if (savePreferences) {
    //     ///Notify loading to UI
    //     yield AuthenticationUpdateSuccess();
    //   } else {
    //     final String message = "Cannot save user data to storage phone";
    //     throw Exception(message);
    //   }
    // }
    // if (event is AuthenticationResetSave) {
    //   ///Save to Storage phone
    //   final savePreferences = await UtilPreferences.setString(
    //     Preferences.user,
    //     jsonEncode(event.user.toJson()),
    //   );
    //   ///Check result save user
    //   if (savePreferences) {
    //     ///Notify loading to UI
    //     yield AuthenticationResetSuccess();
    //   } else {
    //     final String message = "Cannot save user data to storage phone";
    //     throw Exception(message);
    //   }
    // }
  }
}
