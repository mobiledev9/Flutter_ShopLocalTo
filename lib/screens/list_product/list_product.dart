import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/screens/filter/filter.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum PageType { map, list }

class ListProduct extends StatefulWidget {
  final String title;
  final num id;

  ListProduct({Key key, this.title = 'Place', this.id = 0}) : super(key: key);

  @override
  _ListProductState createState() {
    return _ListProductState();
  }
}

class _ListProductState extends State<ListProduct> {
  final _controller = RefreshController(initialRefresh: false);
  final _swipeController = SwiperController();

  // GoogleMapController _mapController;
  int _indexLocation = 0;
  // MapType _mapType = MapType.normal;
  // CameraPosition _initPosition;
  // Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  PageType _pageType = PageType.list;
  CategoryViewType _modeView = CategoryViewType.gird;
  ProductListPageModel _productList;
  SortModel _currentSort = AppSort.defaultSort;
  List<SortModel> _listSort = AppSort.listSortDefault;
  bool isLoading = false;
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  ///On Fetch API
  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    final dynamic result = await Api.getList(id: widget.id);
    setState(() {
      isLoading = false;
      _productList = result;
    });
// print('....................................get  L IST...........${widget.id}');
    final listProduct = result;
print('....................................get  L IST...........${_productList.list.length}');
    ///Setup list marker map from list
    _productList.list.forEach((item) {
    //   final markerId = MarkerId(item.id.toString());
    //   final marker = Marker(
    //     markerId: markerId,
    //     position: LatLng(item.location.lat, item.location.long),
    //     infoWindow: InfoWindow(title: item.title),
    //     onTap: () {
    //       _onSelectLocation(item);
    //     },
    //   );
    //   print('${item.title}');
    //     print('${item.location.lat}');
    //     print('${item.location.long}');
    //   _markers[markerId] = marker;
    //    setState(() {
    //   _productList = listProduct;
    //   _initPosition = CameraPosition(
    //     target: LatLng(
    //       item.location.lat,
    //       item.location.long,
    //     ),
    //     zoom: 14.4746,
    //   );
    // });
    });
// ****************************Required when data is not empty***********
// if(_productList.list.isNotEmpty){
//  setState(() {
//       _productList = listProduct;
//       _initPosition = CameraPosition(
//         target: LatLng(
//           listProduct.list[0].location.lat,
//           listProduct.list[0].location.long,
//         ),
//         zoom: 14.4746,
//       );
//     });
// }
    // **************************************************************
  }

  ///On Load More
  Future<void> _onLoading() async {
    await Future.delayed(Duration(seconds: 1));
    _controller.loadComplete();
  }

  ///On Refresh List
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    _controller.refreshCompleted();
  }

  ///On Change Sort
  void _onChangeSort() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return AppModelBottomSheet(
          selected: _currentSort,
          option: _listSort,
          onChange: (item) {
            setState(() {
              _currentSort = item;
            });
          },
        );
      },
    );
  }

  ///On Change View
  void _onChangeView() {
    switch (_modeView) {
      case CategoryViewType.gird:
        _modeView = CategoryViewType.list;
        break;
      case CategoryViewType.list:
        _modeView = CategoryViewType.block;
        break;
      case CategoryViewType.block:
        _modeView = CategoryViewType.gird;
        break;
      default:
        return;
    }
    setState(() {
      _modeView = _modeView;
    });
  }

  ///On change filter
  void _onChangeFilter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Filter()),
    );

  }

  ///On change page
  void _onChangePageStyle() {
    switch (_pageType) {
      case PageType.list:
        setState(() {
          _pageType = PageType.map;
        });
        return;
      case PageType.map:
        setState(() {
          _pageType = PageType.list;
        });
        return;
    }
  }

  ///On change map style
  void _onChangeMapStyle() {
    // MapType type = _mapType;
    // switch (_mapType) {
    //   case MapType.normal:
    //     type = MapType.hybrid;
    //     break;
    //   case MapType.hybrid:
    //     type = MapType.normal;
    //     break;
    //   default:
    //     type = MapType.normal;
    //     break;
    // }
    // setState(() {
    //   _mapType = type;
    // });
  }

  ///On tap marker map location
  void _onSelectLocation(ListModel item) {
    final index = _productList.list.indexOf(item);
    _swipeController.move(index);
  }

  ///Handle Index change list map view
  void _onIndexChange(int index) {
    setState(() {
      _indexLocation = index;
    });

    ///Camera animated
    // _mapController.animateCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //       bearing: 270.0,
    //       target: LatLng(
    //         _productList.list[_indexLocation].location.lat,
    //         _productList.list[_indexLocation].location.long,
    //       ),
    //       tilt: 30.0,
    //       zoom: 15.0,
    //     ),
    //   ),
    // );
  }

  ///On navigate product detail
  void _onProductDetail(ListModel item) {
    String route = item.type == ListType.place
        ? Routes.productDetail
        : Routes.productDetailTab;
    Navigator.pushNamed(context, route, arguments: item.id);
  }

  ///On search
  // void _onSearch() {
  //   Navigator.pushNamed(context, Routes.searchHistory);
  // }

  ///Export Icon for Mode View
  IconData _exportIconView() {
    switch (_modeView) {
      case CategoryViewType.list:
        return Icons.view_list;
      case CategoryViewType.gird:
        return Icons.view_quilt;
      case CategoryViewType.block:
        return Icons.view_array;
      default:
        return Icons.help;
    }
  }

  ///_build Item Loading
  Widget _buildItemLoading(CategoryViewType type) {
    switch (type) {
      case CategoryViewType.gird:
        return FractionallySizedBox(
          widthFactor: 0.5,
          child: Container(
            padding: EdgeInsets.only(left: 15),
            child: AppCategoryViewItem(
              type: _modeView,
            ),
          ),
        );

      case CategoryViewType.list:
        return Container(
          padding: EdgeInsets.only(left: 15),
          child: AppCategoryViewItem(
            type: _modeView,
          ),
        );

      default:
        return AppCategoryViewItem(
          type: _modeView,
        );
    }
  }

  ///_build Item
  Widget _buildItem(ListModel item, CategoryViewType type) {
    switch (type) {
      case CategoryViewType.gird:
        return FractionallySizedBox(
          widthFactor: 0.5,
          child: Container(
            padding: EdgeInsets.only(left: 15),
            child: AppCategoryViewItem(
              onPressed: _onProductDetail,
              item: item,
              type: _modeView,
            ),
          ),
        );

      case CategoryViewType.list:
        return Container(
          padding: EdgeInsets.only(left: 15),
          child: AppCategoryViewItem(
            onPressed: _onProductDetail,
            item: item,
            type: _modeView,
          ),
        );

      default:
        return AppCategoryViewItem(
          onPressed: _onProductDetail,
          item: item,
          type: _modeView,
        );
    }
  }

  ///Widget build Content
  Widget _buildList() {
    if (isLoading) {
      log(isLoading.toString());
      return Wrap(
        runSpacing: 15,
        alignment: WrapAlignment.spaceBetween,
        children: List.generate(8, (index) => index).map((item) {
          return _buildItemLoading(_modeView);
        }).toList(),
      );
    }
    List<ListModel> listM = _productList == null ? [] : _productList.list;
      if (listM.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sentiment_satisfied),
                 ListTile(
                                          title: Text(
                        "looks like there aren't enough bussiness signed up on ShoplocalTo in your selected category.Would you like to view more results near your location ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ),
            ],
          ),
        );
      }

    ///Build list
    return Wrap(
      runSpacing: 15,
      alignment: WrapAlignment.spaceBetween,
      children: listM.map((item) {
        return _buildItem(item, _modeView);
      }).toList(),
      
    );
  }

  ///Build Content Page Style
  Widget _buildContent() {
    if (_pageType == PageType.list) {
      return SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: _controller,
          header: ClassicHeader(
            idleText: Translate.of(context).translate('pull_down_refresh'),
            refreshingText: Translate.of(context).translate('refreshing'),
            completeText: Translate.of(context).translate('refresh_completed'),
            releaseText: Translate.of(context).translate('release_to_refresh'),
            refreshingIcon: SizedBox(
              width: 16.0,
              height: 16.0,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          footer: ClassicFooter(
            loadingText: Translate.of(context).translate('loading'),
            canLoadingText: Translate.of(context).translate(
              'release_to_load_more',
            ),
            idleText: Translate.of(context).translate('pull_to_load_more'),
            loadStyle: LoadStyle.ShowWhenLoading,
            loadingIcon: SizedBox(
              width: 16.0,
              height: 16.0,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: _modeView == CategoryViewType.block ? 0 : 5,
              right: _modeView == CategoryViewType.block ? 0 : 20,
              bottom: 15,
            ),
            child: _buildList(),
          ),
        ),
      );
    }

    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // GoogleMap(
          //   onMapCreated: (controller) {
          //     _mapController = controller;
          //   },
          //   mapType: _mapType,
          //   initialCameraPosition: _initPosition,
          //   markers: Set<Marker>.of(_markers.values),
          //   myLocationEnabled: false,
          // ),
          SafeArea(
            bottom: false,
            top: false,
            child: Container(
              height: 210,
              margin: EdgeInsets.only(bottom: 15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 36,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).dividerColor,
                                blurRadius: 5,
                                spreadRadius: 1.0,
                                offset: Offset(1.5, 1.5),
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.directions,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).dividerColor,
                                  blurRadius: 5,
                                  spreadRadius: 1.0,
                                  offset: Offset(1.5, 1.5),
                                )
                              ],
                            ),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Swiper(
                      itemBuilder: (context, index) {
                        final ListModel item = _productList.list[index];
                        return Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: _indexLocation == index
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).dividerColor,
                                  blurRadius: 5,
                                  spreadRadius: 1.0,
                                  offset: Offset(1.5, 1.5),
                                )
                              ],
                            ),
                            child: AppCategoryViewItem(
                              onPressed: _onProductDetail,
                              item: item,
                              type: CategoryViewType.list,
                            ),
                          ),
                        );
                      },
                      controller: _swipeController,
                      onIndexChanged: (index) {
                        _onIndexChange(index);
                      },
                      itemCount: _productList.list.length,
                      viewportFraction: 0.8,
                      scale: 0.9,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: _onSearch,
          // ),
          Visibility(
            visible: _productList?.list != null,
            child: IconButton(
              icon: Icon(
                _pageType == PageType.map
                    ? Icons.view_compact
                    : Icons.location_on,
              ),
              onPressed: _onChangePageStyle,
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SafeArea(
            top: false,
            bottom: false,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // IconButton(
                      //   icon: Icon(_currentSort.icon),
                      //   onPressed: _onChangeSort,
                      // ),
                      // Text(
                      //   Translate.of(context).translate(_currentSort.name),
                      //   style: Theme.of(context).textTheme.subtitle2,
                      // )
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, bottom: 10),
                        child: Text(
                          "Category listing",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Visibility(
                        visible: _pageType == PageType.list,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(_exportIconView()),
                              onPressed: _onChangeView,
                            ),
                            Container(
                              height: 24,
                              child: VerticalDivider(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _pageType != PageType.list,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                // _mapType == MapType.normal
                                //     ? Icons.satellite
                                //     :
                                Icons.map,
                              ),
                              onPressed: _onChangeMapStyle,
                            ),
                            Container(
                              height: 24,
                              child: VerticalDivider(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // **************************REQUIRED FEILD FILTER*********************************************
                      GestureDetector(
                        onTap:_onChangeFilter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // Visibility(
                            //   visible: _pageType == PageType.list,
                            //   child: Row(
                            //     children: <Widget>[
                            //       IconButton(
                            //         icon: Icon(_exportIconView()),
                            //         onPressed: _onChangeView,
                            //       ),
                            //       Container(
                            //         height: 24,
                            //         child: VerticalDivider(
                            //           color: Theme.of(context).dividerColor,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Visibility(
                            //   visible: _pageType != PageType.list,
                            //   child: Row(
                            //     children: <Widget>[
                            //       IconButton(
                            //         icon: Icon(
                            //           _mapType == MapType.normal
                            //               ? Icons.satellite
                            //               : Icons.map,
                            //         ),
                            //         onPressed: _onChangeMapStyle,
                            //       ),
                            //       Container(
                            //         height: 24,
                            //         child: VerticalDivider(
                            //           color: Theme.of(context).dividerColor,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // **************************REQUIRED FEILD FILTER*********************************************
                            IconButton(
                              icon: Icon(Icons.track_changes),

                            ),
                            Text(
                              Translate.of(context).translate('filter'),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                            // ************************************************************************************
                          ],
                        ),
                      )
                      // ************************************************************************************
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: _buildContent(),
          )
        ],
      ),
    );
  }
}
