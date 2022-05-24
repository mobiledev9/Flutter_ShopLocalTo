import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/image.dart';
import 'package:shoplocalto/screens/forgot_password/forgotpass_verificationcode.dart';
import 'package:shoplocalto/screens/forgot_password/setnew_pass.dart';
import 'package:shoplocalto/screens/signin/signin.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final String email;
  final String code;
  const SetNewPasswordScreen({key,this.email,this.code}) : super(key: key);

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final _textnewpssController = TextEditingController();
  bool _loading = false;
  String _validpass;

  @override
  void initState() {
    super.initState();
    print(widget.email);
  }

  Future<void> setnewpass(
      String email,
      String code,
      String newpass,
      ) async {
    setState(() {
      _loading = true;
    });
    final dynamic result = await Api.setnewpassword(email: email,code: code,newpass:newpass);

    print('email is ${widget.email}');

    if (result['message'] == "Password Successfully changed. ") {
      print(result['success'].toString());
      print('${result['message']}');
      print('${result['success']}');
      setState(() {
        _loading = false;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SignIn()));
    } else {
      print('${result['message']}');
      print('${result['success']}');
      setState(() {
        _loading = false;
      });
      return   Alert(
          context: context,
          title: "Fail",
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
      _validpass = UtilValidator.validate(
        data: _textnewpssController.text,
        type: Type.password,
      );
    });

    if (_validpass == null) {
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
          Translate.of(context).translate('reset_password'),
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
                    Translate.of(context).translate('password'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_your_password'),
                  errorText: _validpass != null
                      ? Translate.of(context).translate(_validpass)
                      : null,
                  onTapIcon: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    _textnewpssController.clear();
                  },
                  onSubmitted: (text) {

                  },
                  onChanged: (text) {
                    setState(() {
                      _validpass = UtilValidator.validate(
                        data: _textnewpssController.text,
                        type: Type.password,


                      );
                    });
                  },
                  icon: Icon(Icons.clear),
                  controller: _textnewpssController,
                  keyboardType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                AppButton(
                  onPressed: () async {
                    final newpass = _textnewpssController.text;
                    final email = widget.email;
                    final code = widget.code;
                    await setnewpass(email,code,newpass);
                  },
                  text: Translate.of(context).translate('reset_password'),
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
