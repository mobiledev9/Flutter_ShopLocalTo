// import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shoplocalto/screens/chat/chat.dart';

const APP_ID = "f34fb349e6754bd9bfd7ddf57b6ff71c";
const Token =
    " ";

class VideocallScreen extends StatefulWidget {
  final int id;
  const VideocallScreen({key,this.id}) : super(key: key);

  @override
  State<VideocallScreen> createState() => _VideocallScreenState();
}

class _VideocallScreenState extends State<VideocallScreen> {
  bool _joined = false;
  int _remoteUid;
  bool _switch = false;
  //RtcEngine engine;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // initPlatformState();
  }

  // Future<void> initPlatformState() async {
  //   await [Permission.camera, Permission.microphone].request();
  //
  //   // Create RTC client instance
  //   RtcEngineContext context = RtcEngineContext(APP_ID);
  //   engine = await RtcEngine.createWithContext(context);
  //   // Define event handling logic
  //   engine.setEventHandler(RtcEngineEventHandler(
  //       joinChannelSuccess: (String channel, int uid, int elapsed) {
  //         print('joinChannelSuccess ${channel} ${uid}');
  //         setState(() {
  //           _joined = true;
  //         });
  //       }, userJoined: (int uid, int elapsed) {
  //     print('userJoined ${uid}');
  //     setState(() {
  //       _remoteUid = uid;
  //     });
  //   }, userOffline: (int uid, UserOfflineReason reason) {
  //     print('userOffline ${uid}');
  //     setState(() {
  //       _remoteUid = null;
  //     });
  //   }));
  //   // Enable video
  //   await engine.enableVideo();
  //   // Join channel with channel name as 123
  //   await engine.joinChannel(Token, 'shoplocal', null, 0);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _switch = !_switch;
                    });
                  },
                  child: Center(
                    child:
                    _switch ? _renderLocalPreview() : _renderRemoteVideo(),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:() async {
                      // await engine.leaveChannel();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Chat(  id: widget.id)),
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Icon(Icons.call_end),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Local preview
  Widget _renderLocalPreview() {
    // return Container();
    // if (_joined) {
    // return RtcLocalView.SurfaceView();
    // } else {
    //   return Text(
    //     'Please join channel first',
    //     textAlign: TextAlign.center,
    //   );
    // }
  }

  // Remote preview
  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
     // return RtcRemoteView.SurfaceView(uid: _remoteUid);
    } else {
      return Text(
        'Please wait remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
