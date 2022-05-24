import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/filter_page_model.dart';
import 'package:shoplocalto/models/screen_models/product_list_page_model.dart';
import 'package:shoplocalto/screens/SearchResult/searchResult.dart';
import 'package:shoplocalto/utils/language.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

enum TimeType { start, end }

class Filter extends StatefulWidget {
  final String title;
  final String keyword;
  final String opentime;
  final String closetime;
  final String minprice;
  final String maxprice;
  final num id;
  List facilities = [];
  Filter(
      {Key key,
      this.title,
      this.keyword,
      this.id,
      this.facilities,
      this.opentime,
      this.closetime,
      this.minprice,
      this.maxprice})
      : super(key: key);

  @override
  _FilterState createState() {
    return _FilterState();
  }
}

class _FilterState extends State<Filter> with RestorationMixin {
  final FilterPageModel _filterPage = FilterPageModel.fromJson({
    "category": [
      "Architecture",
      "Insurance",
      "Beauty",
      "Artists",
      "Outdoors",
      "Clothing",
      "Jewelry",
      "Medical"
    ],
    "service": [
      "Free Wifi",
      "Shower",
      "Pet Allowed",
      "Shuttle Bus",
      "Supper Market",
      "Open 24/7",
    ]
  });

  final List<Color> _color = [
    Color.fromRGBO(93, 173, 226, 1),
    Color.fromRGBO(165, 105, 189, 1),
    Color(0xffe5634d),
    Color.fromRGBO(88, 214, 141, 1),
    Color.fromRGBO(253, 198, 10, 1),
    Color(0xffa0877e),
    Color.fromRGBO(93, 109, 126, 1)
  ];
  List<LocationModel> _locationSelected = [];
  List<LocationModel> _areaSelected = [];
  TimeOfDay _startHour =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  TimeOfDay _endHour = TimeOfDay(hour: 0, minute: 00);
  String opentime;
  String closetime;
  RangeValues _rangeValues = RangeValues(0, 100);

  final RestorableDouble _minvalue = RestorableDouble(0.0);
  final RestorableDouble _maxvalue = RestorableDouble(100.0);
  bool maxprice = false;
  bool minprice = false;
  List _category = [];
  List _service = [];
  bool isLoading = false;

  ProductListPageModel _productList;
  List<Color> _colorSelected = [];
  double _rate = 4;
  String _currency = String.fromCharCode(0x24);

  @override
  String get restorationId => 'cupertino_slider_demo';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_minvalue, 'minvalue');
    registerForRestoration(_maxvalue, 'maxvalue');
    // registerForRestoration(_discreteValue, 'discrete_value');
  }

  @override
  void initState() {
    _loadData();
    super.initState();
    print('filt fac: ${widget.facilities.toString()}');
    // print('opentime fac: ${widget.opentime.toString()}');
    // print('closetime fac: ${widget.closetime.toString()}');
    // print('minprice fac: ${widget.minprice.toString()}');
    // print('maxprice fac: ${widget.maxprice.toString()}');
    if (widget.facilities != null) {
      _service = widget.facilities;

      print('filtfacserv: $_service');
    }
    // if (widget.opentime != null) {
    //   opentime = widget.opentime;
    //
    //   print('opentime: $opentime');
    // }
    // if (widget.closetime != null) {
    //   closetime = widget.closetime;
    //
    //   print('closetime: $closetime');
    // }
    // if (widget.minprice != null) {
    //   _minvalue.value = double.parse(widget.minprice);
    //
    //   print('_minvalue: ${_minvalue.value}');
    // }
    // if (widget.maxprice != null) {
    //   _maxvalue.value = double.parse(widget.maxprice);
    //
    //   print('_maxvalue: ${_maxvalue.value}');
    // }
  }

  ///Show Picker Time
  Future<void> _showTimePicker(BuildContext context, TimeType type) async {
    final picked = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child,
        );
      },
    );
    if (type == TimeType.start && picked != null) {
      setState(() {
        _startHour = picked;
        opentime = widget.opentime != null
            ? widget.opentime
            : "${_startHour.hourOfPeriod < 10 ? '0${_startHour.hourOfPeriod}' : '${_startHour.hourOfPeriod}'}:${_startHour.minute < 10 ? '0${_startHour.minute}' : '${_startHour.minute}'} ${_startHour.period.index == 0 ? 'am' : 'pm'}";
        print(opentime);
      });
    }
    if (type == TimeType.end && picked != null) {
      setState(() {
        _endHour = picked;
        closetime = widget.closetime != null
            ? widget.closetime
            : "${_endHour.hourOfPeriod < 10 ? '0${_endHour.hourOfPeriod}' : '${_endHour.hourOfPeriod}'}:${_endHour.minute < 10 ? '0${_endHour.minute}' : '${_endHour.minute}'} ${_endHour.period.index == 0 ? 'am' : 'pm'}";
        print(closetime);
      });
    }
  }

  ///On Navigate Filter location
  // Future<void> _onNavigateLocation() async {
  //   final result = await Navigator.pushNamed(
  //     context,
  //     Routes.chooseLocation,
  //     arguments: _locationSelected,
  //   );
  //   if (result != null) {
  //     setState(() {
  //       _locationSelected = result;
  //     });
  //   }
  // }
  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    final dynamic result = await Api.getfilters();
    setState(() {
      isLoading = false;
      _productList = result;
      print('fac: ${_productList.list.length}');
    });
// print('....................................get  L IST...........${widget.id}');

// print('....................................get  L IST...........${listProduct.list.length}');
    ///Setup list marker map from list
  }

  ///On Navigate Filter location
  // Future<void> _onNavigateArea() async {
  //   final result = await Navigator.pushNamed(
  //     context,
  //     Routes.chooseLocation,
  //     arguments: _areaSelected,
  //   );
  //   if (result != null) {
  //     setState(() {
  //       _areaSelected = result;
  //     });
  //   }
  // }

  // String _buildLocationText() {
  //   List<String> locationListText = [];
  //   _locationSelected.forEach((item) {
  //     locationListText.add(item.name);
  //   });
  //   return locationListText.join(',');
  // }

  // String _buildAreaText() {
  //   List<String> locationListText = [];
  //   _areaSelected.forEach((item) {
  //     locationListText.add(item.name);
  //   });
  //   return locationListText.join(',');
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('filter'),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              Translate.of(context).translate('apply'),
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white),
            ),
            onPressed: () {
              print("minpbool $minprice");
              print("maxpbool $maxprice");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchResult(
                            id: widget.id,
                            title: widget.title,
                            facilities: _service.isEmpty ? null : _service,
                            searchkeyword: widget.keyword,
                            minprice: minprice == true
                                ? _minvalue.value.round().toString()
                                : null,
                            maxprice: maxprice == true
                                ? _maxvalue.value.round().toString()
                                : null,
                            startHour: opentime,
                            endHour: closetime,
                          )));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //     bottom: 10,
                            //   ),
                            //   child: Text(
                            //     Translate.of(context)
                            //         .translate('category')
                            //         .toUpperCase(),
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .headline6
                            //         .copyWith(fontWeight: FontWeight.w600),
                            //   ),
                            // ),
                            // Wrap(
                            //   spacing: 10,
                            //   runSpacing: 10,
                            //   children: _filterPage.category.map((item) {
                            //     final bool selected = _category.contains(item);
                            //     return SizedBox(
                            //       height: 32,
                            //       child: FilterChip(
                            //         backgroundColor: Theme.of(context).buttonColor,
                            //         selected: selected,
                            //         label: Text(
                            //           item,
                            //           style: TextStyle(color: Colors.white),
                            //         ),
                            //         onSelected: (value) {
                            //           selected
                            //               ? _category.remove(item)
                            //               : _category.add(item);
                            //           setState(() {
                            //             _category = _category;
                            //           });
                            //         },
                            //       ),
                            //     );
                            //   }).toList(),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 10,
                                top: 15,
                              ),
                              child: Text(
                                Translate.of(context)
                                    .translate('facilities')
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: _productList.list.map((item) {
                                final bool selected =
                                    _service.contains(item.id);
                                return SizedBox(
                                  height: 32,
                                  child: FilterChip(
                                    backgroundColor:
                                        Theme.of(context).buttonColor,
                                    selected: selected,
                                    label: Text(
                                      item.name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onSelected: (value) {
                                      selected
                                          ? _service.remove(item.id)
                                          : _service.add(item.id);
                                      setState(() {
                                        _service = _service;
                                        print('serv: $_service');
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                            // $$$$$$$$$$$$$$$$$$$$$$$Commented area(below commented sectons here)$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                            Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Translate.of(context)
                                        .translate('price_range')
                                        .toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '$_currency ${_minvalue.value.round()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(top: 10),
                                              child: SizedBox(
                                                height: size.height * 0.03,
                                                width: size.width * 0.9,
                                                child: CupertinoSlider(
                                                  value: _minvalue.value,
                                                  min: 0.0,
                                                  max: 100.0,
                                                  activeColor: Theme.of(context)
                                                      .buttonColor,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _minvalue.value = value;
                                                      minprice = true;
                                                    });
                                                  },
                                                ),
                                                // RangeSlider(
                                                //   activeColor: Theme.of(context).buttonColor,
                                                //   inactiveColor: Theme.of(context).primaryColorLight,
                                                //   min: 0,
                                                //   max: 100,
                                                //   values: _rangeValues,
                                                //   onChanged: (range){},
                                                //   onChangeStart: (range) {
                                                //     setState(() {
                                                //       _rangeValues = range;
                                                //
                                                //         minprice = _rangeValues.start.round();
                                                //       if(maxprice == 100){
                                                //         maxprice = null;}
                                                //
                                                //     });
                                                //     print(_rangeValues.start.round());
                                                //     print('min: $minprice');
                                                //   },
                                                //   onChangeEnd: (range) {
                                                //     setState(() {
                                                //       _rangeValues = range;
                                                //       if(minprice == 0){
                                                //       minprice = null;}
                                                //       maxprice = _rangeValues.end.round();
                                                //     });
                                                //
                                                //     print(_rangeValues.end.round());
                                                //
                                                //     print('max: $maxprice');
                                                //   },
                                                // ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '$_currency ${_maxvalue.value.round()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(top: 10),
                                              child: SizedBox(
                                                height: size.height * 0.03,
                                                width: size.width * 0.9,
                                                child: CupertinoSlider(
                                                  value: _maxvalue.value,
                                                  min: 0.0,
                                                  max: 100.0,
                                                  activeColor: Theme.of(context)
                                                      .buttonColor,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _maxvalue.value = value;
                                                      maxprice = true;
                                                    });
                                                  },
                                                ),
                                                // RangeSlider(
                                                //   activeColor: Theme.of(context).buttonColor,
                                                //   inactiveColor: Theme.of(context).primaryColorLight,
                                                //   min: 0,
                                                //   max: 100,
                                                //   values: _rangeValues,
                                                //   onChanged: (range){},
                                                //   onChangeStart: (range) {
                                                //     setState(() {
                                                //       _rangeValues = range;
                                                //
                                                //         minprice = _rangeValues.start.round();
                                                //       if(maxprice == 100){
                                                //         maxprice = null;}
                                                //
                                                //     });
                                                //     print(_rangeValues.start.round());
                                                //     print('min: $minprice');
                                                //   },
                                                //   onChangeEnd: (range) {
                                                //     setState(() {
                                                //       _rangeValues = range;
                                                //       if(minprice == 0){
                                                //       minprice = null;}
                                                //       maxprice = _rangeValues.end.round();
                                                //     });
                                                //
                                                //     print(_rangeValues.end.round());
                                                //
                                                //     print('max: $maxprice');
                                                //   },
                                                // ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Padding(
                      //   padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: <Widget>[
                      //       Text(
                      //         Translate.of(context).translate('avg_price'),
                      //         style: Theme.of(context).textTheme.subtitle2,
                      //       ),
                      //       Text(
                      //         '${_minvalue.value.round()}$_currency- ${_maxvalue.value.round()}$_currency',
                      //         style: Theme.of(context).textTheme.subtitle2,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //     bottom: 10,
                            //     top: 15,
                            //   ),
                            //   child: Text(
                            //     Translate.of(context)
                            //         .translate('business_color')
                            //         .toUpperCase(),
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .headline6
                            //         .copyWith(fontWeight: FontWeight.w600),
                            //   ),
                            // ),
                            // Wrap(
                            //   spacing: 15,
                            //   runSpacing: 10,
                            //   children: _color.map((item) {
                            //     final bool selected = _colorSelected.contains(item);
                            //     return InkWell(
                            //       onTap: () {
                            //         selected
                            //             ? _colorSelected.remove(item)
                            //             : _colorSelected.add(item);
                            //         setState(() {
                            //           _colorSelected = _colorSelected;
                            //         });
                            //       },
                            //       child: Container(
                            //         width: 32,
                            //         height: 32,
                            //         decoration: BoxDecoration(
                            //           shape: BoxShape.circle,
                            //           color: item,
                            //         ),
                            //         child: selected
                            //             ? Icon(
                            //                 Icons.check,
                            //                 color: Colors.white,
                            //               )
                            //             : Container(),
                            //       ),
                            //     );
                            //   }).toList(),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 10,
                                top: 15,
                              ),
                              child: Text(
                                Translate.of(context)
                                    .translate('open_time')
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).dividerColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          _showTimePicker(
                                              context, TimeType.start);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              Translate.of(context).translate(
                                                'start_time',
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              widget.opentime != null
                                                  ? widget.opentime
                                                  : "${_startHour.hourOfPeriod < 10 ? '0${_startHour.hourOfPeriod}' : '${_startHour.hourOfPeriod}'}:${_startHour.minute < 10 ? '0${_startHour.minute}' : '${_startHour.minute}'} ${_startHour.period.index == 0 ? 'am' : 'pm'}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(
                                      color: Theme.of(context).disabledColor,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: InkWell(
                                          onTap: () {
                                            _showTimePicker(
                                                context, TimeType.end);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                Translate.of(context).translate(
                                                  'end_time',
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                widget.closetime != null
                                                    ? widget.closetime
                                                    : "${_endHour.hourOfPeriod < 10 ? '0${_endHour.hourOfPeriod}' : '${_endHour.hourOfPeriod}'}:${_endHour.minute < 10 ? '0${_endHour.minute}' : '${_endHour.minute}'} ${_endHour.period.index == 0 ? 'am' : 'pm'}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //     bottom: 10,
                            //     top: 15,
                            //   ),
                            //   child: Text(
                            //     Translate.of(context)
                            //         .translate('rating')
                            //         .toUpperCase(),
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .headline6
                            //         .copyWith(fontWeight: FontWeight.w600),
                            //   ),
                            // ),
                            // StarRating(
                            //   rating: _rate,
                            //   size: 26,
                            //   color: AppTheme.yellowColor,
                            //   borderColor: AppTheme.yellowColor,
                            //   allowHalfRating: false,
                            //   onRatingChanged: (value) {
                            //     setState(() {
                            //       _rate = value;
                            //     });
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
// Padding(
//   padding: EdgeInsets.only(
//     top: 15,
//   ),
//   child: InkWell(
//     // onTap: _onNavigateLocation,
//     child: Container(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               child: Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     Translate.of(context)
//                         .translate('location')
//                         .toUpperCase(),
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline6
//                         .copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                   _locationSelected.isEmpty
//                       ? Padding(
//                           padding:
//                               EdgeInsets.only(top: 5),
//                           child: Text(
//                             Translate.of(context)
//                                 .translate(
//                               'select_location',
//                             ),
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .caption,
//                           ),
//                         )
//                       : Padding(
//                           padding:
//                               EdgeInsets.only(top: 5),
//                           child: Text(
//                             _buildLocationText(),
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .caption
//                                 .copyWith(
//                                   color: Theme.of(context)
//                                       .primaryColor,
//                                 ),
//                             maxLines: 1,
//                             overflow:
//                                 TextOverflow.ellipsis,
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           ),
//           RotatedBox(
//             quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
//             child: Icon(
//               Icons.keyboard_arrow_right,
//               textDirection: TextDirection.ltr,
//             ),
//           )
//         ],
//       ),
//     ),
//   ),
// ),
// Padding(
//   padding: EdgeInsets.only(
//     top: 15,
//   ),
//   child: InkWell(
//     onTap: _onNavigateArea,
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Expanded(
//           child: Container(
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   Translate.of(context)
//                       .translate('area')
//                       .toUpperCase(),
//                   style: Theme.of(context)
//                       .textTheme
//                       .headline6
//                       .copyWith(
//                         fontWeight: FontWeight.w600,
//                       ),
//                 ),
//                 _areaSelected.isEmpty
//                     ? Padding(
//                         padding: EdgeInsets.only(top: 5),
//                         child: Text(
//                           Translate.of(context).translate(
//                               'select_location'),
//                           style: Theme.of(context)
//                               .textTheme
//                               .caption,
//                         ),
//                       )
//                     : Padding(
//                         padding: EdgeInsets.only(top: 5),
//                         child: Text(
//                           _buildAreaText(),
//                           style: Theme.of(context)
//                               .textTheme
//                               .caption
//                               .copyWith(
//                                 color: Theme.of(context)
//                                     .primaryColor,
//                               ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//               ],
//             ),
//           ),
//         ),
//         RotatedBox(
//           quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
//           child: Icon(
//             Icons.keyboard_arrow_right,
//             textDirection: TextDirection.ltr,
//           ),
//         )
//       ],
//     ),
//   ),
// ),
