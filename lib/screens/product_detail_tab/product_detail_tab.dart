import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/wishlist/wishlist_bloc.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoplocalto/screens/location/location.dart';
import 'package:shoplocalto/screens/product_detail_tab/product_tab_bar.dart';
import 'package:shoplocalto/screens/product_detail_tab/product_tab_controller.dart';
import 'package:shoplocalto/screens/review/review.dart';
import '../ChatMe/chatme.dart';
import '../chat/chat.dart';
import 'product_extend_header.dart';
import 'product_tab_content.dart';

const appBarHeight = 200.0;
const expandedBarHeight = 100.0;
const tabHeight = 50.0;

class ProductDetailTab extends StatefulWidget {
  ProductDetailTab({Key key, this.id = 0}) : super(key: key);

  final num id;

  @override
  _ProductDetailTabState createState() {
    return _ProductDetailTabState();
  }
}

class _ProductDetailTabState extends State<ProductDetailTab> {
  final _tabController = ScrollController();
  final _scrollController = ScrollController();
  int activeTab = 0;
  List<double> _offsetContentOrigin = [];
  List<num> wishlist = [];
  int _indexTab = 0;
  ProductDetailTabPageModel _page;
  bool wish;
  bool _like = false;
  ProductModel productModel;
  final ProducttabController _producttabController =
  Get.put(ProducttabController());
  @override
  void initState() {
    // _scrollController.addListener(_scrollListener);
    _loadData();
    setState(() {
      _producttabController.producttab.value = 0;
    });
    super.initState();
  }

  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getLoadTabDetail(
      tabExtend: true,
      id: widget.id,
    );
    setState(() {
      _page = ProductDetailTabPageModel.fromJson(result.data);
    });
    print(
        '....................................getLoadTabDetail.....${_page.product.marketplace}');
    Timer(Duration(milliseconds: 150), () {
      _setOriginOffset();
    });
  }

  //   Future<void> _loadData() async {
  //   final ResultApiModel result = await Api.getProductDetail(
  //     tabExtend: true,
  //     id: widget.id,
  //   );
  //   if (result.success) {
  //     setState(() {
  //       _page = ProductDetailTabPageModel.fromJson(result.data);
  //     });
  //     Timer(Duration(milliseconds: 150), () {
  //       _setOriginOffset();
  //     });
  //   }
  // }

  ///ScrollListenerEvent
  void _scrollListener() {
    if (_page?.tab != null) {
      activeTab = 0;
      double offsetTab;
      double widthDevice = MediaQuery.of(context).size.width;
      double itemSize = widthDevice / 3;
      double offsetStart = widthDevice / 2 - itemSize / 2;

      int indexCheck = _offsetContentOrigin.indexWhere((item) {
        return item - 1 > _scrollController.offset;
      });
      if (indexCheck == -1) {
        activeTab = _offsetContentOrigin.length - 1;
        offsetTab = offsetStart + itemSize * (activeTab - 3);
      } else if (indexCheck > 0) {
        activeTab = indexCheck - 1 > 0 ? indexCheck - 1 : 0;
        offsetTab =
            activeTab > 1 ? offsetStart + itemSize * (activeTab - 2) : 0;
      }

      if (activeTab != _indexTab) {
        setState(() {
          log(activeTab.toString());
          _indexTab = activeTab;
        });
      }
      if (offsetTab != null) {
        _tabController.jumpTo(offsetTab);
      }
    }
  }

  ///Set Origin Offset default when render success
  void _setOriginOffset() {
    if (_page?.tab != null && _offsetContentOrigin.isEmpty) {
      setState(() {
        _offsetContentOrigin = _page.tab.map((item) {
          final RenderBox box =
              item.keyContentItem.currentContext.findRenderObject();
          final position = box.localToGlobal(Offset.zero);
          return position.dy +
              _scrollController.offset -
              tabHeight -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top;
        }).toList();
      });
    }
  }

  ///On Change tab jumpTo offset
  ///Scroll controller will handle setState active tab
  void _onChangeTab(int index) {
    setState(() {
      activeTab = index;
      _producttabController.producttab.value = index;
      print("tab : ${_producttabController.producttab.value}");
    });
    if (_offsetContentOrigin.isNotEmpty) {
      _scrollController.animateTo(
        _offsetContentOrigin[index] + 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
      log(_offsetContentOrigin.toString());
    }
  }

  ///On navigate gallery
  void _onPhotoPreview() {
    Navigator.pushNamed(
      context,
      Routes.gallery,
      arguments: _page?.product?.photo,
    );
  }

  // ///On navigate map
  // void _onLocation() {
  //   Navigator.pushNamed(
  //     context,
  //     Routes.location,
  //     arguments: _page?.product?.location,
  //   );
  // }

  void _onLocation() {
    ProductModel product = _page == null ? null : _page.product;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Location(
                location: product.location,
              )),
    );
  }

  ///On navigate review
  void _onReview() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Review()),
    );
  }

  ///On navigate product detail
  void _onProductDetail(item) {
    Navigator.pushNamed(context, Routes.productDetailTab, arguments: item.id);
  }

  Future<void> _onSend() async {
    final chat = MessageModel.fromJson({
      "id": widget.id,
      "message": "Lets Chat",
      "date": DateFormat.jm().format(DateTime.now()),
      "status": "sent"
    });

    await Api.chatWithUs(
      comment: chat.message,
      companyid: chat.id,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Chat(
                id: widget.id,
              )),
    );
    // _textChatController.clear();

    // _textChatController.text = '';
    // UtilOther.hiddenKeyboard(context);
  }

  ///On like product
  Future<void> _onLike() async {
    setState(() {
      _like = !_like;
      wish = true;
    });

    final dynamic result = await Api.addwishList(
      id: widget.id,
    );
    print('widget.id${widget.id}');
    if (result['status'] == 'success') {
      log(result['status'].toString());
      setState(() {
        _like = true;
        wish = true;
      });
    }
  }

  Future<void> _onunLike() async {
    setState(() {
      _like = !_like;
      wish = false;
    });
    final dynamic result = await Api.removewishList(
      id: widget.id,
    );
    print('widget.id${widget.id}');
    if (result['status'] == 'success') {
      log(result['status'].toString());
      setState(() {
        _like = false;
        wish = false;
      });
    }
  }

  ///Build banner UI
  Widget _buildBanner() {
    String productMdl = _page == null ? null : _page.product.image;
    if (productMdl == null) {
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
      productMdl,
      fit: BoxFit.cover,
    );
  }

  // /Build Tab Content UI
  ///Build Tab Content UI
  Widget _buildTabContent() {
    List<TabModel> tabs = _page == null ? [] : _page.tab;
    if (tabs == null) {
      return Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Shimmer.fromColors(
          baseColor: Theme.of(context).hoverColor,
          highlightColor: Theme.of(context).highlightColor,
          enabled: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(5, (index) => index).map(
              (item) {
                return Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 8)),
                    Container(height: 32, color: Colors.white),
                  ],
                );
              },
            ).toList(),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tabs.map((item) {
        return TabContent(
            item: item, page: _page, onNearlyModelDetail: _onProductDetail);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    productModel = _page == null ? null : _page.product;
    wish = productModel == null ? null : productModel.wishlist;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            leading: Padding(
              padding:  EdgeInsets.only(left: 10,top: 10),
              child: Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  color: Theme.of(context).buttonColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            expandedHeight: appBarHeight,
            pinned: true,
            actions: <Widget>[
              Padding(
                padding:  EdgeInsets.only(right: 10,top: 10),
                child: GestureDetector(
                  onTap: _onLocation,
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.location_pin),


                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: _buildBanner(),
            ),
          ),
          SliverPersistentHeader(
            pinned: false,
            floating: false,
            delegate: ProductHeader(
              height: expandedBarHeight,
              productTabPage: _page,
              onMessagesend: _onSend,
              onPressLike: _onLike,
              onPressunLike: _onunLike,
              onPressReview: _onReview,
              onLocation: _onLocation,
              like: _like ? !wish : wish,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: ProductTabBar(
              height: tabHeight,
              tabController: _tabController,
              onIndexChanged: _onChangeTab,
              indexTab: activeTab,
              tab: _page?.tab,
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: _buildTabContent(),
            ),
          )
        ],
      ),
    );
  }
}

// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:shoplocalto/api/api.dart';
// import 'package:shoplocalto/configs/config.dart';
// import 'package:shoplocalto/models/model.dart';
// import 'package:shoplocalto/models/screen_models/screen_models.dart';
// import 'package:shimmer/shimmer.dart';

// import 'product_extend_header.dart';
// import 'product_tab_bar.dart';
// import 'product_tab_content.dart';

// const appBarHeight = 200.0;
// const expandedBarHeight = 150.0;
// const tabHeight = 50.0;

// class ProductDetailTab extends StatefulWidget {
//   ProductDetailTab({Key key, this.id = 0}) : super(key: key);

//   final num id;

//   @override
//   _ProductDetailTabState createState() {
//     return _ProductDetailTabState();
//   }
// }

// class _ProductDetailTabState extends State<ProductDetailTab> {
//   final _tabController = ScrollController();
//   final _scrollController = ScrollController();

//   bool _like = false;
//   List<double> _offsetContentOrigin = [];
//   int _indexTab = 0;
//   ProductDetailTabPageModel _page;

//   @override
//   void initState() {
//     _scrollController.addListener(_scrollListener);
//     _loadData();
//     super.initState();
//   }

//   ///Fetch API
//   Future<void> _loadData() async {
//     final ResultApiModel result = await Api.getProductDetail(
//       tabExtend: true,
//       id: widget.id,
//     );
//     if (result.success) {
//       setState(() {
//         _page = ProductDetailTabPageModel.fromJson(result.data);
//       });
//       Timer(Duration(milliseconds: 150), () {
//         _setOriginOffset();
//       });
//     }
//   }

//   ///ScrollListenerEvent
//   void _scrollListener() {
//     if (_page?.tab != null) {
//       int activeTab = 0;
//       double offsetTab;
//       double widthDevice = MediaQuery.of(context).size.width;
//       double itemSize = widthDevice / 3;
//       double offsetStart = widthDevice / 2 - itemSize / 2;

//       int indexCheck = _offsetContentOrigin.indexWhere((item) {
//         return item - 1 > _scrollController.offset;
//       });
//       if (indexCheck == -1) {
//         activeTab = _offsetContentOrigin.length - 1;
//         offsetTab = offsetStart + itemSize * (activeTab - 3);
//       } else if (indexCheck > 0) {
//         activeTab = indexCheck - 1 > 0 ? indexCheck - 1 : 0;
//         offsetTab =
//             activeTab > 1 ? offsetStart + itemSize * (activeTab - 2) : 0;
//       }

//       if (activeTab != _indexTab) {
//         setState(() {
//           log(activeTab.toString());
//           _indexTab = activeTab;
//         });
//       }
//       if (offsetTab != null) {
//         _tabController.jumpTo(offsetTab);
//       }
//     }
//   }

//   ///Set Origin Offset default when render success
//   void _setOriginOffset() {
//     if (_page?.tab != null && _offsetContentOrigin.isEmpty) {
//       setState(() {
//         _offsetContentOrigin = _page.tab.map((item) {
//           final RenderBox box =
//               item.keyContentItem.currentContext.findRenderObject();
//           final position = box.localToGlobal(Offset.zero);
//           return position.dy +
//               _scrollController.offset -
//               tabHeight -
//               AppBar().preferredSize.height -
//               MediaQuery.of(context).padding.top;
//         }).toList();
//       });
//     }
//   }

//   ///On Change tab jumpTo offset
//   ///Scroll controller will handle setState active tab
//   void _onChangeTab(int index) {
//     if (_offsetContentOrigin.isNotEmpty) {
//       _scrollController.animateTo(
//         _offsetContentOrigin[index] + 1,
//         duration: Duration(milliseconds: 500),
//         curve: Curves.easeInOutCubic,
//       );
//       log(_offsetContentOrigin.toString());
//     }
//   }

//   ///On navigate gallery
//   void _onPhotoPreview() {
//     Navigator.pushNamed(
//       context,
//       Routes.gallery,
//       arguments: _page?.product?.photo,
//     );
//   }

//   ///On navigate map
//   void _onLocation() {
//     Navigator.pushNamed(
//       context,
//       Routes.location,
//       arguments: _page?.product?.location,
//     );
//   }

//   ///On navigate review
//   void _onReview() {
//     Navigator.pushNamed(context, Routes.review);
//   }

//   ///On navigate product detail
//   void _onProductDetail(item) {
//     Navigator.pushNamed(context, Routes.productDetail, arguments: item.id);
//   }

//   ///On like product
//   void _onLike() {
//     setState(() {
//       _like = !_like;
//     });
//   }

//   ///Build banner UI
//   Widget _buildBanner() {
//     if (_page?.product?.image == null) {
//       return Shimmer.fromColors(
//         baseColor: Theme.of(context).hoverColor,
//         highlightColor: Theme.of(context).highlightColor,
//         enabled: true,
//         child: Container(
//           color: Colors.white,
//         ),
//       );
//     }

//     return Image.asset(
//       _page?.product?.image,
//       fit: BoxFit.cover,
//     );
//   }

//   ///Build Tab Content UI
//   Widget _buildTabContent() {
//     if (_page?.tab == null) {
//       return Padding(
//         padding: EdgeInsets.only(left: 20, right: 20),
//         child: Shimmer.fromColors(
//           baseColor: Theme.of(context).hoverColor,
//           highlightColor: Theme.of(context).highlightColor,
//           enabled: true,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(8, (index) => index).map(
//               (item) {
//                 return Column(
//                   children: <Widget>[
//                     Padding(padding: EdgeInsets.only(top: 8)),
//                     Container(height: 32, color: Colors.white),
//                   ],
//                 );
//               },
//             ).toList(),
//           ),
//         ),
//       );
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: _page.tab.map((item) {
//         return TabContent(
//             item: item, page: _page, onProductDetail: _onProductDetail);
//       }).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         controller: _scrollController,
//         slivers: <Widget>[
//           SliverAppBar(
//             expandedHeight: appBarHeight,
//             pinned: true,
//             actions: <Widget>[
//               IconButton(
//                 icon: Icon(Icons.map),
//                 onPressed: _onLocation,
//               ),
//               IconButton(
//                 icon: Icon(Icons.photo_library),
//                 onPressed: _onPhotoPreview,
//               )
//             ],
//             flexibleSpace: FlexibleSpaceBar(
//               collapseMode: CollapseMode.parallax,
//               background: _buildBanner(),
//             ),
//           ),
//           SliverPersistentHeader(
//             pinned: false,
//             floating: false,
//             delegate: ProductHeader(
//               height: expandedBarHeight,
//               productTabPage: _page,
//               like: _like,
//               onPressLike: _onLike,
//               onPressReview: _onReview,
//             ),
//           ),
//           SliverPersistentHeader(
//             pinned: true,
//             floating: false,
//             delegate: ProductTabBar(
//               height: tabHeight,
//               tabController: _tabController,
//               onIndexChanged: _onChangeTab,
//               indexTab: _indexTab,
//               tab: _page?.tab,
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: SafeArea(
//               top: false,
//               child: _buildTabContent(),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
