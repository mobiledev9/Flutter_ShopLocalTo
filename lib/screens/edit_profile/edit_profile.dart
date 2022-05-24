import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoplocalto/blocs/Update/bloc.dart';
import 'package:shoplocalto/configs/image.dart';
import 'package:shoplocalto/configs/routes.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shoplocalto/models/model_user.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../main_navigation.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key, this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  _EditProfileState createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfile> {
  final _textNameController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textAddressController = TextEditingController();
  final _textWebsiteController = TextEditingController();
  final _textInfoController = TextEditingController();
  final _textPhoneController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusAddress = FocusNode();
  final _focusWebsite = FocusNode();
  final _focusInfo = FocusNode();
  final _focusPhone = FocusNode();

  File _image;
  bool _loading = false;
  String _validName;
  String _validEmail;
  String _validAddress;
  String _validWebsite;
  String _validInfo;
  String _validPhone;
  UserModel _userData;
  UpdateBloc _updateBloc;
  String value;
  File cropImage;
  bool _cropped = false;
  final picker = ImagePicker();
  String state1 ='';

  Future<void> _onRefresh() async {
    _loadProfile();
    await Future.delayed(Duration(seconds: 1));
    _controller.refreshCompleted();
  }

  void initState() {
    _updateBloc = BlocProvider.of<UpdateBloc>(context);
    _textAddressController.text = widget.userModel.address;
    _textEmailController.text = widget.userModel.email;
    _textInfoController.text = widget.userModel.information;
    _textNameController.text = widget.userModel.name;
    _textPhoneController.text = widget.userModel.phone;
    _textWebsiteController.text = widget.userModel.website;
    _loadProfile();
    super.initState();
  }
  final _controller = RefreshController(initialRefresh: false);

  ///On async get Image file
  Future _getImage() async {
    // ignore: deprecated_member_use
    PickedFile pickedFile =  await ImagePicker().getImage(source: ImageSource.gallery,);

    var res = pickedFile.path;
    if(pickedFile != null){
      setState(() {
        state1 = res;
        _image = File(pickedFile.path);
      });
      if(pickedFile.path.isNotEmpty){
        await Api().editImage(
            state1
        );
      }

    }

    // final ImagePicker _picker = ImagePicker();
    // final image = await _picker.pickImage(source: ImageSource.gallery);
    // var res = image.path;
    // if (image != null) {
    //   setState(() {
    //     state = res;
    //     _image = image as File;
    //   });
    //    if(state.isNotEmpty){
    //                         await Api().editImage(
    //                       state
    //                     );
    //                       }
    // }
  }

  Future _getCameraImage() async {
    // ignore: deprecated_member_use
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.camera,);
    var res = pickedFile.path;
    if(pickedFile != null){
      setState(() {
        state1 = res;
        _image = File(pickedFile.path);
      });
      if(pickedFile.path.isNotEmpty){
        await Api().editImage(
            state1
        );
      }

    }
    // final ImagePicker _picker = ImagePicker();
    // final image = await _picker.pickImage(source: ImageSource.camera);
    // var res = image.path;
    // if (image != null) {
    //   setState(() {
    //      state = res;
    //     _image = image as File;
    //
    //   });
    //   if(state.isNotEmpty){
    //                         await Api().editImage(
    //                       state
    //                     );
    //                       }
    // }
  }

  Future<void> _loadProfile() async {
    final UserModel result = await Api.getUserProfile();
    setState(() {
      _userData = result;
    });
    print(result);
  }

  void _onChangeSort() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  type: MaterialType.transparency,
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).buttonColor,
                    ),
                    child: InkWell(
                        onTap: _getCameraImage,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
                SizedBox(width: 30),
                Material(
                  type: MaterialType.transparency,
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).buttonColor,
                    ),
                    child: InkWell(
                        onTap: _getImage,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.camera,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String userImage = _userData ==null?null:_userData.profile_image;
    if(userImage==null){
      return Container(
          color: Colors.white,
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
            enabled: true,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Row(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 100,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                            ),
                            Container(
                              height: 50,
                              width: 320,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Row(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 100,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                            ),
                            Container(
                              height: 50,
                              width: 320,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Row(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 100,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                            ),
                            Container(
                              height: 50,
                              width: 320,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Row(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 100,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                            ),
                            Container(
                              height: 50,
                              width: 320,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Row(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 100,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                            ),
                            Container(
                              height: 50,
                              width: 320,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Row(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 100,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                            ),
                            Container(
                              height: 50,
                              width: 320,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Row(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                            ),
                            Container(
                              height: 50,
                              width: 320,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('edit_profile')),
      ),
      body: SafeArea(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: _onRefresh,
            controller: _controller,
            header: ClassicHeader(
              idleText:
              Translate.of(context).translate('pull_down_refresh'),
              refreshingText: Translate.of(context).translate('refreshing'),
              completeText:
              Translate.of(context).translate('refresh_completed'),
              releaseText:
              Translate.of(context).translate('release_to_refresh'),
              refreshingIcon: SizedBox(
                width: 16.0,
                height: 16.0,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            child:ListView(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          child: _image == null
                              ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(userImage),
                              ),
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                              Icons.camera_alt,
                              color: Theme.of(context).buttonColor
                          ),
                          // onPressed: _getImage,
                          onPressed: _onChangeSort,
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
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
                  // controller: TextEditingController(text: _userData.name),
                  hintText: Translate.of(context).translate('name'),
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
                  //     context,
                  //     _focusName,
                  //     _focusEmail,
                  //   );
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
                // Padding(
                //   padding: EdgeInsets.only(top: 10, bottom: 10),
                //   child: Text(
                //     Translate.of(context).translate('email'),
                //     style: Theme.of(context)
                //         .textTheme
                //         .subtitle2
                //         .copyWith(fontWeight: FontWeight.w600),
                //   ),
                // ),
                // AppTextInput(
                //   hintText: Translate.of(context).translate('email'),
                //   errorText: _validEmail != null
                //       ? Translate.of(context).translate(_validEmail)
                //       : null,
                //   focusNode: _focusEmail,
                //   textInputAction: TextInputAction.next,
                //   onTapIcon: () async {
                //     await Future.delayed(Duration(milliseconds: 100));
                //     _textEmailController.clear();
                //   },
                //   // onSubmitted: (text) {
                //   //   UtilOther.fieldFocusChange(
                //   //       context, _focusEmail, _focusAddress);
                //   // },
                //   // onChanged: (text) {
                //   //   setState(() {
                //   //     _validEmail = UtilValidator.validate(
                //   //       data: _textEmailController.text,
                //   //       type: Type.email,
                //   //     );
                //   //   });
                //   // },
                //   icon: Icon(Icons.clear),
                //   controller: _textEmailController,
                //   keyboardType: TextInputType.emailAddress,
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    Translate.of(context).translate('phone'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: Translate.of(context).translate('phone'),
                  errorText: _validPhone != null
                      ? Translate.of(context).translate(_validPhone)
                      : null,
                  icon: Icon(Icons.clear),
                  controller: _textPhoneController,
                  focusNode: _focusPhone,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  // onChanged: (text) {
                  //   setState(() {
                  //     _validPhone = UtilValidator.validate(
                  //       data: _textPhoneController.text,
                  //     );
                  //   });
                  // },
                  // onSubmitted: (text) {
                  //   UtilOther.fieldFocusChange(
                  //       context, _focusPhone, _focusPhone);
                  // },
                  onTapIcon: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    _textPhoneController.clear();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    Translate.of(context).translate('address'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: Translate.of(context).translate('address'),
                  errorText: _validAddress != null
                      ? Translate.of(context).translate(_validAddress)
                      : null,
                  focusNode: _focusAddress,
                  textInputAction: TextInputAction.next,
                  onTapIcon: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    _textAddressController.clear();
                  },
                  // onSubmitted: (text) {
                  //   UtilOther.fieldFocusChange(
                  //     context,
                  //     _focusAddress,
                  //     _focusWebsite,
                  //   );
                  // },
                  // onChanged: (text) {
                  //   setState(() {
                  //     _validAddress = UtilValidator.validate(
                  //       data: _textAddressController.text,
                  //     );
                  //   });
                  // },
                  icon: Icon(Icons.clear),
                  controller: _textAddressController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    Translate.of(context).translate('website'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: Translate.of(context).translate('website'),
                  errorText: _validWebsite != null
                      ? Translate.of(context).translate(_validWebsite)
                      : null,
                  focusNode: _focusWebsite,
                  textInputAction: TextInputAction.next,
                  onTapIcon: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    _textWebsiteController.clear();
                  },
                  // onSubmitted: (text) {
                  //   UtilOther.fieldFocusChange(
                  //     context,
                  //     _focusWebsite,
                  //     _focusInfo,
                  //   );
                  // },
                  // onChanged: (text) {
                  //   setState(() {
                  //     _validWebsite = UtilValidator.validate(
                  //       data: _textWebsiteController.text,
                  //     );
                  //   });
                  // },
                  icon: Icon(Icons.clear),
                  controller: _textWebsiteController,
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
                    'information',
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
                  //   _update();
                  // },
                  // onChanged: (text) {
                  //   setState(() {
                  //     _validInfo = UtilValidator.validate(
                  //       data: _textInfoController.text,
                  //     );
                  //   });
                  // },
                  icon: Icon(Icons.clear),
                  controller: _textInfoController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: BlocBuilder<UpdateBloc, UpdateState>(
                    builder: (context, update) {
                      return BlocListener<UpdateBloc, UpdateState>(
                        listener: (context, updateListener) {
                          if (updateListener is UpdateFail) {
                            print("update failed");
                          }
                          if (updateListener is UpdateSuccess) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainNavigation(),
                                ));

                          }
                        },
                        child: AppButton(
                          onPressed: () async {
                            _updateBloc.add(OnUpdate(
                              username: _textNameController.text,
                              email: _textEmailController.text,
                              phone: _textPhoneController.text,
                              address: _textAddressController.text,
                              info: _textInfoController.text,
                              website: _textWebsiteController.text,
                            ));
                            print('username.........:${_textNameController.text}');
                            print('email.........:${_textEmailController.text}');
                            print(
                                'Adress...........:${_textAddressController.text}');
                            print(
                                'phone....................:${_textPhoneController.text}');
                            print(
                                'website...............:${_textWebsiteController.text}');


                          },
                          text: Translate.of(context).translate('confirm'),
                          loading: update is UpdateProfileLoading,
                          disableTouchWhenLoading: true,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
//  Padding(
//               padding: EdgeInsets.only(
//                 left: 20,
//                 right: 20,
//                 top: 15,
//                 bottom: 15,
//               ),
//               child: BlocBuilder<UpdateBloc, UpdateState>(
//                 builder: (context, update) {
//                   return BlocListener<UpdateBloc, UpdateState>(
//                     listener: (context, updateListener) {
//                       if (updateListener is UpdateFail) {
//                         print("update failed");
//                       }
//                        if (updateListener is UpdateSuccess) {
//                          Navigator.pop(context);
//                       }
//                     },
//                     child: AppButton(
//                       onPressed: () async {
//                         _updateBloc.add(OnUpdate(
//                           username: _textNameController.text,
//                           email: _textEmailController.text,
//                           phone: _textPhoneController.text,
//                           address: _textAddressController.text,
//                           info: _textInfoController.text,
//                           website: _textWebsiteController.text,
//                         ));
//                         print('username.........:${_textNameController.text}');
//                         print('email.........:${_textEmailController.text}');
//                         print(
//                             'Adress...........:${_textAddressController.text}');
//                         print(
//                             'phone....................:${_textPhoneController.text}');
//                         print(
//                             'website...............:${_textWebsiteController.text}');


//                       },
//                       text: Translate.of(context).translate('confirm'),
//                       loading: update is UpdateProfileLoading,
//                       disableTouchWhenLoading: true,
//                     ),
//                   );
//                 },
//               ),
//             ),