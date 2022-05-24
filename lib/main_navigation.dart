import 'dart:developer';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/bloc.dart';
import 'package:shoplocalto/configs/application.dart';
import 'package:shoplocalto/screens/screen.dart';
import 'package:shoplocalto/utils/logger.dart';
import 'package:shoplocalto/utils/utils.dart';

import 'models/model_user.dart';
import 'package:shoplocalto/models/model.dart';
import 'models/model_mylocation.dart';

// import 'api/api.dart';


class MainNavigation extends StatefulWidget {
  MainNavigation({Key key,}) : super(key: key);

  @override
  _MainNavigationState createState() {
    return _MainNavigationState();
  }
}

class _MainNavigationState extends State<MainNavigation> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  int  _selectedIndex = 0;
  int neighbourid;
  UserModel _user;
  @override
  void initState() {
  //  _loadUser();
    _fcmHandle();
    _loadUserid();
    super.initState();
  }

  Future<void> _loadUserid() async {
    // await Future.delayed(Duration(seconds: 2));
    final dynamic result = await Api.getUserProfile();
      setState(() {
        _user = result;
        log(_user.neighbourhoodid.toString());
      });
  }
  void _fcmHandle() async {
    await Future.delayed(Duration(seconds: 2));
    _fcm.requestPermission( alert: true, announcement: false, badge: true, carPlay: false, criticalAlert: false, provisional: false, sound: true, );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification _notification = message.notification;
      AndroidNotification _android = message.notification?.android;
      onMessage: (Map<String, dynamic> message) async {
        final notification = message['aps']['alert'];
        UtilLogger.log("onMessage", '$notification');
        _showNotification(notification['title'], notification['body']);
      };
      onLaunch: (Map<String, dynamic> message) async {
      final notification = message['aps']['alert'];
      _showNotification(notification['title'], notification['body']);
      };
      onResume: (Map<String, dynamic> message) async {
      final notification = message['aps']['alert'];
      _showNotification(notification['title'], notification['body']);
      UtilLogger.log("onResume", 'onMessage $message');
      };
    });

    Application.pushToken = await _fcm.getToken();
  }

  ///On change tab bottom menu
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ///Show notification received
  Future<void> _showNotification(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message, style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translate.of(context).translate('close')),
              onPressed: () {
                Navigator.of(context).pop();

              },

            ),
          ],
        );
      },
    );
  }

  ///List bottom menu
  List<BottomNavigationBarItem> _bottomBarItem(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home'
        // ignore: deprecated_member_use
        //title: Padding(
          //padding: EdgeInsets.only(top: 3),
          //child: Text(Translate.of(context).translate('home')),
        //),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bookmark),
          label: 'Wishlist'
        // ignore: deprecated_member_use
        // title: Padding(
        //   padding: EdgeInsets.only(top: 3),
        //   child: Text(Translate.of(context).translate('wish_list')),
        // ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.message),
          label: 'Message'
        // ignore: deprecated_member_use
        // title: Padding(
        //   padding: EdgeInsets.only(top: 3),
        //   child: Text(Translate.of(context).translate('message')),
        // ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
          label: 'Notification'
        // ignore: deprecated_member_use
        // title: Padding(
        //   padding: EdgeInsets.only(top: 3),
        //   child: Text(Translate.of(context).translate('notification')),
        // ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
          label: 'Account'
        // ignore: deprecated_member_use
        // title: Padding(
        //   padding: EdgeInsets.only(top: 3),
        //   child: Text(Translate.of(context).translate('account')),
        // ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    int id = _user == null?null:_user.neighbourhoodid;
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthenticationState>(
        builder: (context, auth) {
          return IndexedStack(
            index: _selectedIndex,
            children: <Widget>[
              DoubleBack(
                message:"Press back again to close",
                child:  Home(id:id),
              ),
              WishList(),
              MessageList(),
              NotificationList(),
              auth is AuthenticationSuccess ? Profile() : SignIn(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomBarItem(context),
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        selectedItemColor: Theme.of(context).primaryColor,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }

}
