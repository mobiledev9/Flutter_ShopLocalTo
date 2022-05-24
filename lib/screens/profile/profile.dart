import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/bloc.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/screens/edit_profile/edit_profile.dart';
import 'package:shoplocalto/screens/home/home_controller.dart';
import 'package:shoplocalto/screens/page1/page1.dart';
import 'package:shoplocalto/screens/screen.dart';
import 'package:shoplocalto/screens/setting/setting.dart';
import 'package:shoplocalto/screens/signin/authentication.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoplocalto/socials/google.dart';
import 'package:shoplocalto/socials/facebook.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  LoginBloc _loginBloc;
  final HomeController _homeController =
  Get.put(HomeController());
  SocialglLoginBloc _socialglLogin;
 SocialLoginBloc _socialLogin;
  ProfilePageModel _profilePage;
  bool setProfile = true;
  String value;
  UserModel _userData;
  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  final _controller = RefreshController(initialRefresh: false);
  final _textController = TextEditingController();
  var loading = false;
  bool signout = false;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _socialglLogin = BlocProvider.of<SocialglLoginBloc>(context);
    _socialLogin = BlocProvider.of<SocialLoginBloc>(context);
    _loadProfile();
    super.initState();
  }

  // Fetch flutterSecureStoragedata
//   Future<dynamic> getLocation() async{
//   String name;
//     bool isLoggedIn = await flutterSecureStorage.containsKey(key:'username');
//     print('isloggedin:$isLoggedIn');
//     if(isLoggedIn){
//       String username = await flutterSecureStorage.read(key:'location');
//       name = username;
//       print('location:$username');
//     }
// final nullable = name.isEmpty?null:name;
// value=nullable;
// print('location2:$name');
//   }
  ///Fetch API
  // Future<void> _loadData() async {
  //   final ResultApiModel result = await Api.getProfile();
  //   if (result.success) {
  //     setState(() {
  //       _profilePage = ProfilePageModel.fromJson(result.data);
  //     });
  //   }
  // }
  Future<void> _loadProfile() async {
    setState(() {

      loading = true;
    });
    final UserModel result = await Api.getUserProfile();
    setState(() {
      _userData = result;
    });
    setState(() {

      loading = false;
    });
    return _userData;

  }

  ///On refresh list
  Future<void> _onRefresh() async {
    _loadProfile();
    await Future.delayed(Duration(seconds: 1));
    _controller.refreshCompleted();
  }



  ///Build profile UI
  Widget _buildProfile() {
    UserModel users = _userData == null ? null : _userData;
    return AppUserInfo(
      user: users,
      onPressed: () {},
      type: AppUserType.information,
    );
  }

  ///On navigation
  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: _homeController.fromnav == true.obs ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _homeController.fromnav = false.obs;
            Navigator.pop(context);
          },
        ) : Container(),
        title: Text(
          Translate.of(context).translate('profile'),
        ),
      ),
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: _onRefresh,
          controller: _controller,
          header: ClassicHeader(
            idleText: Translate.of(context).translate('pull_down_refresh'),
            refreshingText: Translate.of(context).translate('refreshing'),
            completeText: Translate.of(context).translate('refresh_completed'),
            releaseText: Translate.of(context).translate('release_to_refresh'),
            refreshingIcon: SizedBox(
              width: 16.0,
              height: 16.0,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          child: loading
              ? Center(child: CircularProgressIndicator())
              : ListView(
            padding: EdgeInsets.only(
              top: 15,
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: Column(
                  children: <Widget>[
                    _buildProfile(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    AppListTitle(
                      title: Translate.of(context).translate(
                        'edit_profile',
                      ),
                      trailing: RotatedBox(
                        quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfile(userModel: _userData,)),
                        );
                        // Navigator.pushNamed(context, Routes.editProfile,
                        //     arguments: _userData);
                      },
                    ),
                    AppListTitle(
                      title: Translate.of(context).translate(
                        'change_password',
                      ),
                      trailing: RotatedBox(
                        quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChangePassword()),
                        );
                        // _onNavigate(Routes.changePassword);
                      },
                    ),
                    AppListTitle(
                      title: Translate.of(context).translate('contact_us'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ContactUs()),
                        );
                        // _onNavigate(Routes.contactUs);
                      },
                      trailing: RotatedBox(
                        quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ),
                    AppListTitle(
                      title: Translate.of(context).translate(
                        'about_us',
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutUs()),
                        );
                        // _onNavigate(Routes.aboutUs);
                      },
                      trailing: RotatedBox(
                        quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ),
                    AppListTitle(
                      title: Translate.of(context).translate('setting'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Setting()),
                        );
                      },
                      trailing: RotatedBox(
                        quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      border: false,
                    ),
                  ],
                ),
              ),
              if(_userData.provider == null)
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 15,
                  bottom: 15,
                ),
                child:   BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, login) {
                    return BlocListener<LoginBloc, LoginState>(
                      listener: (context, loginListener) {
                        if(loginListener is LogoutFail ){
                          print('failed log out');
                        }
                        if (loginListener is LogoutSuccess ) {
                          setState(() {
                            // flutterSecureStorage.deleteAll();
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Page1()),
                          );
                        }


                      },
                      child: AppButton(
                        onPressed:() async {
                            _loginBloc.add(OnLogout());
                            // await Authentication.signOut(context: context);
                            // _socialglLogin.add(AfterSocialglLogin());

                        },
                        text: Translate.of(context).translate('sign_out'),
                        loading: login is LogoutLoading ,
                        disableTouchWhenLoading: true,
                      ),
                    );
                  },
                )
                //     :   BlocBuilder<SocialglLoginBloc, SocialglLoginState>(
                //   builder: (context, login) {
                //     return BlocListener<SocialglLoginBloc, SocialglLoginState>(
                //       listener: (context, loginListener) {
                //         if(loginListener is AfterSocialglLoginFail){
                //           print('failed log out');
                //         }
                //         if (loginListener is AfterSocialglLoginSuccess) {
                //           Navigator.pushNamed(context, Routes.page);
                //         }
                //       },
                //       child: AppButton(
                //         onPressed:() async {
                //           // _loginBloc.add(OnLogout());
                //           await Authentication.signOut(context: context);
                //           _socialglLogin.add(AfterSocialglLogin());
                //
                //         },
                //         text: Translate.of(context).translate('sign_out'),
                //         loading: login is AfterSocialLoginLoading,
                //         disableTouchWhenLoading: true,
                //       ),
                //     );
                //   },
                // ),
                
                // BlocBuilder<LoginBloc, LoginState>(
                //   builder: (context, login) {
                //     return AppButton(
                //       onPressed: () {
                //         _logout();
                //       },
                //       text: Translate.of(context).translate('sign_out'),
                //       loading: login is LoginLoading,
                //       disableTouchWhenLoading: true,
                //     );
                //   },
                // ),
              ),
              if(_userData.provider == 'google')
                Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 15,
                      bottom: 15,
                    ),
                    child:     BlocBuilder<SocialglLoginBloc, SocialglLoginState>(
                    builder: (context, login) {
                      return BlocListener<SocialglLoginBloc, SocialglLoginState>(
                        listener: (context, loginListener) {
                          if(loginListener is AfterSocialglLoginFail){
                            print('failed log out');
                          }
                          if (loginListener is AfterSocialglLoginSuccess) {
                            setState(() {
                              // flutterSecureStorage.deleteAll();
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Page1()),
                            );
                          }
                        },
                        child: AppButton(
                          onPressed:() async {
                            // _loginBloc.add(OnLogout());
                            await Authentication.signOut(context: context);
                            _socialglLogin.add(AfterSocialglLogin());

                          },
                          text: Translate.of(context).translate('sign_out'),
                          loading: login is AfterSocialglLoginLoading,
          disableTouchWhenLoading: true,
                        ),
                      );
                    },
                  ),

                  // BlocBuilder<LoginBloc, LoginState>(
                  //   builder: (context, login) {
                  //     return AppButton(
                  //       onPressed: () {
                  //         _logout();
                  //       },
                  //       text: Translate.of(context).translate('sign_out'),
                  //       loading: login is LoginLoading,
                  //       disableTouchWhenLoading: true,
                  //     );
                  //   },
                  // ),
                ),
              if(_userData.provider == 'facebook')
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 15,
                    bottom: 15,
                  ),
                  child:     BlocBuilder<SocialLoginBloc, SocialLoginState>(
                    builder: (context, login) {
                      return BlocListener<SocialLoginBloc, SocialLoginState>(
                        listener: (context, loginListener) {
                          if(loginListener is AfterSocialLoginFail){
                            print('failed log out');
                          }
                          if (loginListener is AfterSocialLoginSuccess) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Page1()),
                            );
                          }
                        },
                        child: AppButton(
                          onPressed:() async {
                            // _loginBloc.add(OnLogout());
                            // await AuthBlocFacebook().logout();
                            _socialLogin.add(AfterSocialLogin());

                          },
                          text: Translate.of(context).translate('sign_out'),
                          loading: login is AfterSocialLoginLoading,
                          disableTouchWhenLoading: true,
                        ),
                      );
                    },
                  ),

                  // BlocBuilder<LoginBloc, LoginState>(
                  //   builder: (context, login) {
                  //     return AppButton(
                  //       onPressed: () {
                  //         _logout();
                  //       },
                  //       text: Translate.of(context).translate('sign_out'),
                  //       loading: login is LoginLoading,
                  //       disableTouchWhenLoading: true,
                  //     );
                  //   },
                  // ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
