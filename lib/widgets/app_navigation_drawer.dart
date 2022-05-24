import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shoplocalto/screens/message/message.dart';
import 'package:shoplocalto/screens/notification/notification.dart';
import 'package:shoplocalto/screens/profile/profile.dart';
import '../blocs/login/login_bloc.dart';
import '../blocs/login/login_event.dart';
import '../blocs/login/login_state.dart';
import '../blocs/socialglLogin/socialglLogin_bloc.dart';
import '../blocs/socialglLogin/socialglLogin_event.dart';
import '../blocs/socialglLogin/socialglLogin_state.dart';
import '../models/model_user.dart';
import '../screens/home/home_controller.dart';
import '../screens/page1/page1.dart';
import '../screens/signin/authentication.dart';
import '../screens/wishlist/wishlist.dart';
import '../utils/translate.dart';
import 'app_button.dart';
import 'app_user_info.dart';

class NavigationDrawer extends StatefulWidget {
  final UserModel userData;
  const NavigationDrawer({Key key, this.userData}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final HomeController _homeController = Get.put(HomeController());
  LoginBloc _loginBloc;
  SocialglLoginBloc _socialglLogin;
  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _socialglLogin = BlocProvider.of<SocialglLoginBloc>(context);

    super.initState();
  }

  Widget _buildProfile() {
    UserModel users = widget.userData == null ? null : widget.userData;
    return AppUserInfo(
      user: users,
      onPressed: () {},
      type: AppUserType.information,
    );
  }

  @override
  Widget build(BuildContext context) {
    int id = widget.userData == null ? null : widget.userData.neighbourhoodid;
    final size = MediaQuery.of(context).size;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01, horizontal: size.width * 0.04),
              child: _buildProfile(),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(
            //         vertical: size.height * 0.01,
            //         horizontal: size.width * 0.04),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Icon(Icons.home),
            //         SizedBox(
            //           width: size.width * 0.03,
            //         ),
            //         Text('Home'),
            //       ],
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _homeController.fromnav = true.obs;
                });
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => WishList()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.bookmark),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text('Wishlist'),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _homeController.fromnav = true.obs;
                });
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MessageList()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.message),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text('Message'),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _homeController.fromnav = true.obs;
                });
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationList()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.home),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text('Notification'),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _homeController.fromnav = true.obs;
                });
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.account_circle),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text('Account'),
                  ],
                ),
              ),
            ),
            if (widget.userData.provider == null)
              Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 15,
                    bottom: 15,
                  ),
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, login) {
                      return BlocListener<LoginBloc, LoginState>(
                        listener: (context, loginListener) {
                          if (loginListener is LogoutFail) {
                            print('failed log out');
                          }
                          if (loginListener is LogoutSuccess) {
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
                          onPressed: () async {
                            _loginBloc.add(OnLogout());
                            // await Authentication.signOut(context: context);
                            // _socialglLogin.add(AfterSocialglLogin());
                          },
                          text: Translate.of(context).translate('sign_out'),
                          loading: login is LogoutLoading,
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
            if (widget.userData.provider == 'google')
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 15,
                  bottom: 15,
                ),
                child: BlocBuilder<SocialglLoginBloc, SocialglLoginState>(
                  builder: (context, login) {
                    return BlocListener<SocialglLoginBloc, SocialglLoginState>(
                      listener: (context, loginListener) {
                        if (loginListener is AfterSocialglLoginFail) {
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
                        onPressed: () async {
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
              )
            // Positioned(
            //   top: size.height * 0.03,
            //   right: size.width * 0.03,
            //   left: size.width * 0.03,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Image.asset('assets/images/user.png',
            //           height: size.height * 0.08, width: size.width * 0.08),
            //       GestureDetector(
            //         onTap: () {
            //           Navigator.pop(context);
            //         },
            //         child: Image.asset('assets/images/close.png',
            //             height: size.height * 0.08, width: size.width * 0.08),
            //       ),
            //     ],
            //   ),
            // ),
            // Positioned(
            //   top: size.height * 0.1,
            //   left: size.width * 0.03,
            //   child: GestureDetector(
            //     onTap: () {
            //       // Navigator.of(context).push(
            //       //     MaterialPageRoute(builder: (context) => ReportScreen()));
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Image.asset('assets/images/heart.png',
            //             height: size.height * 0.08, width: size.width * 0.08),
            //         SizedBox(
            //           width: size.width * 0.03,
            //         ),
            //         Text(
            //           'Report',
            //           style: TextStyle(
            //             fontWeight: FontWeight.normal,
            //             color: Colors.black,
            //             fontSize: size.width * 0.04,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Positioned(
            //   top: size.height * 0.15,
            //   left: size.width * 0.03,
            //   child: GestureDetector(
            //     onTap: () {
            //       // Navigator.of(context).push(
            //       //     MaterialPageRoute(builder: (context) => NewsListScreen()));
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Image.asset('assets/images/heart.png',
            //             height: size.height * 0.08, width: size.width * 0.08),
            //         SizedBox(
            //           width: size.width * 0.03,
            //         ),
            //         Text(
            //           'News',
            //           style: TextStyle(
            //             fontWeight: FontWeight.normal,
            //             color: Colors.black,
            //             fontSize: size.width * 0.04,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Positioned(
            //   top: size.height * 0.2,
            //   left: size.width * 0.03,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Image.asset('assets/images/heart.png',
            //           height: size.height * 0.08, width: size.width * 0.08),
            //       SizedBox(
            //         width: size.width * 0.03,
            //       ),
            //       Text(
            //         'Settings',
            //         style: TextStyle(
            //           fontWeight: FontWeight.normal,
            //           color: Colors.black,
            //           fontSize: size.width * 0.04,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Positioned(
            //   top: size.height * 0.25,
            //   left: size.width * 0.03,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Image.asset('assets/images/heart.png',
            //           height: size.height * 0.08, width: size.width * 0.08),
            //       SizedBox(
            //         width: size.width * 0.03,
            //       ),
            //       Text(
            //         'Support',
            //         style: TextStyle(
            //           fontWeight: FontWeight.normal,
            //           color: Colors.black,
            //           fontSize: size.width * 0.04,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Positioned(
            //   top: size.height * 0.3,
            //   left: size.width * 0.03,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Image.asset('assets/images/heart.png',
            //           height: size.height * 0.08, width: size.width * 0.08),
            //       SizedBox(
            //         width: size.width * 0.03,
            //       ),
            //       Text(
            //         'Privacy Policy',
            //         style: TextStyle(
            //           fontWeight: FontWeight.normal,
            //           color: Colors.black,
            //           fontSize: size.width * 0.04,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Positioned(
            //   top: size.height * 0.4,
            //   left: size.width * 0.03,
            //   child: GestureDetector(
            //     onTap: () async {
            //       // SharedPreferences prefs = await SharedPreferences.getInstance();
            //       //
            //       // prefs.clear();
            //       //
            //       // print(
            //       //     "current userToken is ${prefs.getString('userToken').toString()}");
            //       // print(
            //       //     "current loginmessage is ${prefs.getString('loginmessage').toString()}");
            //       // print(
            //       //     "current userID is ${prefs.getString('userID').toString()}");
            //       // print(
            //       //     "user is logged in ${prefs.getBool('isLogin').toString()}");
            //       //
            //       // Navigator.of(context).push(
            //       //     MaterialPageRoute(builder: (context) => LoginScreen()));
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Image.asset('assets/images/heart.png',
            //             height: size.height * 0.08, width: size.width * 0.08),
            //         SizedBox(
            //           width: size.width * 0.03,
            //         ),
            //         Text(
            //           'Log Out',
            //           style: TextStyle(
            //             fontWeight: FontWeight.normal,
            //             color: Colors.black,
            //             fontSize: size.width * 0.04,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
