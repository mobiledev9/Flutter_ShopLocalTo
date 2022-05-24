import 'package:flutter/material.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/screens/screen.dart';
import 'package:shoplocalto/screens/signin/signin.dart';
import 'package:shoplocalto/utils/utils.dart';

class Page1 extends StatefulWidget {
  Page1({Key key}) : super(key: key);

  @override
  _Page1State createState() {
    return _Page1State();
  }
}

class _Page1State extends State<Page1> {
  @override
  void initState() {
    super.initState();
  }

  void _signIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  void _signUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                child: Column(children: <Widget>[
                  Image.asset(Images.ShopLocalTOLogo, width: 250, height: 150),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Translate.of(context)
                            .translate("Don't Have an Account?"),
                      ),
                      Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                              onTap: _signUp,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  Translate.of(context)
                                      .translate('SignUp Now'),
                                  style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: 15),
                                ),
                              ))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Translate.of(context).translate('Already a Member?'),
                        ),
                        Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                                onTap: _signIn,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    Translate.of(context)
                                        .translate('Login Here'),
                                    style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 15),
                                  ),
                                ))),
                      ],
                    ),
                  ),
                ]),
              ))),
    );
  }
}
