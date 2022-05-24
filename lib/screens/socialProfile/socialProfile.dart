import 'package:flutter/material.dart';
import 'package:shoplocalto/screens/signin/signin.dart';
import 'package:shoplocalto/socials/facebook.dart';
import 'package:shoplocalto/socials/google.dart';
import 'package:shoplocalto/blocs/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shoplocalto/main_navigation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// ignore: must_be_immutable
class SocialProfile extends StatefulWidget {
  String profilepic;
  String name;
  String email;
  String providerid;
  String providerName;

  SocialProfile(this.profilepic, this.name, this.email,this.providerid,this.providerName);

  @override
  _SocialProfileState createState() => _SocialProfileState();
}

class _SocialProfileState extends State<SocialProfile> {

  SocialLoginBloc _socialloginBloc;

  @override
  void initState() {
    _socialloginBloc = BlocProvider.of<SocialLoginBloc>(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(this.widget.profilepic),
              radius: 75.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text("NAME:", style: TextStyle(fontSize: 15.0)),
            SizedBox(
              height: 5.0,
            ),
            Text(this.widget.name, style: TextStyle(fontSize: 25.0)),
            SizedBox(height: 20.0),
            Text("EMAIL ID:", style: TextStyle(fontSize: 15.0)),
            SizedBox(
              height: 5.0,
            ),
            Text(this.widget.email, style: TextStyle(fontSize: 20.0)),
            SizedBox(
              height: 5.0,
            ),
            Text(this.widget.providerName, style: TextStyle(fontSize: 20.0)),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left:30,right:30),
              child: SizedBox(
                width:MediaQuery.of(context).size.width*1,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Theme.of(context).buttonColor,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "LogOut",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      // AuthBlocGoogle().logOut();
                      // AuthBlocFacebook().logout();
                    }),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.only(left:30,right:30),
              child: BlocBuilder<SocialLoginBloc, SocialLoginState>(
                    builder: (context, login) {
                      return BlocListener<SocialLoginBloc, SocialLoginState>(
                        listener: (context, loginListener) {
                          if (loginListener is SocialLoginFail) {
                            _showMessage();
                          }
                          if (loginListener is SocialLoginSuccess) {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => MainNavigation(),
                            //     ));
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (_) => MainNavigation()),
                                    (route) => false
                            );
                          }
                        },
                        child: AppButton(
                          onPressed: () {
                            setState(() {
                              _socialloginBloc.add(
                                OnSocialLogin(
                                  email: widget.email,
                                  name: widget.name,
                                  profile_image: widget.profilepic,
                                  provider: widget.providerName,
                                  provider_id: widget.providerid,
                                ),
                              );
                            });
                            // _login();
                          },
                          text: Translate.of(context).translate('Login'),
                          loading: login is LoginLoading,
                          disableTouchWhenLoading: true,
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
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
            child: Text('Api error Unable to login${widget.providerid}${widget.providerName}',
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
                      SignIn(),
                )),
            child: Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
