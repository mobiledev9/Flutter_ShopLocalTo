
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../home/home_controller.dart';

class WishList extends StatefulWidget {
  WishList({Key key}) : super(key: key);

  @override
  _WishListState createState() {
    return _WishListState();
  }
}

class _WishListState extends State<WishList> {
  final HomeController _homeController = Get.put(HomeController());
  final _controller = RefreshController(initialRefresh: false);
  WishListPageModel _listPage;
  bool loading = false;
// List<ShopModel> _wishlistPage = [];
  @override
  void initState() {
    // _loadData();
    // _onRefresh();
    _loadWishlist();
    super.initState();
  }

  ///Fetch API
  // Future<void> _loadData() async {
  //   final ResultApiModel result = await Api.getWishList();
  //   if (result.success) {
  //     setState(() {
  //       _listPage = new WishListPageModel.fromJson(result.data);
  //     });
  //   }
  // }
  Future<void> _loadWishlist() async {
    setState(() {
      loading = true;
    });
    final dynamic result = await Api.getWishList();
    setState(() {
      _listPage = result;
    });
    setState(() {

      loading = false;
    });

  }
  ///On load more
  Future<void> _onLoading() async {
    await Future.delayed(Duration(seconds: 1));
    _controller.loadComplete();
  }

  ///On refresh
  Future<void> _onRefresh() async {
    _loadWishlist();
    await Future.delayed(Duration(seconds: 1));
    _controller.refreshCompleted();

  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    String route = item.type == ProductType.place
        ? Routes.productDetail
        : Routes.productDetailTab;
    Navigator.pushNamed(context, route, arguments: item.id);
  }

  // ///BuildList Sanjana
  // Widget _buildWishList() {
  //   if (_wishlistPage == null) {
  //     return ListView(
  //       padding: EdgeInsets.only(
  //         left: 20,
  //         right: 20,
  //         top: 15,
  //       ),
  //       children: List.generate(8, (index) => index).map(
  //         (item) {
  //           return Padding(
  //             padding: EdgeInsets.only(bottom: 15),
  //             child: AppProductItem(type: ProductViewType.block),
  //           );
  //         },
  //       ).toList(),
  //     );
  //   }

  //   return ListView.builder(
  //     padding: EdgeInsets.only(
  //       left: 20,
  //       right: 20,
  //       top: 15,
  //     ),
  //     itemCount: _wishlistPage.length,
  //     itemBuilder: (context, index) {
  //       final item =_wishlistPage[index];
  //       return Padding(
  //         padding: EdgeInsets.only(bottom: 15),
  //         child: AppProductItem(
  //           onPressed: _onProductDetail,
  //           wishlistModel: item,
  //           type: ProductViewType.block,
  //         ),
  //       );
  //     },
  //   );
  // }

  ///Build list
  Widget _buildList() {

    // if(loading==true){
    //   return ListView(
    //     padding: EdgeInsets.only(
    //       left: 20,
    //       right: 20,
    //       top: 15,
    //     ),
    //     children: List.generate(8, (index) => index).map(
    //           (item) {
    //         return Padding(
    //           padding: EdgeInsets.only(bottom: 15),
    //           child: AppProductItem(type: ProductViewType.blocksmall),
    //         );
    //       },
    //     ).toList(),
    //   );
    // }
    List<ProductModel> listM = _listPage == null ? [] : _listPage.list;
    if (listM.isEmpty && loading == false) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.sentiment_satisfied),
            Padding(
              padding: EdgeInsets.all(3.0),
              child: Text(
                Translate.of(context).translate('Wishlist is empty pull down to refresh'),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      );
    }

    return loading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 15,
      ),
      itemCount: listM.length,
      itemBuilder: (context, index) {
        final item = listM[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: AppProductItem(
            onPressed: _onProductDetail,
            item: item,
            type: ProductViewType.blocksmall,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: _homeController.fromnav == true.obs ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _homeController.fromnav = false.obs;
            Navigator.pop(context);
          },
        ) : Container(),
        title: Text(Translate.of(context).translate('wish_list')),
      ),
      body: SafeArea(
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
          child: _buildList(),
        ),
      ),
    );
  }
}
