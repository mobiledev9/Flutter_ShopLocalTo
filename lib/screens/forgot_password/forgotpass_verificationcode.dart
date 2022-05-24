import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/image.dart';
import 'package:shoplocalto/screens/forgot_password/setnew_pass.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';

class ForgotpassVerificationCode extends StatefulWidget {
  final String email;
  const ForgotpassVerificationCode({key,this.email}) : super(key: key);

  @override
  State<ForgotpassVerificationCode> createState() => _ForgotpassVerificationCodeState();
}

class _ForgotpassVerificationCodeState extends State<ForgotpassVerificationCode> {
  final _textcodeController = TextEditingController();
  bool _loading = false;
  String _validcode;

  @override
  void initState() {
    super.initState();
    print(widget.email);
  }

  Future<void> verifycode(
      String email,
      String code,
      ) async {
    setState(() {
      _loading = true;
    });
    final dynamic result = await Api.verifycode(email: email,code: code);

    print('email is ${widget.email}');

    if (result['message'] == "Secret code successfully verifiedl ") {
      print(result['success'].toString());
      print('${result['message']}');
      print('${result['success']}');
      setState(() {
        _loading = false;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SetNewPasswordScreen(email: widget.email,code: _textcodeController.text,)));
    } else {
      print('${result['message']}');
      print('${result['success']}');
      setState(() {
        _loading = false;
      });
      return Alert(
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
      _validcode = UtilValidator.validate(
        data: _textcodeController.text,
        type: Type.normal,
      );
    });

    if (_validcode == null) {
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
          Translate.of(context).translate('verify_code'),
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
                    Translate.of(context).translate('code'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: Translate.of(context).translate('inputcode'),
                  errorText: _validcode != null
                      ? Translate.of(context).translate(_validcode)
                      : null,
                  onTapIcon: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    _textcodeController.clear();
                  },
                  onSubmitted: (text) {

                  },
                  onChanged: (text) {
                    setState(() {
                      _validcode = UtilValidator.validate(
                        data: _textcodeController.text,
                        type: Type.normal,
                      );
                    });
                  },
                  icon: Icon(Icons.clear),
                  controller: _textcodeController,
                  keyboardType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                AppButton(
                  onPressed: () async {
                    final code = _textcodeController.text;
                    final email = widget.email;
                    await verifycode(email,code);
                  },
                  text: Translate.of(context).translate('verify_code'),
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
