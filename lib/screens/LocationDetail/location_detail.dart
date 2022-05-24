import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/screens/location/location.dart';
import 'package:shoplocalto/screens/location_Detail_Tab/location_detail_tab.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoplocalto/screens/screen.dart';

class LocationDetail extends StatefulWidget {
  LocationDetail({Key key, this.id}) : super(key: key);

  final num id;

  @override
  _LocationDetailState createState() {
    return _LocationDetailState();
  }
}

class _LocationDetailState extends State<LocationDetail> {
  bool _like = false;
  PopularModel _popular;
  NearbyModel _nearly;
  // List<RelatedModel> _related;
  List<NearbyModel> _nearby;
  List<ShopModel> _shops;
  bool isLoading = false;
  // bool _showHour = false;
  // ProductDetailPageModel _detailPage;

  @override
  void initState() {
    _loadDetail();
    // _loadNearby();
    print(widget.id);
    _loadVendor();
    // _loadFeature();
    // _loadRelated();
    super.initState();
  }

  Future<void> _loadDetail() async {
    final dynamic result = await Api.getLocationDataDetail(id: widget.id);
    print(
        '.......................................0000000000...................................................${widget.id}');
    setState(() {
      _popular = result;

    });
    print(
        '.....................................0000000000.....................................................${_popular.name}');
  }

  //  Future<void> _loadNearby() async {
  //   final List<NearbyModel> result = await Api.getLocationNearbyDetail(id: widget.id);
  //   print('..............................................222222222............................................${widget.id}');
  //   setState(() {
  //       _nearby = result;
  //     });
  //   print('..............................................222222222............................................${_nearby.length}');
  //   return _nearby;
  // }

  Future<void> _loadVendor() async {
    setState(() {
      isLoading = true;
    });
    final List<ShopModel> result =
        await Api.getLocationShopDetail(id: widget.id);
    print(
        '..............................................222222222............................................${widget.id}');
    setState(() {
      _shops = result;
      isLoading = false;
    });
    return _shops;
  }

  ///On navigate map
  void _onLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Location(
                location: _popular.location,
              )),
    );
  }

  void _onSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>UserFilterDemo(id:_popular.id,neighbourhood: _popular.name,))
    );
  }

  void _onNearbyDetail(NearbyModel item) {
    // String route = item.type == RelatedType.place
    //     ? Routes.locationDetail
    //     : Routes.locationDetailTab;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationDetailTab(id: item.id,)),
    );
    // Navigator.pushNamed(context, Routes.locationDetailTab, arguments: item.id);
  }

  void _onShopDetail(ShopModel item) {
    // String route = item.type == RelatedType.place
    //     ? Routes.locationDetail
    //     : Routes.locationDetailTab;
    Navigator.pushNamed(context, Routes.productDetailTab , arguments: item.id);
  }

  ///On navigate review
  // void _onReview() {
  //   Navigator.pushNamed(context, Routes.review);
  // }

  // ///On like product
  void _onLike() {
    setState(() {
      _like = !_like;
    });
  }

  Widget _buildBanner() {
    if (_popular == null) {
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
      // 'http://dev.shoplocalto.ca/images/neighbourhoods/Eo4lpejKzoXO4UKdu02KUmhdQhVhn9.png',
      _popular.picture,
      fit: BoxFit.cover,
    );
  }
// Widget _buildBanner() {
//     return ListView(
//   scrollDirection: Axis.horizontal, // <-- Like so
//   children: <Widget>[
//     Container(
//       child: Image.asset(Images.Trip1,
//       // "assets/images/trip.png",
//       fit: BoxFit.cover,
//     )),
//     Container(
//       child: Image.asset(Images.Trip2,
//       // "assets/images/trip1.png",
//       fit: BoxFit.cover,
//     )
//     ),
//     Container(
//       child: Image.asset(Images.Trip3,
//       // "assets/images/trip2.png",
//       fit: BoxFit.cover,
//     )
//     ),
//     Container(
//       child: Image.asset(Images.Trip4,
//       // "assets/images/trip3.png",
//       fit: BoxFit.cover,
//     )
//     ),
//     Container(
//       child: Image.asset(Images.Trip5,
//       // "assets/images/trip4.png",
//       fit: BoxFit.cover,
//     )
//     ),
//   ],
// );

//   }
  ///Build info

  // ///Build list feature
  // Widget _buildFeature() {
  //   if ( _nearby == null) {
  //     return Container();
  //   }

  //   return Padding(
  //     padding: EdgeInsets.only(top: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Padding(
  //           padding: EdgeInsets.only(
  //             left: 20,
  //             right: 20,
  //             bottom: 15,
  //           ),
  //           child: Text(
  //             Translate.of(context).translate('featured'),
  //             style: Theme.of(context)
  //                 .textTheme
  //                 .headline6
  //                 .copyWith(fontWeight: FontWeight.w600),
  //           ),
  //         ),
  //         Container(
  //           height: 220,
  //           child: ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             padding: EdgeInsets.only(left: 20),
  //             itemBuilder: (context, index) {
  //               final item = _nearby[index];
  //               return Container(
  //                 width: MediaQuery.of(context).size.width / 2,
  //                 padding: EdgeInsets.only(right: 15),
  //                 child: AppPopularItem(
  //                   onPressNearby: _onNearbyDetail,
  //                   nearbyModel: item,
  //                   type: PopularViewType.gird,
  //                 ),
  //               );
  //             },
  //             itemCount: _nearby.length,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
  Widget _buildInfo() {
    // if (_popular == null) {
    //   return Shimmer.fromColors(
    //     baseColor: Theme.of(context).hoverColor,
    //     highlightColor: Theme.of(context).highlightColor,
    //     enabled: true,
    //     child: Padding(
    //       padding: EdgeInsets.only(left: 20, right: 20),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Container(
    //             margin: EdgeInsets.only(
    //               bottom: 20,
    //               top: 20,
    //             ),
    //             height: 10,
    //             width: 150,
    //             color: Colors.white,
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: <Widget>[
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   Container(
    //                     height: 10,
    //                     width: 100,
    //                     color: Colors.white,
    //                   ),
    //                   Padding(
    //                     padding: EdgeInsets.only(top: 5),
    //                   ),
    //                   Container(
    //                     height: 20,
    //                     width: 150,
    //                     color: Colors.white,
    //                   ),
    //                 ],
    //               ),
    //               Container(
    //                 height: 10,
    //                 width: 100,
    //                 color: Colors.white,
    //               ),
    //             ],
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(top: 25),
    //             child: Container(height: 10, color: Colors.white),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(top: 5),
    //             child: Container(height: 10, color: Colors.white),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(top: 5),
    //             child: Container(height: 10, color: Colors.white),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(top: 5),
    //             child: Container(height: 10, color: Colors.white),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(top: 5),
    //             child: Container(height: 10, color: Colors.white),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(top: 5),
    //             child: Container(height: 10, color: Colors.white),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(top: 5),
    //             child: Container(height: 10, width: 50, color: Colors.white),
    //           )
    //         ],
    //       ),
    //     ),
    //   );
    // }
    // else
      if(_popular.description == null){
       return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _popular.name,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                   IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _onSearch,
                  ),
                  IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: _onLocation,
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
        ],
      ),
    );
    }

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _popular.name,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  IconButton(
                icon: Icon(Icons.search),
                onPressed: _onSearch,
              ),
                  IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: _onLocation,
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Text(
            _popular.description,
            style: Theme.of(context).textTheme.bodyText1.copyWith(height: 1.3),
          ),
        ],
      ),
    );
  }

  ///Build list related
  // Widget _buildNearBy() {
  //   // print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb${_nearby.length}');
  //   if (_nearby == null) {
  //     return Container();
  //   }

  //   return Padding(
  //     padding: EdgeInsets.only(left: 20, right: 20, top: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Padding(
  //           padding: EdgeInsets.only(bottom: 15),
  //           child: Text(
  //             Translate.of(context).translate('NearBy'),
  //             style: Theme.of(context)
  //                 .textTheme
  //                 .headline6
  //                 .copyWith(fontWeight: FontWeight.w600),
  //           ),
  //         ),
  //         Column(
  //           children: _nearby.map((item) {
  //             return Padding(
  //               padding: EdgeInsets.only(bottom: 15),
  //               child: AppPopularItem(
  //                 onPressNearby: _onNearbyDetail,
  //                 nearbyModel: item,
  //                 type: PopularViewType.small,
  //               ),
  //             );
  //           }).toList(),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _buildVendorList() {
    if (_shops == null) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 15,
            ),
            child: Text(
              Translate.of(context).translate('featured'),
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20),
              itemBuilder: (context, index) {
                final item = _shops[index];
                return FractionallySizedBox(
                                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.only(right: 15),
                    child: AppPopularItem(
                      onPressShops: _onShopDetail,
                      shopModel: item,
                      type: PopularViewType.gird,
                    ),
                  ),
                );
              },
              itemCount: _shops.length,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            actions: <Widget>[
              // IconButton(
              //   icon: Icon(Icons.photo_library),
              //   // onPressed: _onPhotoPreview,
              // )
            ],
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
                  children: <Widget>[
                    _buildInfo(),
                    // _buildVendorList(),
                    Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15,right:15,left:15),
                child: Text(
                  'Featured',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
                    _buildList(),
                    // _buildNearBy()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

   Widget _buildList() {
    // if (isLoading) {
    //   return Wrap(
    //     runSpacing: 15,
    //     alignment: WrapAlignment.spaceBetween,
    //     children: List.generate(8, (index) => index).map((item) {
    //       return FractionallySizedBox(
    //       widthFactor: 0.5,
    //       child: Container(
    //         padding: EdgeInsets.only(left: 15,right:15,top:15),
    //         child: AppCategoryViewItem(
    //           type: CategoryViewType.gird,
    //         ),
    //       ),
    //     );
    //     }).toList(),
    //   );
    // }
    List<ShopModel> listM = _shops == null ? [] : _shops;
      // if (listM.isEmpty) {
      //   return Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Icon(Icons.sentiment_satisfied),
      //            ListTile(
      //                                     title: Text(
      //                   "looks like there aren't enough bussiness signed up on ShoplocalTo in your selected category.Would you like to view more results near your location ",
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(fontSize: 13, color: Colors.grey[700]),
      //                 ),
      //               ),
      //       ],
      //     ),
      //   );
      // }

    ///Build list
    return Wrap(
      runSpacing: 15,
      alignment: WrapAlignment.spaceBetween,
      children: listM.map((item) {
        return FractionallySizedBox(
          widthFactor: 0.5,
          child: Container(
            padding: EdgeInsets.only(left: 15,right:15,top:15),
            child: AppCategoryViewItem(
              onPressshop: _onShopDetail,
              shopModel: item,
              type: CategoryViewType.gridpopular,
            ),
          ),
        );
      }).toList(),
      
    );
  }
}
