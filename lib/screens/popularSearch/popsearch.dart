import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/screens/filter/filter.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/widgets/widget.dart';

class PopSearch extends StatefulWidget {
  @override
  _PopSearchState createState() => _PopSearchState();
}

class _PopSearchState extends State<PopSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search"),
      ),
    );
  }
}

class UserFilterDemo extends StatefulWidget {
  final num id;
  final String neighbourhood;
  UserFilterDemo({this.id, this.neighbourhood}) : super();

  @override
  UserFilterDemoState createState() => UserFilterDemoState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class UserFilterDemoState extends State<UserFilterDemo> {
  final _debouncer = Debouncer(milliseconds: 500);
  List<User> users = List();
  List<User> filteredUsers = List();
  List<ShopModel> _feature = [];
  List<ShopModel> _featuredModel = [];
  Widget appBarTitle = new Text("Search");
  Icon actionIcon = new Icon(Icons.search);
  String searchresult = 'hjdoiuh';
  Color color = Colors.white;
  final textController = TextEditingController();

  List listM =[];
  @override
  void initState() {
    super.initState();
    _loadFeature();
  }

  void _onChangeFilter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Filter()),
    );
  }

  Future<void> _loadFeature() async {
    final List<ShopModel> result = await Api.getShops(id: widget.id);
    setState(() {
      _feature = result;
      _featuredModel = _feature;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: AppTextInput(
                  color: color,
                  hintText: Translate.of(context).translate('search'),
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      searchresult = null;
                    });
                  },
                  controller: textController,
                ),
              ),
            ),
          ],
        ),
      ]),
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 250.0),
              child: GestureDetector(
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
            ),
          ),
          _searchResult(context)
        ],
      ),
    );
  }

  Widget _searchResult(BuildContext context) {
    if (listM == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 200.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sentiment_satisfied),
              ListTile(
                title: Text(
                  "looks like there aren't enough bussiness signed up on ShoplocalTo in your selected neighbourhood.Would you like to view more results near your location ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
      );
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
      //     Wrap(
      // runSpacing: 15,
      // alignment: WrapAlignment.spaceBetween,
      // children: listM.map((item) {
      //   return FractionallySizedBox(
      //     widthFactor: 0.5,
      //     child: Container(
      //       padding: EdgeInsets.only(left: 15,right:15,top:15),
      //       child: AppProductItem(
      //         // onPressshop: _onShopDetail,
      //         shopModel: item,
      //         type: ProductViewType.test,
      //       ),
      //     ),
      //   );
      // }).toList(),
      
      //     )
         Wrap(
        runSpacing: 15,
        alignment: WrapAlignment.spaceBetween,
        children: List.generate(8, (index) => index).map((item) {
          return FractionallySizedBox(
          widthFactor: 0.5,
          child: Container(
            padding: EdgeInsets.only(left: 15,right:15,top:15),
            child: AppCategoryViewItem(
              type: CategoryViewType.gird,
            ),
          ),
        );
        }).toList(),
      )
        ],
      ),
    );
  }
  
}
