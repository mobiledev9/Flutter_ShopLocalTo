import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/model_shops.dart';
import 'package:shoplocalto/screens/SearchResult/searchResult.dart';
import 'package:shoplocalto/screens/home/home_swiper.dart';
import 'package:shoplocalto/screens/product_detail_tab/product_detail_tab.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shoplocalto/configs/config.dart';

class AppBarHomeSliver extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final int id;
  final List<ImageModel> banners;
  final Function(int) neibhourIdTap;
  final Function(String) neibhourName;
  // final List<ShopModel> shopModel;
  final GlobalKey<ScaffoldState> scaffoldkey;

  AppBarHomeSliver(
      {
        this.scaffoldkey,
      this.id,
      this.expandedHeight,
      this.banners,
      this.neibhourIdTap,
      this.neibhourName});
  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: HomeSwipe(
            scaffoldkey: scaffoldkey,
            images: banners,
            height: expandedHeight,
            neibhourIdTap: neibhourIdTap,
            neighbourName: neibhourName,
          ),
        ),

        Container(
          height: 10,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        // HomeSearchBar(),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

// class HomeSearchBar extends StatefulWidget {

//   @override
//   _HomeSearchBarState createState() => _HomeSearchBarState();
// }

// class _HomeSearchBarState extends State<HomeSearchBar> {
//   final _textController = TextEditingController();

//   var searchDropDownValue;
// double container_height = 70;
// double container_width=100;
//   Future<void> _onClearTapped() async {
//     await Future.delayed(Duration(milliseconds: 100));
//     _textController.text = '';
//     // _onSearch('');
//   }

//   void _onSearch(String text) {
//     if (text.isNotEmpty) {
//     } else {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: container_height,
//       padding: EdgeInsets.only(left: 20, right: 20),
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             container_height = 125;
//           });
//         },
//         onDoubleTap: (){
//            setState(() {
//             container_height = 70;
//           });
//         },
//               child: AnimatedContainer(
//           duration: Duration(seconds: 1),
//                 child: Card(
//             margin: EdgeInsets.all(0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             elevation: 3,
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(right: 40,left:10,bottom:10,top:10),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).hoverColor,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(8),
//                       ),
//                     ),
//                     child:AppTextInput(
//                         hintText: Translate.of(context).translate('search'),
//                         icon: Icon(Icons.search),
//                         controller: _textController,
//                         onSubmitted: _onSearch,
//                         onTapIcon: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SearchResult(
//                                     id: int.parse(searchDropDownValue), title: _textController.text)),
//                           );
//                         },
//                         // onChanged: _onSearch,
//                       ),

//                     // // previous search by sanjana search.txt
//                   ),
//                   // Container(child:Text("shdui")),
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(left: 10, right: 40),
//                     child: DropPage(
//                       onChanged: (val) {
//                         log(val);
//                         setState(() {
//                           searchDropDownValue = val;
//                         });
//                       },
//                     )

//                     )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DropPage extends StatefulWidget {
//   // final num id;

//   // const DropPage({Key key, this.id}) : super(key: key);
//   final Function onChanged;
//   DropPage({this.onChanged});
//   @override
//   _DropPageState createState() => _DropPageState();
// }

// // added a dropdown for category selection @sanjana
// class _DropPageState extends State<DropPage> {
//   var dropdownValue;
//   List<CategoryModel2> _categoryList = [];
//   List<ShopModel> _categoryshops = [];

//   @override
//   void initState() {
//     _loadCategoryList();
//     // _loadSearchResults();
//     super.initState();
//   }

//   Future<void> _loadCategoryList() async {
//     final List<CategoryModel2> result = await Api.getCategoryList();
//     setState(() {
//       _categoryList = result;
//     });
//     // print('category list *************:${_categoryList.length}');
//   }

//   //   Future<void> _loadSearchResults() async {
//   //   final List<ShopModel> result = await Api.getSearchResult(id:widget.id);
//   //   setState(() {
//   //     _categoryshops = result;
//   //   });
//   //   // print('ShopModel list ************:${_shops.length}');
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: Theme.of(context).hoverColor,
//         // color: Theme.of(context).scaffoldBackgroundColor,
//         // border: Border.all()
//       ),
//       child: DropdownButton<String>(
//         value: dropdownValue,
//         icon: Icon(Icons.arrow_drop_down,color:Theme.of(context).buttonColor),
//         iconSize: 25,
//         elevation: 16,
//         style: Theme.of(context)
//             .textTheme
//             .subtitle2
//             .copyWith(fontWeight: FontWeight.w500),
//         underline: Container(
//           height: 2,
//           // color: Colors.deepPurpleAccent,
//         ),
//         onChanged: (String newValue) {
//           setState(() {
//             dropdownValue = newValue;
//             widget.onChanged(newValue);
//           });
//         },
//         items: _categoryList
//             .map<DropdownMenuItem<String>>((CategoryModel2 value) {
//           return DropdownMenuItem<String>(
//             value: value.id.toString(),
//             child: Text(value.title),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
