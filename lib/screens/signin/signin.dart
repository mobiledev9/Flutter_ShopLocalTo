import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shoplocalto/blocs/socialglLogin/socialglLogin_state.dart';
import 'package:shoplocalto/screens/forgot_password/forgot_password.dart';
import 'package:shoplocalto/screens/signup/signup.dart';
import 'package:shoplocalto/widgets/app_button.dart';
import '../../main_navigation.dart';
import 'authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/bloc.dart';
import 'package:shoplocalto/configs/config.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/service/authService.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shoplocalto/main_navigation.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as prefix;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:shoplocalto/socials/facebook.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoplocalto/blocs/socialglLogin/socialglLogin_event.dart';
import 'package:shoplocalto/blocs/socialglLogin/socialglLogin_bloc.dart';

import 'authentication.dart';

String prettyPrint(Map json) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class SignIn extends StatefulWidget {
  // final IconModel item;

  final location;
  final ProductDetailTabPageModel page;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  SignIn({Key key, this.page, this.location}) : super(key: key);

  @override
  _SignInState createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  final _textEmailController = TextEditingController();
  final _textPassController = TextEditingController();
  final _textLocationController = TextEditingController();
  final _focusID = FocusNode();
  final _focusPass = FocusNode();
  Map<String, dynamic> _userData;
  // AccessToken _accessToken;
  bool _checking = true;
  String _contactText = '';
  bool _isfbLoggedIn = false;
  Map userProfile;
  AuthBloc authBloc;
  LoginBloc _loginBloc;
  SocialLoginBloc _socialLogin;
  SocialglLoginBloc _socialglLogin;
  bool _showPassword = false;
  bool setlogin = true;

  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  // final _googleSignIn = GoogleSignIn(scopes: ['email']);
  // final facebookLogin = FacebookLogin();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _socialLogin = BlocProvider.of<SocialLoginBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
    _socialglLogin = BlocProvider.of<SocialglLoginBloc>(context);
    _textEmailController.text;
    _textPassController.text;
    _textLocationController.text = widget.location;
    // _successAlert(context);
    // _checkIfIsLogged();

    super.initState();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'] as List<dynamic>;
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>;
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>;
      if (name != null) {
        return name['displayName'] as String;
      }
    }
    return null;
  }
  // Future<void> _checkIfIsLogged() async {
  //   final accessToken = await FacebookAuth.instance.accessToken;
  //   setState(() {
  //     _checking = false;
  //   });
  //   if (accessToken != null) {
  //     print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
  //     // now you can call to  FacebookAuth.instance.getUserData();
  //     final userData = await FacebookAuth.instance.getUserData();
  //     // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
  //     _accessToken = accessToken;
  //     setState(() {
  //       _userData = userData;
  //     });
  //   }
  // }
  // void _printCredentials() {
  //   print(
  // prettyPrint(_accessToken.toJson()),
  // );
  // }

  // Future<void> _login() async {
  //   // final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
  //
  //   // loginBehavior is only supported for Android devices, for ios it will be ignored
  //   final result = await FacebookAuth.instance.login(
  //     permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
  //     loginBehavior: LoginBehavior.dialogOnly // (only android) show an authentication dialog instead of redirecting to facebook app
  //   );
  //
  //   if (result.status == LoginStatus.success) {
  //
  //     _accessToken = result.accessToken;
  //     _printCredentials();
  //     // get the user data
  //     // by default we get the userId, email,name and picture
  //     final userData = await FacebookAuth.instance.getUserData();
  //     // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
  //     _userData = userData;
  //     if (userData != null)
  //     {
  //       print(_userData.entries);
  //       // setState(() {
  //       //   print(fbUser.user.displayName);
  //       //   print(fbUser.user.email);
  //       //   print(fbUser.user.uid,);
  //       //   print(fbUser.user.photoURL);
  //       //
  //       //   _socialLogin.add(
  //       //     OnSocialLogin(
  //       //       name: fbUser.user.displayName,
  //       //       email: fbUser.user.email,
  //       //       provider: 'facebook',
  //       //       provider_id: fbUser.user.uid,
  //       //       profile_image:fbUser.user.photoURL,
  //       //
  //       //
  //       //     ),
  //       //   );
  //       //   // print('email:${_textEmailController.text}');
  //       //   // print('password:${_textPassController.text}');
  //       //   // print(widget.location);
  //       // });
  //     } else {
  //       print("Error occured");
  //     }
  //   } else {
  //     print(result.status);
  //     print(result.message);
  //   }
  //
  //   setState(() {
  //     _checking = false;
  //   });
  // }

  // Future<void> _logOut() async {
  //   await FacebookAuth.instance.logOut();
  //   _accessToken = null;
  //   _userData = null;
  //   setState(() {});
  // }

  // Future<void> _checkIfIsLogged() async {
  //   final accessToken = await FacebookAuth.instance.accessToken;
  //   setState(() {
  //     _checking = false;
  //   });
  //   if (accessToken != null) {
  //     print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
  //     // now you can call to  FacebookAuth.instance.getUserData();
  //     final userData = await FacebookAuth.instance.getUserData();
  //     // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
  //     _accessToken = accessToken;
  //     setState(() {
  //       _userData = userData;
  //     });
  //   }
  // }
  // void _printCredentials() {
  //   print(
  //     prettyPrint(_accessToken.toJson()),
  //   );
  // }
  // Future<void> _login() async {
  //   final LoginResult result = await FacebookAuth.instance.login(
  //       loginBehavior: LoginBehavior.webOnly
  //   ); // by default we request the email and the public profile
  //
  //   // loginBehavior is only supported for Android devices, for ios it will be ignored
  //   // final result = await FacebookAuth.instance.login(
  //   //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
  //   //   loginBehavior: LoginBehavior
  //   //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
  //   // );
  //   final status = await Permission.appTrackingTransparency.request();
  //   if (status == PermissionStatus.granted) {
  //     await FacebookAuth.i.autoLogAppEventsEnabled(true);
  //     print("isAutoLogAppEventsEnabled:: ${await FacebookAuth.i.isAutoLogAppEventsEnabled}");
  //   }
  //   if (result.status == LoginStatus.success) {
  //     _accessToken = result.accessToken;
  //     _printCredentials();
  //     // get the user data
  //     // by default we get the userId, email,name and picture
  //     final userData = await FacebookAuth.instance.getUserData();
  //     // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
  //     _userData = userData;
  //     _socialLogin.add(
  //       OnSocialLogin(
  //
  //         name: result.status.name,
  //         email: 'developer.designer18@gmail.com',
  //         provider: 'facebook',
  //         provider_id: result.accessToken.userId,
  //
  //
  //
  //       ),
  //     );
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => MainNavigation(),
  //         ));
  //   } else {
  //     print(result.status);
  //     print(result.message);
  //   }
  //
  //   setState(() {
  //     _checking = false;
  //   });
  // }
  //
  // Future<void> _logOut() async {
  //   await FacebookAuth.instance.logOut();
  //   _accessToken = null;
  //   _userData = null;
  //   setState(() {});
  // }
  ///On navigate forgot password
  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPassword()),
    );
  }

  ///On navigate sign up
  void _signUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    );
  }

  ///On login
  // void _login() {
  //   UtilOther.hiddenKeyboard(context);
  //   setState(() {
  //     _validID = UtilValidator.validate(data: _textIDController.text);
  //     _validPass = UtilValidator.validate(data: _textPassController.text);
  //     _loginBloc.add(
  //       OnLogin(
  //         username: _validID,
  //         password: _validPass,
  //       ),
  //     );

  //     print(_validPass);
  //   });
  //   if (_validID == null && _validPass == null) {
  //     _loginBloc.add(
  //       OnLogin(
  //         username: _textIDController.text,
  //         password: _textPassController.text,
  //       ),
  //     );
  //     print(_validPass);
  //   }
  // }

  ///On show message fail
  Future<void> _showMessage() async {
    return Alert(
        context: context,
        title: "Login Failed",
        style: AlertStyle(
          titleStyle: TextStyle(color: Theme.of(context).primaryColor),
        ),
        content: Column(children: <Widget>[
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Text('Invalid Username or Password',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1),

            // previous search by sanjana search.txt
          ),
        ]),
        buttons: [
          DialogButton(
            color: Theme.of(context).buttonColor,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SignIn(location: _textLocationController.text),
                )),
            child: Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void _performLogin() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    print('login attempt: $username with $password');
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('Login'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(Images.ShopLocalTOLogo, width: 250, height: 150),
                SizedBox(height: 10),
                //         TextFormField(controller: _usernameController,),
                // TextFormField(controller: _passwordController, obscureText: true,),
                // RaisedButton(
                //   onPressed: _performLogin,
                //   child: Text('Login'),
                // ),
                AppTextInput(
                  hintText: Translate.of(context).translate('email'),
                  // errorText: _validID != null
                  //     ? Translate.of(context).translate(_validID)
                  //     : null,
                  icon: Icon(Icons.clear),
                  controller: _textEmailController,
                  focusNode: _focusID,
                  textInputAction: TextInputAction.next,
                  // onChanged: (text) {
                  //   setState(() {
                  //     _validID = UtilValidator.validate(
                  //       data: _textIDController.text,
                  //     );
                  //   });
                  // },
                  // onSubmitted: (text) {
                  //   UtilOther.fieldFocusChange(context, _focusID, _focusPass);
                  // },
                  onTapIcon: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    _textEmailController.clear();
                  },

                  keyboardType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                AppTextInput(
                  hintText: Translate.of(context).translate('password'),
                  // errorText: _validPass != null
                  //     ? Translate.of(context).translate(_validPass)
                  //     : null,
                  textInputAction: TextInputAction.done,
                  // onChanged: (text) {
                  //   setState(() {
                  //     _validPass = UtilValidator.validate(
                  //       data: _textPassController.text,
                  //     );
                  //   });
                  // },
                  // onSubmitted: (text) {
                  //   UtilOther.fieldFocusChange(context, _focusID, _focusPass);
                  //   // _login();
                  //   print(setlogin);
                  // },
                  onTapIcon: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  obscureText: !_showPassword,
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  controller: _textPassController,
                  focusNode: _focusPass,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, login) {
                    return BlocListener<LoginBloc, LoginState>(
                      listener: (context, loginListener) {
                        if (loginListener is LoginFail) {
                          _showMessage();
                        }
                        if (loginListener is LoginSuccess) {
                          Future.delayed(Duration(seconds: 1));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => MainNavigation(),
                          //     ));
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => MainNavigation()),
                              (route) => false);
                        }
                      },
                      child: AppButton(
                        onPressed: () {
                          setState(() {
                            _loginBloc.add(
                              OnLogin(
                                email: _textEmailController.text,
                                password: _textPassController.text,
                              ),
                            );
                            print('email:${_textEmailController.text}');
                            print('password:${_textPassController.text}');
                            print(widget.location);
                          });
                          // _login();

                          print(setlogin);
                        },
                        text: Translate.of(context).translate('Login'),
                        loading: login is LoginLoading,
                        disableTouchWhenLoading: true,
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an Account Yet?"),
                      Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                              onTap: _signUp,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                    Translate.of(context).translate('sign_up'),
                                    style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 15)),
                              ))),
                    ]),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Translate.of(context)
                            .translate('Forgot Your Password?'),
                      ),
                      Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                              onTap: _forgotPassword,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  Translate.of(context).translate('Reset'),
                                  style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: 15),
                                ),
                              ))),
                    ],
                  ),
                ),
                Text(
                  Translate.of(context).translate('Or'),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                // ************************WORKING BUT ROUTES TO SOCIALPROFILE PAGE***********
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * .75,
                //   height: 45,
                //   child: SignInButtonBuilder(
                //     text: 'Sign in with Facebook',
                //     image: Padding(
                //       padding: const EdgeInsets.only(
                //           left: 0, right: 5, top: 8, bottom: 8),
                //       child: Image.asset('assets/socialicons/facebook.png'),
                //     ),
                //     onPressed: () async {
                //       AuthBlocFacebook fb;
                //       fb = AuthBlocFacebook();
                //       prefix.User fbUser = await fb.loginFacebook();
                //       if (fbUser != null) {
                //         print(fbUser.email);
                //          Navigator.of(context).pushReplacement(MaterialPageRoute(
                //             builder: (context) => SocialProfile(fbUser.photoURL,
                //                 fbUser.displayName, fbUser.email,fbUser.uid,
                //                 'facebook',)));
                //       } else {
                //         print("Error occured");
                //       }
                //     },
                //     backgroundColor: Theme.of(context).buttonColor,
                //   ),
                // ),
                // *******************WORKING ********************
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * .75,
                //   height: 45,
                //   child: SignInButtonBuilder(
                //     text: 'Sign in with Facebook',
                //     image: Padding(
                //       padding: const EdgeInsets.only(
                //           left: 0, right: 5, top: 8, bottom: 8),
                //       child: Image.asset('assets/socialicons/facebook.png'),
                //     ),
                //     onPressed: _loginWithFB,
                //     backgroundColor: Theme.of(context).buttonColor,
                //   ),
                // ),
                BlocBuilder<SocialLoginBloc, SocialLoginState>(
                  builder: (context, login) {
                    return BlocListener<SocialLoginBloc, SocialLoginState>(
                      listener: (context, loginListener) async {
                        if (loginListener is SocialLoginFail) {
                          _showErrorMessage(loginListener.message);
                        }
                        if (loginListener is SocialLoginSuccess) {
                          await Future.delayed(Duration(seconds: 1));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => MainNavigation(),
                          //     ));
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => MainNavigation()),
                              (route) => false);
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        height: 45,
                        child: AppButton(
                          text: 'Sign in with Facebook',
                          image: Image.asset('assets/socialicons/facebook.png'),
                          onPressed: () async {
                            _loginwithFacebooksat16apr();
                            // _login();
                            // AuthBlocFacebook fb;
                            // fb = AuthBlocFacebook();
                            // UserCredential fbUser = await fb.signInWithFacebook();
                            // if (fbUser != null)
                            // {
                            //   print(fbUser.user.email);
                            //    setState(() {
                            //      print(fbUser.user.displayName);
                            //      print(fbUser.user.email);
                            //      print(fbUser.user.uid,);
                            //      print(fbUser.user.photoURL);
                            //
                            //             _socialLogin.add(
                            //               OnSocialLogin(
                            //                 name: fbUser.user.displayName,
                            //                 email: fbUser.user.email,
                            //                 provider: 'facebook',
                            //                 provider_id: fbUser.user.uid,
                            //                 profile_image:fbUser.user.photoURL,
                            //
                            //
                            //               ),
                            //             );
                            //             // print('email:${_textEmailController.text}');
                            //             // print('password:${_textPassController.text}');
                            //             // print(widget.location);
                            //           });
                            // } else {
                            //   print("Error occured");
                            // }
                          },

                          // async {
                          //   final result = await facebookLogin.logIn(['email']);
                          //   switch (result.status) {
                          //     case FacebookLoginStatus.loggedIn:
                          //       final token = result.accessToken.token;
                          //       final graphResponse = await http.get(
                          //           'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
                          //       final profile =
                          //           JSON.jsonDecode(graphResponse.body);
                          //       print(profile['name']);
                          //       print(token);
                          //       if(FirebaseAuth.instance.currentUser != null) {
                          //       setState(() {
                          //         _socialLogin.add(
                          //           OnSocialLogin(
                          //             email: profile['email'],
                          //             name: profile['name'],
                          //             profile_image: profile['picture']['data']
                          //                 ['url'],
                          //             provider: 'facebook',
                          //             provider_id: profile['id'],
                          //           ),
                          //         );
                          //         print('email:${_textEmailController.text}');
                          //         print('password:${_textPassController.text}');
                          //         print(widget.location);
                          //       });
                          //       }
                          //       break;
                          //     case FacebookLoginStatus.cancelledByUser:
                          //       setState(() => _isfbLoggedIn = false);
                          //       break;
                          //     case FacebookLoginStatus.error:
                          //       setState(() => _isfbLoggedIn = false);
                          //       break;
                          //   }
                          // },
                          loading: login is SocialLoginLoading,
                          disableTouchWhenLoading: true,
                          // backgroundColor: Theme.of(context).buttonColor,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 10),
                // FutureBuilder(
                //   future: Authentication.initializeFirebase(context: context),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasError) {
                //       return Text('Error initializing Firebase');
                //     } else if (snapshot.connectionState == ConnectionState.done) {
                //       return GoogleSignInButton();
                //     }
                //     return CircularProgressIndicator(
                //     );
                //   },
                // ),
                BlocBuilder<SocialglLoginBloc, SocialglLoginState>(
                  builder: (context, login) {
                    return BlocListener<SocialglLoginBloc, SocialglLoginState>(
                      listener: (context, loginListener) {
                        if (loginListener is SocialglLoginFail) {
                          _showErrorMessage(loginListener.message);
                        }
                        if (loginListener is SocialglLoginSuccess) {
                          Future.delayed(Duration(seconds: 1));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => MainNavigation(),
                          //     ));
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => MainNavigation()),
                              (route) => false);
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        height: 45,
                        child: AppButton(
                          text: 'Sign in with Google',
                          image: Image.asset('assets/socialicons/google.png'),
                          onPressed: () async {
                            // setState(() {
                            //   _isSigningIn = true;
                            // });
                            User user = await Authentication.signInWithGoogle(
                                context: context);

                            // setState(() {
                            //   _isSigningIn = false;
                            // });

                            // if (user != null) {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => MainNavigation(),
                            //       ));
                            // }
                            if (user != null) {
                              setState(() {
                                _socialglLogin.add(
                                  OnSocialglLogin(
                                    email: user.email,
                                    name: user.displayName,
                                    profile_image: user.photoURL,
                                    provider: 'google',
                                    provider_id: user.uid,
                                  ),
                                );
                                print('email:${_textEmailController.text}');
                                print('password:${_textPassController.text}');
                                print(widget.location);
                              });
                              // return prefix.FirebaseAuth.instance
                              // .signInWithCredential(user);
                            }
                            // final GoogleSignInAccount user = _currentUser;

                            // final GoogleSignInAccount googleUser =
                            //     await GoogleSignIn().signIn();
                            // await _googleSignIn.signIn();
                            // final GoogleSignInAuthentication googleAuth =
                            //     await googleUser.authentication;
                            // final prefix.GoogleAuthCredential credential =
                            //     prefix.GoogleAuthProvider.credential(
                            //   accessToken: googleAuth.accessToken,
                            //   idToken: googleAuth.idToken,
                            // );
                            // await Future.delayed(Duration(seconds: 1));
                            // print(googleUser);
                            // if(credential != null){
                            // setState(() {
                            //   _socialglLogin.add(
                            //     OnSocialglLogin(
                            //       email: _googleSignIn.currentUser.email,
                            //       name: _googleSignIn.currentUser.displayName,
                            //       profile_image: _googleSignIn.currentUser.photoUrl,
                            //       provider: 'google',
                            //       provider_id: _googleSignIn.currentUser.id,
                            //     ),
                            //   );
                            //   print('email:${_textEmailController.text}');
                            //   print('password:${_textPassController.text}');
                            //   print(widget.location);
                            // });
                            // return prefix.FirebaseAuth.instance
                            //     .signInWithCredential(credential);
                            // }
                          },
                          loading: login is SocialglLoginLoading,
                          disableTouchWhenLoading: true,
                          backgroundColor: Colors.red[900],
                        ),
                      ),
                    );
                  },
                ),
                // *******************WORKING FOR SIR********************
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * .75,
                //   height: 45,
                //   child: SignInButtonBuilder(
                //     text: 'Sign in with Google',
                //     image: Padding(
                //       padding: const EdgeInsets.only(
                //           left: 0, right: 5, top: 8, bottom: 8),
                //       child: Image.asset('assets/socialicons/google.png'),
                //     ),
                //     onPressed:loginGoogle,
                //     backgroundColor: Colors.red[900],
                //   ),
                // )
                // ************************WORKING BUT ROUTES TO SOCIALPROFILE PAGE***********
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * .75,
                //   height: 45,
                //   child: SignInButtonBuilder(
                //     text: 'Sign in with Google',
                //     image: Padding(
                //       padding: const EdgeInsets.only(
                //           left: 0, right: 5, top: 8, bottom: 8),
                //       child: Image.asset('assets/socialicons/google.png'),
                //     ),
                //     onPressed: () async {
                //       AuthBlocGoogle gu = AuthBlocGoogle();
                //       // gu.logOut();
                //       prefix.UserCredential googleUser = await gu.signInWithGoogle();
                //       if (googleUser != null) {
                //         Navigator.of(context).pushReplacement(MaterialPageRoute(
                //             builder: (context) => SocialProfile(
                //                 googleUser.user.photoURL,
                //                 googleUser.user.displayName,
                //                 googleUser.user.email,
                //                 googleUser.user.uid,
                //                 'google',)));
                //       } else {
                //         print("Error occured");
                //         _showMessage();
                //       }
                //     },
                //     backgroundColor: Colors.red[900],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // *******************************************GOOGLE***OLD*********************
  // loginGoogle() async {
  //   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  //   await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;
  //
  //   // Create a new credential
  //   final prefix.GoogleAuthCredential credential =
  //       prefix.GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   print(googleUser);
  //   setState(() {
  //     _isLoggedIn = true;
  //   });
  //   if (_isLoggedIn == true) {
  //     final dynamic result = await Api.socialLogin(
  //         email: _googleSignIn.currentUser.email,
  //         name: _googleSignIn.currentUser.displayName,
  //         profile_image: _googleSignIn.currentUser.photoUrl,
  //         provider: 'google',
  //         provider_id: _googleSignIn.currentUser.id);
  //     print(result['access_token']);
  //     dynamic token = result['access_token'];
  //     flutterSecureStorage.write(key: 'token', value: token);
  //     print(flutterSecureStorage.read(key: 'token'));
  //     print(result);
  //     log(token.toString());
  //     print(_googleSignIn.currentUser.email);
  //     print(_googleSignIn.currentUser.displayName);
  //     print(_googleSignIn.currentUser.photoUrl);
  //     print(_googleSignIn.currentUser.id);
  //     if (result['access_token'] == null) {
  //       await Future.delayed(Duration(seconds: 1));
  //       _showErrorMessage(result['error']);
  //     }
  //     if (token != null) {
  //       final UserModel user = UserModel.fromJson(result);
  //       authBloc.add(AuthenticationSave(user));
  //       print("this is token $token");
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => MainNavigation(),
  //           ));
  //     }
  //   }
  //   return prefix.FirebaseAuth.instance.signInWithCredential(credential);
  //   // Once signed in, return the UserCredential
  // }
  //
  // logOutGoogle() {
  //   _googleSignIn.signOut();
  //   setState(() {
  //     _isLoggedIn = false;
  //   });
  // }

  // ************************************FACEBOOK***OLD*************************
  // loginFaceBook() async {
  //   final result = await facebookLogin.logIn(['email']);
  //
  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final token = result.accessToken.token;
  //       final graphResponse = await http.get(Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token'));
  //       final profile = JSON.jsonDecode(graphResponse.body);
  //       print(profile['name']);
  //       print(token);
  //       setState(() {
  //         userProfile = profile;
  //         _isfbLoggedIn = true;
  //       });
  //       if (_isfbLoggedIn == true) {
  //         final dynamic result = await Api.socialLogin(
  //           email: userProfile['email'],
  //           name: userProfile['name'],
  //           profile_image: userProfile['picture']['data']['url'],
  //           provider: 'facebook',
  //           provider_id: userProfile['id'],
  //         );
  //         print(result['access_token']);
  //         print(userProfile['email']);
  //         print(userProfile['name']);
  //         print(userProfile['picture']['data']['url']);
  //         print(userProfile['id']);
  //         dynamic token = result['access_token'];
  //         flutterSecureStorage.write(key: 'token', value: token);
  //         print(flutterSecureStorage.read(key: 'token'));
  //         print(result);
  //
  //         if (result['access_token'] == null) {
  //           await Future.delayed(Duration(seconds: 1));
  //           _showErrorMessage(result['error']);
  //         }
  //         if (token != null) {
  //           final UserModel user = UserModel.fromJson(result);
  //           authBloc.add(AuthenticationSave(user));
  //           print("this is token $token");
  //           await Future.delayed(Duration(seconds: 2));
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => MainNavigation(),
  //               ));
  //         }
  //       }
  //
  //       break;
  //
  //     case FacebookLoginStatus.cancelledByUser:
  //       setState(() => _isfbLoggedIn = false);
  //       break;
  //     case FacebookLoginStatus.error:
  //       setState(() => _isfbLoggedIn = false);
  //       break;
  //   }
  // }

  // _loginWithFB() async {
  //   final result = await facebookLogin.logIn(['email']);
  //
  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final token = result.accessToken.token;
  //       final graphResponse = await http.get(
  //           Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token'));
  //       final profile = JSON.jsonDecode(graphResponse.body);
  //       print(profile['name']);
  //       print(token);
  //       setState(() {
  //         userProfile = profile;
  //         _isfbLoggedIn = true;
  //       });
  //       if (_isfbLoggedIn == true) {
  //         final dynamic result = await Api.socialLogin(
  //           email: userProfile['email'],
  //           name: userProfile['name'],
  //           profile_image: userProfile['picture']['data']['url'],
  //           provider: 'facebook',
  //           provider_id: userProfile['id'],
  //         );
  //         print(result['access_token']);
  //         print(userProfile['email']);
  //         print(userProfile['name']);
  //         print(userProfile['picture']['data']['url']);
  //         print(userProfile['id']);
  //         dynamic token = result['access_token'];
  //         flutterSecureStorage.write(key: 'token', value: token);
  //         print(flutterSecureStorage.read(key: 'token'));
  //         print(result);
  //
  //         if (result['access_token'] == null) {
  //           await Future.delayed(Duration(seconds: 1));
  //         }
  //         if (token != null) {
  //             _showfbLogin();
  //           log('facebook login done');
  //           final UserModel user = UserModel.fromJson(result);
  //           authBloc.add(AuthenticationSocialLoginSave(user));
  //           print("this is token $token");
  //           await Future.delayed(Duration(seconds: 2));
  //         }
  //       }
  //
  //       break;
  //
  //     case FacebookLoginStatus.cancelledByUser:
  //       setState(() => _isfbLoggedIn = false);
  //       break;
  //     case FacebookLoginStatus.error:
  //       setState(() => _isfbLoggedIn = false);
  //       break;
  //   }
  // }

  Future<void> _showfbLogin() async {
    if (_isfbLoggedIn == true) {
      return Alert(
          context: context,
          title: "facebook login Success",
          style: AlertStyle(
            titleStyle: TextStyle(color: Theme.of(context).primaryColor),
          ),
          content: Column(children: <Widget>[
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    userProfile["picture"]["data"]["url"],
                    height: 50.0,
                    width: 50.0,
                  ),
                  Text(userProfile["name"]),
                ],
              ),
              // previous search by sanjana search.txt
            ),
          ]),
          buttons: [
            DialogButton(
              color: Theme.of(context).buttonColor,
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => MainNavigation(),
                //     ));
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => MainNavigation()),
                    (route) => false);
              },
              child: Text(
                "LogIn",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            DialogButton(
              color: Theme.of(context).buttonColor,
              onPressed: () async {
                await Api.logOut();
                // facebookLogin.logOut();
                setState(() {
                  _isfbLoggedIn = false;
                });
                // Navigator.pushNamed(context, Routes.signIn);
              },
              child: Text(
                "LogOut",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }
    return Container();
  }

  // logoutFacebook() {
  //   facebookLogin.logOut();
  //   setState(() {
  //     _isfbLoggedIn = false;
  //   });
  // }

// ***********************NEW***********************
//   loginWithFB() async {
//     final result = await facebookLogin.logIn(['email']);
//
//     switch (result.status) {
//       case FacebookLoginStatus.loggedIn:
//         final token = result.accessToken.token;
//         // final AuthCredential credential =
//         //     FacebookAuthProvider.credential(token);
//         final graphResponse = await http.get(
//             Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token'));
//         final profile = JSON.jsonDecode(graphResponse.body);
//         print(profile['name']);
//         print(token);
//         // final res = await authService.signInWithCredential(credential);
//         return profile;
//
//       case FacebookLoginStatus.cancelledByUser:
//         break;
//       case FacebookLoginStatus.error:
//         break;
//     }
//   }

  // ************************NEW************************
  Stream<prefix.User> get currentUser => _authService.currentUser;
  // Future<prefix.UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;
  //
  //   // Create a new credential
  //   final prefix.GoogleAuthCredential credential =
  //       prefix.GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   final result = await _authService.signInWithCredential(credential);
  //   print('${result.user.displayName} is logged in.');
  //   return result;
  //   // Once signed in, return the UserCredential
  //   // return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
  //
  // logOut() {
  //   _googleSignIn.signOut();
  //   // _googleSignIn.disconnect();
  // }

  Future<void> _showErrorMessage(String message) async {
    return Alert(
        context: context,
        title: "Login Failed",
        style: AlertStyle(
          titleStyle: TextStyle(color: Theme.of(context).primaryColor),
        ),
        content: Column(children: <Widget>[
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Text('Api error Unable to login$message',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1),

            // previous search by sanjana search.txt
          ),
        ]),
        buttons: [
          DialogButton(
            color: Theme.of(context).buttonColor,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                )),
            child: Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void _loginwithFacebooksat16apr() async {
    try {
      final facebookLoginResult = await FacebookAuth.instance
          .login(loginBehavior: LoginBehavior.dialogOnly);

      final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      await FirebaseFirestore.instance.collection('user').add({
        'email': userData['email'],
        'imageUrl': userData['picture']['data']['url'],
        'name': userData['name'],
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => MainNavigation()),
          (route) => false);
      // Navigator.push(
      //     context,
      //    );

    } on FirebaseAuthException catch (e) {
      var content = '';
      switch (e.code) {
        case 'account-exists-with-different-credential':
          content = 'This account exists with a different sign in provider';
          break;
        case 'invalid-credential':
          content = 'Unknown error has occurred';
          break;
        case 'operation-not-allowed':
          content = 'This operation is not allowed';
          break;
        case 'user-disabled':
          content = 'This user you tried to log into is disabled';
          break;
        case 'user-not-found':
          content = 'This user you tried to log into was not found';
          break;
      }

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Log in with facebook failed'),
                content: Text(content),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok'))
                ],
              ));
    } finally {}
  }
}
