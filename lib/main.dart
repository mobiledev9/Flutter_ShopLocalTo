import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoplocalto/app.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';

class AppDelegate extends BlocDelegate {
  ///Support Development
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    UtilLogger.log('BLOC EVENT', event);
  }

  ///Support Development
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    UtilLogger.log('BLOC TRANSITION', transition);
  }

  ///Support Development
  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    UtilLogger.log('BLOC ERROR', error);
  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Future.delayed(Duration(seconds: 1));
  BlocSupervisor.delegate = AppDelegate();
  runApp(App());
}
// @Override
// public void onCreate() {
//     super.onCreate();
//     FacebookSdk.sdkInitialize(getApplicationContext());
//     AppEventsLogger.activateApp(this);
// }
// AccessToken accessToken = AccessToken.getCurrentAccessToken();
// boolean isLoggedIn = accessToken != null && !accessToken.isExpired();

      
// LoginManager.getInstance().logInWithReadPermissions(this, Arrays.asList("public_profile"));