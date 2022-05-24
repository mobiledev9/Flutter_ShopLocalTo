import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/image.dart';
import 'package:shoplocalto/screens/forgot_password/forgotpass_verificationcode.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() {
    return _ForgotPasswordState();
  }
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _textEmailController = TextEditingController();

  bool _loading = false;
  String _validEmail;

  @override
  void initState() {
    super.initState();
  }

  Future<void> sendcode(
    String email,
  ) async {
    setState(() {
      _loading = true;
    });
    final dynamic result = await Api.resetPasswordsendcode(email: email);

    print('email is ${_textEmailController.text}');

    if (result['message'] == "Secret code successfully sent to your email ") {
      print(result['success'].toString());
      print('${result['message']}');
      print('${result['success']}');
      setState(() {
        _loading = false;
      });
       Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ForgotpassVerificationCode(email: _textEmailController.text,)));
    } else {
      print('${result['message']}');
      print('${result['success']}');
      setState(() {
        _loading = false;
      });
      return  Alert(
          context: context,
          title: "Verification Failed",
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
              child: Text(result['message'],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1),

              // previous search by sanjana search.txt
            ),
          ]),
          buttons: [
            DialogButton(
              color: Theme.of(context).buttonColor,
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Continue",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }

  }

  ///Fetch API
  Future<void> _forgotPassword() async {
    setState(() {
      _validEmail = UtilValidator.validate(
        data: _textEmailController.text,
        type: Type.email,
      );
    });

    if (_validEmail == null) {
      setState(() {
        _loading = true;
      });
      await Future.delayed(Duration(seconds: 1));
      Navigator.pop(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('forgot_password'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: Image.asset(Images.ShopLocalTOLogo,
                        width: 250, height: 150)),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    Translate.of(context).translate('email'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_email'),
                  errorText: _validEmail != null
                      ? Translate.of(context).translate(_validEmail)
                      : null,
                  onTapIcon: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    _textEmailController.clear();
                  },
                  onSubmitted: (text) {
                    _forgotPassword();
                  },
                  onChanged: (text) {
                    setState(() {
                      _validEmail = UtilValidator.validate(
                        data: _textEmailController.text,
                        type: Type.email,
                      );
                    });
                  },
                  icon: Icon(Icons.clear),
                  controller: _textEmailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                AppButton(
                  onPressed: () async {
                    final email = _textEmailController.text;
                    await sendcode(email);
                  },
                  text: Translate.of(context).translate('send'),
                  loading: _loading,
                  disableTouchWhenLoading: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
