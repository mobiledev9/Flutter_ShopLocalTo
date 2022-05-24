import 'package:flutter/material.dart';
import 'package:shoplocalto/configs/image.dart';
import 'package:shoplocalto/screens/screen.dart';
import 'package:shoplocalto/utils/translate.dart';
import 'package:shoplocalto/widgets/app_button.dart';

class Success extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('Success'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(Images.ShopLocalTOLogo, width: 300, height: 200),
                SizedBox(
                  height: 30,
                ),
                Container(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("Thank You",style:TextStyle(color: Colors.blue[900],fontSize: 45)))),
                        Container(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("for SignUp!",style:TextStyle(color: Colors.blue[900],fontSize: 25)))),
                SizedBox(height: 40,),
                AppButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  text: Translate.of(context).translate('SignIn'),
                  disableTouchWhenLoading: true,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                Image.asset(Images.INDigitalLOGO_logo_large,
                    width: 100, height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
