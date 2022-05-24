import 'dart:async';
import 'dart:developer';

// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/main_navigation.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/screens/home/home_category_list.dart';
import 'package:shoplocalto/screens/home/home_category_page.dart';
import 'package:shoplocalto/screens/home/home_sliver_app_bar.dart';
import 'package:shoplocalto/screens/screen.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shoplocalto/screens/list_product/list_product.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../widgets/app_navigation_drawer.dart';

class Home extends StatefulWidget {
  Home({
    Key key,
    this.id,
  }) : super(key: key);
  final int id;

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  HomePageModel _homePage;
  PopularPageModel _popularPageModel;

  bool _tryAgain = false;
  // ******************REQUIRED*****************
  List<Address> addresses;
  List<Address> address;
  Address first;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Address old;
  Position _currentPosition;
  Position _lastKnown;
  final Geolocator geolocator = Geolocator();
  CategoryModel2 _categoryModel2;
  String locationName;
  List<ListModel> _list;
  String title;
  int id;
  int valid;
  List<MyLocation> _myLocation = [];
  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  String value;
  UserModel _userData;
  bool isLoading = false;
  List<MyLocation> _locations = [];

  @override
  void initState() {
    log('message2');

    _loadData();
    _loadProfile();

    // _getPresentLocation(context);
    super.initState();
  }

  Future<void> _loadProfile() async {
    setState(() {
      isLoading = true;
    });
    final UserModel result = await Api.getUserProfile();
    setState(() {
      _userData = result;
    });
    setState(() {
      isLoading = false;
    });
    print(".............................................${_userData.name}");
    print(
        ".............................................${_userData.neighbourhoodid}");
    return _userData;
  }

  Future<void> _getPresentLocation(BuildContext context) async {
    log('message3');
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _lastKnown = await Geolocator.getLastKnownPosition();
    final coordinates =
    new Coordinates(_currentPosition.latitude, _currentPosition.longitude);
    final coordinate =
    new Coordinates(_lastKnown.latitude, _lastKnown.longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    address = await Geocoder.local.findAddressesFromCoordinates(coordinate);
    final List<MyLocation> result = await Api.getPopular();
    _myLocation = result;
    if (_userData.neighbourhoodid == null) {
      return Alert(
          context: context,
          title: "Select Neighbourhood",
          style: AlertStyle(
            titleStyle: TextStyle(color: Theme.of(context).primaryColor),
          ),
          content: Column(children: <Widget>[
            SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      // enabled: enable,
                      onTap: () {},
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: "Search by",
                      ),
                    ),
                    // ignore: non_constant_identifier_names
                    suggestionsCallback: (Pattern) async {
                      // //hardcoded datas to be changed
                      List<MyLocation> list = _myLocation;
                      var suggetionList = Pattern.isEmpty
                          ? null
                          : list
                          .where((e) => e.title
                          .toLowerCase()
                          .contains(Pattern.toLowerCase()))
                          .toList();

                      return suggetionList;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        // leading: Icon(Icons.location_city),
                        title: Text(suggestion.title),
                      );
                    },
                    onSuggestionSelected: (suggestion) async {
                      setState(() {
                        value = suggestion.title;
                        id = suggestion.id;
                      });
                      pressedLocation();
                      locationName = suggestion.title;
                      flutterSecureStorage.write(
                          key: 'location', value: suggestion.title);
                      Navigator.pop(context);
                    })),
          ]),
          buttons: [
            DialogButton(
              color: Theme.of(context).buttonColor,
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }
    if (_userData.neighbourhoodid != null) {
      _showAlert(context);
    }
  }

  _checkLocation() async {
    // the method below returns a Future
    var connectivityResult = await (new Connectivity().checkConnectivity());
    bool connectedToWifi = (connectivityResult == ConnectivityResult.wifi);
    if (!connectedToWifi) {
      _showAlert(context);
    }
    if (_tryAgain != !connectedToWifi) {
      setState(() => _tryAgain = !connectedToWifi);
    }
  }

  // ///Fetch API
  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    final dynamic result = await Api.getHome(id: widget.id);
    setState(() {
      isLoading = false;
      _homePage = result;
    });
    return _homePage;
  }

  ///On navigate product detail
  // /**************************************************** */
  void _onLocationDetail(MyLocation item) {
    // String route = item.type == LocationType.place
    //     ? Routes.locationDetail
    //     : Routes.locationDetail;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LocationDetail(
            id: item.id,
          )),
    );
  }
  // ******************************************************************/

  void _onShopDetail(ShopModel item) {
    // ignore: unrelated_type_equality_checks
    String route = item.type == ShopType.place
        ? Routes.productDetail
        : Routes.productDetailTab;
    Navigator.pushNamed(
      context,
      route,
      arguments: item.id,
    );
  }

  // ontaps for catagory@sanjana
  void _onTapService(CategoryModel2 item) {
    switch (item.type) {
      case CategoryType2.more:
        _onOpenMore();
        break;

      default:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListProduct(
                id: item.id,
                title: item.title,
              )),
        );
        // Navigator.pushNamed(context, Routes.listProduct, arguments: item.id);
        break;
    }
  }

  ///On Open More
  void _onOpenMore() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return HomeCategoryList(
          category: _homePage == null ? [] : _homePage.category,
          onOpenList: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category()),
            );
            // Navigator.pushNamed(context, Routes.category);
          },
          onPress: (item) async {
            Navigator.pop(context);
            await Future.delayed(Duration(milliseconds: 250));
            _onTapService(item);
          },
        );
      },
    );
  }

//Build category @SANJANA
  Widget _buildCategoryItem() {
    //  print('category list ///////////////////:${_categoryList.length}');
    List<CategoryModel2> category2 =
    _homePage == null ? [] : _homePage.category;
    if (category2 == null) {
      return Wrap(
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: List.generate(8, (index) => index).map(
              (item) {
            return HomeCategoryPage();
          },
        ).toList(),
      );
    }

    List<CategoryModel2> listBuild =
    _homePage == null ? [] : _homePage.category;
    final more = CategoryModel2.fromJson({
      "id": 9,
      "title": Translate.of(context).translate("more"),
      "icon": "http://dev.shoplocalto.ca/images/category/qVXlZTwRQDl3c0S.png",
      "color": "#DD0000",
      "type": "more"
    });

    if (category2.length > 7) {
      listBuild = category2.take(7).toList();
      listBuild.add(more);
    }

    return Wrap(
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: listBuild.map(
            (item) {
          return HomeCategoryPage(
            categoryModel2: item,
            onPressed: (item) {
              _onTapService(item);
            },
          );
        },
      ).toList(),
    );
  }

  //Build Popular @SANJANA
  Widget _buildPopLocation() {
    // print(_locations.toString());
    List<MyLocation> poplocation = _homePage == null ? [] : _homePage.locations;
    if (poplocation == null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
        itemBuilder: (context, index) {
          final item = poplocation[index];
          return Padding(
            padding: EdgeInsets.only(left: 15),
            child: AppProductItem(
              mylocation: item,
              type: ProductViewType.cardLarge,
              onPressLocation: _onLocationDetail,
            ),
          );
        },
        itemCount: List.generate(8, (index) => index).length,
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
      itemBuilder: (context, index) {
        final item = poplocation[index];
        return Padding(
          padding: EdgeInsets.only(left: 15),
          child: SizedBox(
            width: 135,
            height: 160,
            // *************************************************
            child: AppProductItem(
              mylocation: item,
              type: ProductViewType.cardLarge,
              onPressLocation:
              _onLocationDetail, //from here go to _onlocation detail
            ),
            // *****************************************************
          ),
        );
      },
      itemCount: poplocation.length,
    );
  }

  //Build shops @SANJANA
  Widget _buildShopList() {
    if (isLoading) {
      return Column(
        children: List.generate(8, (index) => index).map(
              (item) {
            return Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: AppProductItem(type: ProductViewType.cardSmall),
            );
          },
        ).toList(),
      );
    }
    List<ShopModel> shopss = _homePage == null ? [] : _homePage.shops;
    if (shopss == null) {
      return Center(
        child: Container(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sentiment_satisfied),
                ListTile(
                  title: Text(
                    "looks like there aren't enough bussiness signed up on ShoplocalTo in your selected neighbourhood.if you like to view more results near your location please change the current neighbourhood",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: shopss.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: AppProductItem(
            onPressshop: _onShopDetail,
            shopModel: item,
            type: ProductViewType.cardSmall,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('popular locatiugbuiiiiibj buiob:$_popularPageModel');
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(userData: _userData),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: AppBarHomeSliver(
                scaffoldkey: _scaffoldKey,
                expandedHeight: 250,
                banners: _homePage == null ? [] : _homePage.banners,
                neibhourIdTap: (val) async {
                  log(' VAL HH' + val.toString());
                  // log();
                  final dynamic result = await Api.getHome(id: val);
                  log(result.toString());
                  print('$result');
                  setState(() {
                    _homePage = result;
                  });
                },
                neibhourName: (val) {
                  print(val);
                  setState(() {
                    locationName = val;
                  });
                }),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SafeArea(
                top: false,
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 15,
                        left: 10,
                        right: 10,
                      ),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                    locationName == null
                                        ? _userData.location != null
                                        ? Translate.of(context).translate(
                                        'Welcome to ${_userData.location}')
                                        : Translate.of(context).translate(
                                        'Welcome to Neighbourhoods')
                                        : Translate.of(context).translate(
                                        'Welcome to $locationName'),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ),
                              // Align(
                              //   alignment: Alignment.topLeft,
                              //   child: FlatButton(
                              //     child:
                              //         Text("Change neighbourhood"),
                              //     height: 30,
                              //     shape: RoundedRectangleBorder(
                              //         borderRadius:
                              //             BorderRadius.circular(50)),
                              //     color: Theme.of(context).buttonColor,
                              //     textColor: Theme.of(context)
                              //         .selectedRowColor,
                              //     onPressed: () {
                              //       Alert(
                              //           context: context,
                              //           title: "Select Neighbourhood",
                              //           style: AlertStyle(
                              //             titleStyle: TextStyle(
                              //                 color: Theme.of(context)
                              //                     .primaryColor),
                              //           ),
                              //           content:
                              //               Column(children: <Widget>[
                              //             SizedBox(height: 10),
                              //             Container(
                              //                 decoration: BoxDecoration(
                              //                   color: Theme.of(context)
                              //                       .hoverColor,
                              //                   borderRadius:
                              //                       BorderRadius.all(
                              //                     Radius.circular(8),
                              //                   ),
                              //                 ),
                              //                 child: TypeAheadField(
                              //                     textFieldConfiguration:
                              //                         TextFieldConfiguration(
                              //                       autofocus: false,
                              //                       // enabled: enable,
                              //                       onTap: () {},
                              //                       decoration:
                              //                           InputDecoration(
                              //                         prefixIcon: Icon(
                              //                             Icons.search),
                              //                         border:
                              //                             InputBorder
                              //                                 .none,
                              //                         hintText:
                              //                             "Search by",
                              //                       ),
                              //                     ),
                              //                     // ignore: non_constant_identifier_names
                              //                     suggestionsCallback:
                              //                         (Pattern) async {
                              //                       // //hardcoded datas to be changed
                              //                       List<MyLocation>
                              //                           list =
                              //                           _myLocation;
                              //                       var suggetionList = Pattern
                              //                               .isEmpty
                              //                           ? null
                              //                           : list
                              //                               .where((e) => e
                              //                                   .title
                              //                                   .toLowerCase()
                              //                                   .contains(
                              //                                       Pattern.toLowerCase()))
                              //                               .toList();
                              //
                              //                       return suggetionList;
                              //                     },
                              //                     itemBuilder: (context,
                              //                         suggestion) {
                              //                       return ListTile(
                              //                         // leading: Icon(Icons.location_city),
                              //                         title: Text(
                              //                             suggestion
                              //                                 .title),
                              //                       );
                              //                     },
                              //                     onSuggestionSelected: (suggestion) async {
                              //                       setState(() {
                              //                         value = suggestion.title;
                              //                         id = suggestion.id;
                              //                         locationName = suggestion.title;
                              //                       });
                              //
                              //                       pressedLocation();
                              //                       _homePage = suggestion.id;
                              //
                              //                       // flutterSecureStorage.write(
                              //                       //     key: 'location', value: suggestion.title);
                              //                       Navigator.pop(context);
                              //                     })
                              //
                              //                 // previous search by sanjana search.txt
                              //                 ),
                              //           ]),
                              //           buttons: [
                              //             DialogButton(
                              //               color: Theme.of(context)
                              //                   .buttonColor,
                              //               onPressed: () =>
                              //                   Navigator.pop(context),
                              //               child: Text(
                              //                 "Cancel",
                              //                 style: TextStyle(
                              //                     color: Colors.white,
                              //                     fontSize: 20),
                              //               ),
                              //             )
                              //           ]).show();
                              //     },
                              //   ),
                              // )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          _buildCategoryItem(),
                        ],
                      ),
                      // _buildCategory(),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  Translate.of(context).translate(
                                      'Popular Neighbourhoods in Toronto'),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              Padding(padding: EdgeInsets.only(top: 3)),
                              Text(
                                Translate.of(context).translate(
                                    'Explore the Neighbourhoods in Nearby'),
                                style:
                                Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 195,
                      child: _buildPopLocation(),
                      //  _buildPopular(),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 15,
                      ),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Translate.of(context)
                                    .translate('Featured Shops'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 3),
                              ),
                              Text(
                                locationName == null
                                    ? Translate.of(context).translate(
                                    'Find Out what is popular in Neighbourhoods')
                                    : Translate.of(context).translate(
                                    'Find Out what is popular in $locationName'),
                                style:
                                Theme.of(context).textTheme.bodyText1,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: _buildShopList(),
                      // _buildList()
                    ),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  Future<void> _showAlert(BuildContext context) async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _lastKnown = await Geolocator.getLastKnownPosition();
    final coordinates =
    new Coordinates(_currentPosition.latitude, _currentPosition.longitude);
    final coordinate =
    new Coordinates(_lastKnown.latitude, _lastKnown.longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    address = await Geocoder.local.findAddressesFromCoordinates(coordinate);
    // setState(() {
    //   first = addresses.first;
    //   old = address.first;
    // });
    final List<MyLocation> result = await Api.getPopular();
    // _myLocation = result;
    // final List<MyLocation> result = await Api.getSuggestedLocation();
    setState(() {
      _myLocation = result;
    });
    // print("::::::::::::0000000000:::::::::: ${first.thoroughfare}");
    // print("::::::::::::0000000000:::::::::: ${old.thoroughfare}");
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you in  ${_userData.location}'),
                Text('Would you like to change the location?'
                  // 'Would you like to change the location to "${first.thoroughfare}" or continue with  ${_userData.location}'),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hoverColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: false,
                          // enabled: enable,
                          onTap: () {},
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintText: "Search by",
                          ),
                        ),
                        // ignore: non_constant_identifier_names
                        suggestionsCallback: (Pattern) async {
                          // //hardcoded datas to be changed
                          List<MyLocation> list = _myLocation;
                          var suggetionList = Pattern.isEmpty
                              ? null
                              : list
                              .where((e) => e.title
                              .toLowerCase()
                              .contains(Pattern.toLowerCase()))
                              .toList();

                          return suggetionList;
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            // leading: Icon(Icons.location_city),
                            title: Text(suggestion.title),
                          );
                        },
                        onSuggestionSelected: (suggestion) async {
                          setState(() {
                            value = suggestion.title;
                            valid = suggestion.id;
                          });
                          pressedLocation();
                          locationName = suggestion.title;
                          flutterSecureStorage.write(
                              key: 'location', value: suggestion.title);
                          Navigator.pop(context);
                        })),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',
                  style: TextStyle(color: Colors.blue[700], fontSize: 17)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }

  pressedLocation() async {
    final dynamic result = await Api.getHome(id: valid);
    log(result.toString());
    setState(() {
      _homePage = result;
    });
  }
}
