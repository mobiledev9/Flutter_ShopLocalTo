import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/routes.dart';
import 'package:shoplocalto/main_navigation.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/screens/home/home_controller.dart';
import 'package:shoplocalto/screens/screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: must_be_immutable
class HomeSwipe extends StatefulWidget {
  Function(int) neibhourIdTap;
  Function(String) neighbourName;
  final GlobalKey<ScaffoldState> scaffoldkey;
  HomeSwipe({
    Key key,
    @required this.images,
    this.height,
    this.neibhourIdTap,
    this.neighbourName,
    this.scaffoldkey
  }) : super(key: key);
  final double height;
  final List<ImageModel> images;
  // List<ShopModel> shops;
  List<MyLocation> myLocation;
  num id;
  @override
  _HomeSwipeState createState() => _HomeSwipeState();
}

class _HomeSwipeState extends State<HomeSwipe> {
  // String location;
  // List<ShopModel> shops;
  List<MyLocation> myLocation;
  String value;
  String locationName;
  bool isSwitched = false;
  //  List<ShopModel> _shops = [];
  List<MyLocation> _myLocation = [];
  HomePageModel homepage;
  num id;
  UserModel _userData;
  final HomeController _homeController =
  Get.put(HomeController());
  Completer<GoogleMapController> _controller = Completer();
  // CameraPosition _initPosition;
  // Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    _loadShops();
    _loadProfile();
    super.initState();
  }

  Future<void> _loadShops() async {
    final List<MyLocation> result = await Api.getPopular();
    setState(() {
      _myLocation = result;
    });
    print('ShopModel list ************:${_myLocation.length}');
  }

  Future<void> _loadHomePage() async {
    final dynamic result = await Api.getHomePage(id: id);
    setState(() {
      homepage = result;
    });
    print('ShopModel list ************:${homepage.category.length}');
  }

  Future<void> _loadProfile() async {
    final UserModel result = await Api.getUserProfile();
    setState(() {
      _userData = result;
    });
    print('user user user user user user user ..........${_userData.location}');
    return _userData;
  }

  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  Future<dynamic> getLocation() async {
    String location1;
    bool isLoggedIn = await flutterSecureStorage.containsKey(key: 'location');
    log(isLoggedIn.toString());
    if (isLoggedIn) {
      String location = await flutterSecureStorage.read(key: 'location');
      location1 = location;
      print('location:$location');
    }
    final nullable = location1 == null ? null : location1;
    value = nullable;
    locationName = value;
    print('location2:$location1');
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    if (value == null) {
      Text('novalue');
    }
    //new code to add button,icon,toggle
    return Stack(
      children: <Widget>[

        Container(child: _swipperBanner(context)),

        _buildNavdrawer(context),
        _buildValue(context),
        _buildSearchIcon(context),
        // _buildMap(context),
      ],
    );
  }

  Widget _swipperBanner(BuildContext context) {
    if (widget.images.length > 0) {
      return Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            widget.images[index].image,
            fit: BoxFit.cover,
          );
        },
        autoplayDelay: 3000,
        autoplayDisableOnInteraction: false,
        autoplay: true,
        itemCount: widget.images.length,
        pagination: SwiperPagination(
          // alignment: Alignment(0.0, 0.4),
          builder: SwiperPagination.dots,
        ),
      );
    }
    return Shimmer.fromColors(
      baseColor: Theme.of(context).hoverColor,
      highlightColor: Theme.of(context).highlightColor,
      enabled: true,
      child: Container(
        color: Colors.white,
      ),
    );
  }
  Widget _buildNavdrawer(BuildContext context) {

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 35, left: 20,),
        child: Align(
          alignment: Alignment.topLeft,
          child: Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).buttonColor,
              ),
              child: InkWell(
                onTap: (){
                  setState(() {
                    _homeController.fromnav = false.obs;
                  });
                  widget.scaffoldkey.currentState.openDrawer();
                },
                  // onTap: () =>
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => SearchHistory()),
                  //     ),

                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
    //   Padding(
    //   padding: const EdgeInsets.only(top: 35, left: 20),
    //   child: GestureDetector(
    //     onTap: () {
    //       // _scaffoldKey.currentState!.openDrawer();
    //     },
    //     child: Icon(Icons.menu,
    //       color: Colors.red,),
    //   ),
    // );
  }
  Widget _buildValue(BuildContext context) {
    print('jkbbdkjvbdfj kfjdfjk djfnkjvnf dfbjb fdbjfk..........$id');
    //  _loadShops();
    if (value == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 30, left: 70),
        child: Align(
          alignment: Alignment.topLeft,
          child: FlatButton(
            child: Text("Select your neighbourhood"),
            height: 30,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: Theme.of(context).buttonColor,
            textColor: Theme.of(context).selectedRowColor,
            onPressed: () {
              Alert(
                  context: context,
                  title: "Select Neighbourhood",
                  style: AlertStyle(
                    titleStyle:
                    TextStyle(color: Theme.of(context).primaryColor),
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
                            onSuggestionSelected: (suggestion) {
                              setState(() {
                                value = suggestion.title;
                                id = suggestion.id;
                              });
                              widget.neibhourIdTap(id);
                              widget.neighbourName(value);
                              flutterSecureStorage.write(
                                  key: 'location', value: suggestion.title);
                              Navigator.pop(context);
                              //  Center(
                              //         child: CircularProgressIndicator(
                              //             backgroundColor: Colors.black,
                              //             valueColor:
                              //                 new AlwaysStoppedAnimation<Color>(
                              //                     Colors.blue[800])),
                              //       );
                              // Navigator.push(context, MaterialPageRoute(builder: (context) {
                              //   return MainNavigation();
                              // }
                              // ));
                            })

                      // previous search by sanjana search.txt
                    ),
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
            },
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 70),
      child: Align(
          alignment: Alignment.topLeft,
          child: FlatButton(
            height: 30,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: Theme.of(context).buttonColor,
            textColor: Theme.of(context).selectedRowColor,
            onPressed: () {
              // _openPopup(context,_myLocation);
              Alert(
                  context: context,
                  title: "Select Neighbourhood",
                  style: AlertStyle(
                    titleStyle:
                    TextStyle(color: Theme.of(context).primaryColor),
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
                            onSuggestionSelected: (suggestion) {
                              setState(() {
                                value = suggestion.title;
                                id = suggestion.id;
                              });
                              widget.neibhourIdTap(id);
                              widget.neighbourName(value);
                              flutterSecureStorage.write(
                                  key: 'location', value: suggestion.title);
                              Navigator.pop(context);
                              // Navigator.push(context, MaterialPageRoute(builder: (context) {
                              //   return MainNavigation();
                              // }
                              // ));
                              // Center(
                              //       child: CircularProgressIndicator(
                              //           backgroundColor: Colors.black,
                              //           valueColor:
                              //               new AlwaysStoppedAnimation<Color>(
                              //                   Colors.blue[800])),
                              //     );
                            })

                      // previous search by sanjana search.txt
                    ),
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
            },
            child: Text(
              value,
              //  "Bloor West",
              style: TextStyle(fontSize: 13.0),
            ),
          )),
    );
  }

  Widget _buildSearchIcon(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 35, left: 20, right: 15),
        child: Align(
          alignment: Alignment.topRight,
          child: Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).buttonColor,
              ),
              child: InkWell(
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchHistory()),
                      ),

                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMap(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 35, left: 20, right: 70),
        child: Align(
          alignment: Alignment.topRight,
          child: Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).buttonColor,
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserLocation()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
