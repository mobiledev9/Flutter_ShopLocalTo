// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:listar_flutter/api/api.dart';
// import 'package:listar_flutter/blocs/bloc.dart';
// import 'package:listar_flutter/configs/config.dart';
// import 'package:intro_slider/slide_object.dart';
// import 'package:intro_slider/intro_slider.dart';
// import 'package:listar_flutter/models/model_banners.dart';
// import 'package:listar_flutter/models/screen_models/screen_models.dart';

// class IntroPreview extends StatefulWidget {
//   IntroPreview({Key key}) : super(key: key);

//   @override
//   _IntroPreviewState createState() {
//     return _IntroPreviewState();
//   }
// }

// class _IntroPreviewState extends State<IntroPreview> {
//   ApplicationBloc _applicationBloc;
//   BannerPageModel _bannerPageModel;

//   @override
//   void initState() {
//     _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
//     _loadDetail();
//     super.initState();
//   }

//   ///On complete preview intro
//   void _onCompleted() {
//     _applicationBloc.add(OnCompletedIntro());
//   }
//   Future<void> _loadDetail() async {
//     final dynamic result = await Api.getUserBanner();
//       setState(() {
//         _bannerPageModel = result;
//       });
//       print(_bannerPageModel.banner.toString());
//   }
//   @override
//   Widget build(BuildContext context) {
//     List<BannerModel> banner = _bannerPageModel == null?[]:_bannerPageModel.banner;
//     int totalPages = banner.length;
// return Scaffold(
//   body:PageView.builder(
//   itemCount: banner.length,
//   itemBuilder: (BuildContext context,int index){
//     final item = banner[index];
//     return Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(5),
//          color: Colors.blue,
//          image: DecorationImage(
//                 image: new NetworkImage(
//                 item.image
//                   ),
//           fit: BoxFit.fill
//               )
//                  ),
//         ),
//         Container(
//          child: Center(child: Text(item.description,
//       textAlign: TextAlign.center,
//       style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.w600))
//         ),),
//         index == (totalPages-1)?
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Align(alignment: Alignment.bottomRight,child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 height:40,
//                 decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(20),
//          color: Colors.grey.withOpacity(0.5),
//          backgroundBlendMode: BlendMode.lighten,
//                    ),
//                 child: FlatButton(onPressed:()=>_onCompleted() , child: Text('skip',
//                 style: TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.w400),
//                 ),
                
//                 )),
//             )),
//           ],
//         ):Container()
//       ],
//     );
//     // Container(
//     //   height:   MediaQuery.of(context).size.height,
//     //   width: MediaQuery.of(context).size.width,
//     //   decoration: BoxDecoration(
//     //      borderRadius: BorderRadius.circular(5),
//     //      color: Colors.blue,
//     //      image: DecorationImage(
//     //             image: new NetworkImage(
//     //             item.image
//     //               ),
//     //       fit: BoxFit.fill
//     //           )
//     //              ),
//     //   child: Center(child: Text(item.description,
//     //   textAlign: TextAlign.center,
//     //   style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.w600)
//     //   ))
//     // );
//   },
// ));
//   //   ///List Intro view page model
//   //   final List<Slide> pages = [
//   //     new Slide(
//   //      description: "Connecting Toronto Neighborhoods Together",
//   //      pathImage: Images.ShopLocalTOLogo,
//   //      backgroundImage: Images.Room6,
//   //    ),
//   //    new Slide(
//   //      description: "Find the best places right in your neighborhood",
//   //      pathImage: Images.ShopLocalTOLogo,
//   //      backgroundImage: Images.Room5,
//   //    ),
//   //   new Slide(
//   //      description:
//   //      "Play your part and shop local",
//   //      pathImage: Images.ShopLocalTOLogo, 
//   //      backgroundImage: Images.Trip6,
//   //    ),
//   //   ];

//   //   ///Build Page
//   //   return Scaffold(
//   //     body: IntroSlider(
//   //       listCustomTabs: [

//   //       ],
//   //    onSkipPress: ()=> _onCompleted(),
//   //    slides: pages,
//   //    onDonePress: ()=>_onCompleted(),
//   //  )
//   //   );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplocalto/blocs/bloc.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroPreview extends StatefulWidget {
  IntroPreview({Key key}) : super(key: key);

  @override
  _IntroPreviewState createState() {
    return _IntroPreviewState();
  }
}

class _IntroPreviewState extends State<IntroPreview> {
  ApplicationBloc _applicationBloc;

  @override
  void initState() {
    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    super.initState();
  }

  ///On complete preview intro
  void _onCompleted() {
    _applicationBloc.add(OnCompletedIntro());
  }

  @override
  Widget build(BuildContext context) {
    ///List Intro view page model
    final List<Slide> pages = [
      new Slide(
       description: "Connecting Toronto Neighborhoods Together",
       pathImage: Images.ShopLocalTOLogo,heightImage: 150,widthImage: 150,
       backgroundImage: Images.Room6,
     ),
     new Slide(
       description: "Find the best places right in your neighbourhood",
       pathImage: Images.ShopLocalTOLogo,heightImage: 150,widthImage: 150,
       backgroundImage: Images.Room5,
     ),
    new Slide(
       description:
       "Play your part in shoplocal",
       pathImage: Images.ShopLocalTOLogo, heightImage: 150,widthImage: 150,
       backgroundImage: Images.Trip6,
     ),
    ];

    ///Build Page
    return Scaffold(
      body: IntroSlider(
     onSkipPress: ()=> _onCompleted(),
     slides: pages,
     onDonePress: ()=>_onCompleted(),
   )
    );
  }
}

