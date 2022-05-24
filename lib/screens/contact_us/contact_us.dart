import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplocalto/blocs/bloc.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shoplocalto/models/model_user.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/image.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shoplocalto/main_navigation.dart';

class ContactUs extends StatefulWidget {
  @override
  ContactUsState createState() => ContactUsState();
}

class ContactUsState extends State<ContactUs> {
  // final _initPosition = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  final _textNameController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textInfoController = TextEditingController();
  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusInfo = FocusNode();

  String _validName;
  String _validEmail;
  String _validInfo;
  UserModel _userData;
  ContactBloc _contactUsBloc;

  @override
  void initState() {
 _contactUsBloc = BlocProvider.of<ContactBloc>(context);
    _loadProfile();
    _textNameController.text;
    _textEmailController.text ;
    super.initState();
  }
   Future<void> _loadProfile() async {
    final UserModel result = await Api.getUserProfile();
      setState(() {
        _userData = result;
      });
       
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('contact_us')),
        actions: <Widget>[
          // FlatButton(
          //   child: Text(
          //     Translate.of(context).translate('send'),
          //     style: Theme.of(context)
          //         .textTheme
          //         .button
          //         .copyWith(color: Colors.white),
          //   ),
          //   onPressed: _send,
          // ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height:50),
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
                      // Container(
                      //   height: 250,
                      //   child: GoogleMap(
                      //     initialCameraPosition: _initPosition,
                      //     myLocationEnabled: true,
                      //   ),
                      // ),
                      Container(alignment:Alignment.center, child: Image.asset(Images.ShopLocalTOLogo, width: 250, height: 150)),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          Translate.of(context).translate('name'),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      AppTextInput(
                        hintText: Translate.of(context).translate('input_name'),
                        errorText: _validName != null
                            ? Translate.of(context).translate(_validName)
                            : null,
                        focusNode: _focusName,
                        textInputAction: TextInputAction.next,
                        onTapIcon: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          _textNameController.clear();
                        },
                        // onSubmitted: (text) {
                        //   UtilOther.fieldFocusChange(
                        //       context, _focusName, _focusEmail);
                        // },
                        // onChanged: (text) {
                        //   setState(() {
                        //     _validName = UtilValidator.validate(
                        //       data: _textNameController.text,
                        //     );
                        //   });
                        // },
                        icon: Icon(Icons.clear),
                        controller: _textNameController,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          Translate.of(context).translate('email'),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      AppTextInput(
                        hintText: Translate.of(context).translate(
                          'input_email',
                        ),
                        errorText: _validEmail != null
                            ? Translate.of(context).translate(_validEmail)
                            : null,
                        focusNode: _focusEmail,
                        textInputAction: TextInputAction.next,
                        onTapIcon: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          _textEmailController.clear();
                        },
                        // onSubmitted: (text) {
                        //   UtilOther.fieldFocusChange(
                        //       context, _focusEmail, _focusInfo);
                        // },
                        // onChanged: (text) {
                        //   setState(() {
                        //     _validEmail = UtilValidator.validate(
                        //       data: _textEmailController.text,
                        //       type: Type.email,
                        //     );
                        //   });
                        // },
                        icon: Icon(Icons.clear),
                        controller: _textEmailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          Translate.of(context).translate('information'),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      AppTextInput(
                        hintText: Translate.of(context).translate(
                          'input_information',
                        ),
                        errorText: _validInfo != null
                            ? Translate.of(context).translate(_validInfo)
                            : null,
                        focusNode: _focusInfo,
                        maxLines: 5,
                        onTapIcon: () async {
                          await Future.delayed(Duration(milliseconds: 100));
                          _textInfoController.clear();
                        },
                        // onSubmitted: (text) {
                        //   _send();
                        // },
                        // onChanged: (text) {
                        //   setState(() {
                        //     _validInfo = UtilValidator.validate(
                        //       data: _textInfoController.text,
                        //       type: Type.email,
                        //     );
                        //   });
                        // },
                        icon: Icon(Icons.clear),
                        controller: _textInfoController,
                      ),
                      Padding(
                                    padding: EdgeInsets.only(top: 20),
                                  ),
                    BlocBuilder<ContactBloc, ContactState>(
                       builder: (context, update) {
                         return BlocListener<ContactBloc, ContactState>(
                           listener: (context, updateListener) {
                             if (updateListener is ContactFail) {
                               _showMessage();
                               
                             }
                             if (updateListener is ContactSuccess) {
                               Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainNavigation(),
                              ));
                             }
                           },
                           child: AppButton(
                             onPressed: () {
                               _contactUsBloc.add(OnContact(
                                 name: _textNameController.text,
                                 email: _textEmailController.text,
                                 comment: _textInfoController.text,
                               ));
                               print('username.........:${_textNameController.text}');
                               print('email.........:${ _textEmailController.text}');
                               
                             },
                             text: Translate.of(context).translate('confirm'),
                             loading: update is ContactLoading,
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
    return Alert(
        context: context,
        title: "Contactus failed",
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
            child: Text('incorrect feilds',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1),

            // previous search by sanjana search.txt
          ),
        ]),
        buttons: [
          DialogButton(
            color: Theme.of(context).buttonColor,
            onPressed: () =>Navigator.pop(context),
            child: Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}


