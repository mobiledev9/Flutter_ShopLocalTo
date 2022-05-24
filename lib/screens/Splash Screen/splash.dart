// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:listar_flutter/blocs/bloc.dart';
// import 'package:listar_flutter/configs/config.dart';
// import 'package:listar_flutter/configs/video.dart';
// import 'package:video_player/video_player.dart';

// class SplashScreen extends StatefulWidget {
//   SplashScreen({Key key}) : super(key: key);

//   @override
//   _SplashScreenState createState() {
//     return _SplashScreenState();
//   }
// }
// // @sanjana edited loading screen
// class _SplashScreenState extends State<SplashScreen> {
//   VideoPlayerController _controller;
//    bool _visible = false;

//   ApplicationBloc _applicationBloc;

//   @override
//   // void initState() {
//   //   _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
//   //   _applicationBloc.add(SetupApplication());
//   //   super.initState();
//   // }
//    void initState() {
//      _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
//     _applicationBloc.add(SetupApplication());
//     super.initState();

//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);

//     _controller = VideoPlayerController.asset(Videos.Background1);
//     _controller.initialize().then((_) {
//       _controller.setLooping(true);
//       Timer(Duration(milliseconds: 100), () {
//         setState(() {
//           _controller.play();
//           _visible = true;
//         });
//       });
//     });
//   }
// _getVideoBackground() {
//     return AnimatedOpacity(
//       opacity: _visible ? 1.0 : 0.0,
//       duration: Duration(milliseconds: 1000),
//       child: VideoPlayer(_controller),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           _getVideoBackground(),
//           Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Image.asset(Images.ShopLocalTOLogo, width: 300, height: 300),
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//                       child: Padding(
//               padding: EdgeInsets.only(top: 300),
//               child: SizedBox(
//                 width: 50,
//                 height: 50,
//                 child:   CircularProgressIndicator(strokeWidth: 5,
//                 valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue[800])),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }