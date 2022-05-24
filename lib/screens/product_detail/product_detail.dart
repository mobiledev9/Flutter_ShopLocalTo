import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/screens/location/location.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';
  const expandedBannerHeight = 150.0;
class ProductDetail extends StatefulWidget {
  ProductDetail({Key key, this.id = 0}) : super(key: key);

  final num id;

  @override
  _ProductDetailState createState() {
    return _ProductDetailState();
  }
}

class _ProductDetailState extends State<ProductDetail> {
  bool _like = false;
  ProductModel _detail;
  NearlyModel _nearly;
  List<RelatedModel> _related;
  List<FeatureModel> _feature;
  // bool _showHour = false;
  ProductDetailPageModel _detailPage;
List<ImageModel> _images = [];

  @override
  void initState() {
    // _loadData();
    // _loadNearly();
    _loadPhoto();
    _loadDetail();
    _loadFeature();
    _loadRelated();
    super.initState();
  }

  // /Fetch API
  // Future<void> _loadData() async {
  //   final ResultApiModel result = await Api.getProductDetail(id: widget.id);
  //   if (result.success) {
  //     setState(() {
  //       _detailPage = ProductDetailPageModel.fromJson(result.data);
  //       _like = _detailPage?.product?.like;
  //     });
  //   }
  // }
   Future<void> _loadPhoto() async {
    final List<ImageModel> result = await Api.getbannerPhoto(id: widget.id);
    setState(() {
      _images = result;
    });
    print('ImageModel list *****88888888888888888888*******:${_images.length}');
  }
  Future<void> _loadDetail() async {
    final dynamic result = await Api.getShopDataDetail(id: widget.id);
    // print('id is .................${widget.id}');
    setState(() {
        _detail = result;
      });
      // print('featureModel is .................${_detail.nearly.length}');
  }
   Future<void> _loadFeature() async {
    final List<FeatureModel> result = await Api.getFeatureDetail(id: widget.id);
    // print('id is .................${widget.id}');
    setState(() {
        _feature = result;
      });
      // print('featureModel is .................${_feature.length}');
  }

   Future<void> _loadRelated() async {
    final List<RelatedModel> result = await Api.getRelatedDetail(id: widget.id);
    // print('id is .................${widget.id}');
    setState(() {
        _related = result;
      });
      // print('..........................Related is .................${_related.length}');
  }

  // Future<void> _loadNearly() async {
  //   final NearlyModel result = await Api.getNearlyDetail(id: widget.id);
  //   setState(() {
  //       _nearly = result;
  //     });
  // }

  ///On navigate gallery
  // void _onPhotoPreview() {
  //   Navigator.pushNamed(
  //     context,
  //     Routes.gallery,
  //     arguments: _detail.photo,
  //   );
  // }

  ///On navigate map
  void _onLocation() {
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Location(location: _detail.location)),
            );
    // List<LocationModel> detail = _detail==null?[]:_detail.location;
    // Navigator.pushNamed(
    //   context,
    //   Routes.location,
    //   arguments: _detail.location,
    // );
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    String route = item.type == ProductType.place
        ? Routes.productDetail
        : Routes.productDetailTab;
    Navigator.pushNamed(context, route, arguments: item.id);
  }
  void _onRelatedDetail(RelatedModel item) {
    String route = item.type == RelatedType.place
        ? Routes.productDetail
        : Routes.productDetailTab;
    Navigator.pushNamed(context, route, arguments: item.id);
  }
  void _onFeatureDetail(FeatureModel item) {
    String route = item.type == FeatureType.place
        ? Routes.productDetail
        : Routes.productDetailTab;
    Navigator.pushNamed(context, route, arguments: item.id);
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
   if (_detail == null) {
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
      _detail.image,
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
  Widget _buildInfo() {
    if (_detail == null) {
      return Shimmer.fromColors(
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
        enabled: true,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  top: 20,
                ),
                height: 10,
                width: 150,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Container(
                        height: 20,
                        width: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                    width: 100,
                    color: Colors.white,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
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
                          height: 10,
                          width: 200,
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
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
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
                          height: 10,
                          width: 200,
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
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
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
                          height: 10,
                          width: 200,
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
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
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
                          height: 10,
                          width: 200,
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
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
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
                          height: 10,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
              )
            ],
          ),
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
                _detail.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: Icon(Icons.location_on),
                onPressed: _onLocation,
              ),
             
            ],
          ),
         
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Text(
            _detail.description,
            style: Theme.of(context).textTheme.bodyText1.copyWith(height: 1.3),
          ),
        ],
      ),
    );
  }

  ///Build list feature
  Widget _buildFeature() {
    if (_feature == null) {
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
                final item = _feature[index];
                return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.only(right: 15),
                  child: AppProductItem(
                    onPressFeature: _onFeatureDetail,
                    featureModel: item,
                    type: ProductViewType.gird,
                  ),
                );
              },
              itemCount: _feature.length,
            ),
          )
        ],
      ),
    );
  }

  ///Build list related
  Widget _buildRelated() {
    if (_related == null) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              Translate.of(context).translate('Ordinary Listings'),
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            children: _related.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: AppProductItem(
                  onPressRelated: _onRelatedDetail,//Ordinary
                  relatedModel: item,
                  type: ProductViewType.small,
                ),
              );
            }).toList(),
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
              //   onPressed: _onPhotoPreview,
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
                    _buildFeature(),
                    _buildRelated()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  
}
