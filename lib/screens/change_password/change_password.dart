import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplocalto/blocs/bloc.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shoplocalto/configs/image.dart';
import 'package:shoplocalto/main_navigation.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePassword> {
  final _textPassController = TextEditingController();
  final _textRePassController = TextEditingController();
  final _focusPass = FocusNode();
  final _focusRePass = FocusNode();

  // bool _loading = false;
  String _validPass;
  String _validRePass;
  ResetBloc _resetBloc;

  void initState() {
    _resetBloc = BlocProvider.of<ResetBloc>(context);
    _textPassController.text;
    _textRePassController.text;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('change_password'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height:100),
            Expanded(
              child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(alignment:Alignment.center, child: Image.asset(Images.ShopLocalTOLogo, width: 250, height: 150)),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                        Translate.of(context).translate('password'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  AppTextInput(
                                    hintText: Translate.of(context).translate(
                                        'New Password',
                                    ),
                                    errorText: _validPass != null
                                          ? Translate.of(context).translate(_validPass)
                                          : null,
                                    focusNode: _focusPass,
                                    textInputAction: TextInputAction.next,
                                    obscureText: true,
                                    onTapIcon: () async {
                                        await Future.delayed(Duration(milliseconds: 100));
                                        _textPassController.clear();
                                    },
                                    // onSubmitted: (text) {
                                    //   UtilOther.fieldFocusChange(
                                    //     context,
                                    //     _focusPass,
                                    //     _focusRePass,
                                    //   );
                                    // },
                                    // onChanged: (text) {
                                    //   setState(() {
                                    //     _validPass = UtilValidator.validate(
                                    //       data: _textPassController.text,
                                    //     );
                                    //   });
                                    // },
                                    icon: Icon(Icons.clear),
                                    controller: _textPassController,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                        Translate.of(context).translate('confirm_password'),
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  AppTextInput(
                                    hintText: Translate.of(context).translate(
                                        'Confirm Password',
                                    ),
                                    errorText: _validRePass != null
                                          ? Translate.of(context).translate(_validRePass)
                                          : null,
                                    focusNode: _focusRePass,
                                    textInputAction: TextInputAction.done,
                                    obscureText: true,
                                    onTapIcon: () async {
                                        await Future.delayed(Duration(milliseconds: 100));
                                        _textRePassController.clear();
                                    },
                                    // onSubmitted: (text) {
                                    //   _changePassword();
                                    // },
                                    // onChanged: (text) {
                                    //   setState(() {
                                    //     _validRePass = UtilValidator.validate(
                                    //         data: _textRePassController.text);
                                    //   });
                                        
                                    // },
                                    icon: Icon(Icons.clear),
                                    controller: _textRePassController,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                  ),
                                        BlocBuilder<ResetBloc, ResetState>(
                                    builder: (context, login) {
                                        return BlocListener<ResetBloc, ResetState>(
                                          listener: (context, loginListener) {
                                            if (loginListener is ResetFail) {
                                              _showMessage();
                                            }
                                            if(loginListener is ResetSuccess){
                              //                 Navigator.push(
                              // context,
                              // MaterialPageRoute(
                              //   builder: (context) => MainNavigation(),
                              // ));
                                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                                  builder: (_) => MainNavigation()),
                                                      (route) => false
                                              );
                                            }
                                          },
                                          child: AppButton(
                                            onPressed: () {
                                              setState(() {
                                                _resetBloc.add(
                                                  OnReset(
                                                    password: _textPassController.text,
                                                    confirmpassword: _textRePassController.text,
                                                  ),
                                                );
                                                print('email:${_textRePassController.text}');
                                                print('password:${_textPassController.text}');
                                              });
                                              //  _showSuccess();
                                              //  Navigator.of(context).pop();
                                            },
                                            
                                            text: Translate.of(context).translate('confirm'),
                                            loading: login is ResetLoading,
                                            disableTouchWhenLoading: true,
                                           
                                          ),
                                        );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _showMessage() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ResetPassword'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Reset failed', style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
