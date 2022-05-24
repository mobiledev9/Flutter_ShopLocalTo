import 'package:flutter/cupertino.dart';
import 'dart:async';
// import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const APP_ID = "f34fb349e6754bd9bfd7ddf57b6ff71c";
String Token =
    "006f34fb349e6754bd9bfd7ddf57b6ff71cIACF5guorNk3pbbUIdReuYI0CB3GWsdKdnEal8+tTx/lv4geARcAAAAAEADjTvSOTGA5YgEAAQBMYDli";


class VoiceCallScreen extends StatefulWidget {
  final int id;
  const VoiceCallScreen({key,this.id}) : super(key: key);

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  // Init the app
  Future<void> initPlatformState() async {
    // Get microphone permission
    // await [Permission.microphone].request();
    //
    // // Create RTC client instance
    // RtcEngineContext context = RtcEngineContext(APP_ID);
    // var engine = await RtcEngine.createWithContext(context);
    // // Define event handling logic
    // engine.setEventHandler(RtcEngineEventHandler(
    //     joinChannelSuccess: (String channel, int uid, int elapsed) {
    //       print('joinChannelSuccess ${channel} ${uid}');
    //       setState(() {
    //         _joined = true;
    //       });
    //     }, userJoined: (int uid, int elapsed) {
    //   print('userJoined ${uid}');
    //   setState(() {
    //     _remoteUid = uid;
    //   });
    // }, userOffline: (int uid, UserOfflineReason reason) {
    //   print('userOffline ${uid}');
    //   setState(() {
    //     _remoteUid = 0;
    //   });
    // }));
    // // Join channel with channel name as 123
    // await engine.joinChannel(Token, 'shoplocal', null, 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora Audio quickstart'),
      ),
      body: Center(
        child: Text('Please chat!'),
      ),
    );
  }
}
