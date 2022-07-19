import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoplocalto/blocs/socialglLogin/socialglLogin_state.dart';
import 'package:shoplocalto/screens/forgot_password/forgot_password.dart';
import 'package:shoplocalto/screens/signup/signup.dart';
import 'package:shoplocalto/widgets/app_button.dart';
import '../../main_navigation.dart';
import 'authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/bloc.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/service/authService.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shoplocalto/main_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart' as prefix;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shoplocalto/socials/facebook.dart';
import 'package:shoplocalto/blocs/socialglLogin/socialglLogin_event.dart';
import 'package:shoplocalto/blocs/socialglLogin/socialglLogin_bloc.dart';


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

                            AuthBlocFacebook fb;
                            fb = AuthBlocFacebook();
                            UserCredential fbUser = await fb.signInWithFacebook();
                            if (fbUser != null)
                            {
                              print(fbUser.user.email);
                               setState(() {
                                 print(fbUser.user.displayName);
                                 print(fbUser.user.email);
                                 print(fbUser.user.uid,);
                                 print(fbUser.user.photoURL);

                                        _socialLogin.add(
                                          OnSocialLogin(
                                            name: fbUser.user.displayName,
                                            email: fbUser.user.email,
                                            provider: 'facebook',
                                            provider_id: fbUser.user.uid,
                                            profile_image:fbUser.user.photoURL,


                                          ),
                                        );

                                      });
                            } else {
                              print("Error occured");
                            }
                          },


                          loading: login is SocialLoginLoading,
                          disableTouchWhenLoading: true,
                          // backgroundColor: Theme.of(context).buttonColor,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 10),

                BlocBuilder<SocialglLoginBloc, SocialglLoginState>(
                  builder: (context, login) {
                    return BlocListener<SocialglLoginBloc, SocialglLoginState>(
                      listener: (context, loginListener) {
                        if (loginListener is SocialglLoginFail) {
                          _showErrorMessage(loginListener.message);
                        }
                        if (loginListener is SocialglLoginSuccess) {
                          Future.delayed(Duration(seconds: 1));

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

                          },
                          loading: login is SocialglLoginLoading,
                          disableTouchWhenLoading: true,
                          backgroundColor: Colors.red[900],
                        ),
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


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


  Stream<prefix.User> get currentUser => _authService.currentUser;


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
            child: Text('Api error Unable to login $message',
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


}
