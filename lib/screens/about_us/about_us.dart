import 'package:flutter/material.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key key}) : super(key: key);

  @override
  _AboutUsState createState() {
    return _AboutUsState();
  }
}

class _AboutUsState extends State<AboutUs> {
  AboutUsPageModel _aboutUsPage;
  AboutUsModel _aboutus;

  @override
  void initState() {
    // _loadData();
    _loadDetail();
    super.initState();
  }

  ///Fetch API
  // Future<void> _loadData() async {
  //   final ResultApiModel result = await Api.getAboutUs();
  //   if (result.success) {
  //     setState(() {
  //       _aboutUsPage = new AboutUsPageModel.fromJson(result.data);
  //     });
  //   }
  // }

  Future<void> _loadDetail() async {
    final dynamic result = await Api.getAboutUsInfo();
      setState(() {
        _aboutus = result;
      });
      print('.......jjjjjjjjjjj...........kkkkkkkkkkkk........$result');
  }

  ///Build UI
 Widget _buildBanner() {
    String about = _aboutus == null?null:_aboutus.image;
    if (about == null) {
      return Shimmer.fromColors(
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
        enabled: true,
        child: Container(
          color: Colors.white,
        ),
      );
    }

    return Image.network(
      about,
      fit: BoxFit.cover,
    );
  }

  // ///Build UI
  // Widget _buildWhoWeAre() {
  //   if (_aboutUsPage?.whoWeAre == null) {
  //     return Shimmer.fromColors(
  //       baseColor: Theme.of(context).hoverColor,
  //       highlightColor: Theme.of(context).highlightColor,
  //       enabled: true,
  //       child: Column(
  //         children: [1, 2, 3, 4, 5].map((item) {
  //           return Container(
  //             height: 10,
  //             margin: EdgeInsets.only(bottom: 3),
  //             color: Colors.white,
  //           );
  //         }).toList(),
  //       ),
  //     );
  //   }

  //   return Text(
  //     _aboutUsPage.whoWeAre,
  //     style: Theme.of(context).textTheme.bodyText1,
  //   );
  // }

  ///Build UI
  // Widget _buildWhatWeDo() {
  //   if (_aboutUsPage?.whatWeDo == null) {
  //     return Shimmer.fromColors(
  //       baseColor: Theme.of(context).hoverColor,
  //       highlightColor: Theme.of(context).highlightColor,
  //       enabled: true,
  //       child: Column(
  //         children: [1, 2, 3, 4, 5].map((item) {
  //           return Container(
  //             height: 15,
  //             margin: EdgeInsets.only(bottom: 3),
  //             color: Colors.white,
  //           );
  //         }).toList(),
  //       ),
  //     );
  //   }

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: _aboutUsPage.whatWeDo.map((item) {
  //       return Padding(
  //         padding: EdgeInsets.only(bottom: 3),
  //         child: Text(
  //           "$item",
  //           style: Theme.of(context).textTheme.bodyText1,
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

  ///Build UI
  // Widget _buildTeam() {
  //   if (_aboutUsPage?.team == null) {
  //     return Shimmer.fromColors(
  //       baseColor: Theme.of(context).hoverColor,
  //       highlightColor: Theme.of(context).highlightColor,
  //       enabled: true,
  //       child: Wrap(
  //         alignment: WrapAlignment.spaceBetween,
  //         runSpacing: 15,
  //         children: [1, 2, 3, 4].map((item) {
  //           return FractionallySizedBox(
  //             widthFactor: 0.5,
  //             child: Container(
  //               margin: EdgeInsets.only(left: 20),
  //               alignment: Alignment.bottomLeft,
  //               padding: EdgeInsets.all(10),
  //               height: 200,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 color: Colors.white,
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //     );
  //   }

  //   return Wrap(
  //     alignment: WrapAlignment.spaceBetween,
  //     runSpacing: 15,
  //     children: _aboutUsPage.team.map((item) {
  //       return FractionallySizedBox(
  //         widthFactor: 0.5,
  //         child: Container(
  //           margin: EdgeInsets.only(left: 20),
  //           alignment: Alignment.bottomLeft,
  //           padding: EdgeInsets.all(10),
  //           height: 200,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             image: DecorationImage(
  //               image: AssetImage(item.profile_image),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           child: Container(
  //             child: Row(
  //               children: <Widget>[
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Text(
  //                       item.status,
  //                       style: Theme.of(context)
  //                           .textTheme
  //                           .caption
  //                           .copyWith(color: Colors.white),
  //                     ),
  //                     Text(
  //                       item.name,
  //                       style: Theme.of(context).textTheme.subtitle1.copyWith(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.w600,
  //                           ),
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            title: Text(
              Translate.of(context).translate('about_us'),
            ),
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: _buildBanner(),
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Padding(
                          //   padding: EdgeInsets.only(bottom: 5),
                          //   child: Text(
                          //     Translate.of(context).translate('who_we_are'),
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .subtitle1
                          //         .copyWith(fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                          // _buildWhoWeAre(),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 15, bottom: 5),
                          //   child: Text(
                          //     Translate.of(context).translate('what_we_do'),
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .subtitle1
                          //         .copyWith(fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                          // _buildWhatWeDo(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                        left: 20,
                        right: 20,
                      ),
                      child: Text(
                        Translate.of(context).translate('Description'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: _buildTeam(),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //  /Build UI
  Widget _buildTeam() {
    String about = _aboutus == null?null:_aboutus.description;
    if (about == null) {
         return Shimmer.fromColors(
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
        enabled: true,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, width: 50, color: Colors.white),
              ),
              SizedBox(height:20),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(height: 10, color: Colors.white),
              ),
            ],
          ),
        ),
      );

      // return Shimmer.fromColors(
      //   baseColor: Theme.of(context).hoverColor,
      //   highlightColor: Theme.of(context).highlightColor,
      //   enabled: true,
      //   child: Wrap(
      //     alignment: WrapAlignment.spaceBetween,
      //     runSpacing: 15,
      //     children: [1, 2, 3, 4].map((item) {
      //       return FractionallySizedBox(
      //         widthFactor: 0.5,
      //         child: Container(
      //           margin: EdgeInsets.only(left: 20),
      //           alignment: Alignment.bottomLeft,
      //           padding: EdgeInsets.all(10),
      //           height: 200,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: Colors.white,
      //           ),
      //         ),
      //       );
      //     }).toList(),
      //   ),
      // );
    }
    return Container(
      child:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(about,
        style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(height: 1.3),),
      ),
    );          
}
}