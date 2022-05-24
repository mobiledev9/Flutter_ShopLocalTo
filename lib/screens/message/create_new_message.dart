import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/routes.dart';
import 'package:shoplocalto/configs/sort.dart';
import 'package:shoplocalto/screens/chat/chat.dart';
import 'package:shoplocalto/models/model_category.dart';
import 'package:shoplocalto/models/model_category2.dart';
import 'package:shoplocalto/models/model_list.dart';
import 'package:shoplocalto/models/model_message.dart';
import 'package:shoplocalto/models/model_shops.dart';
import 'package:shoplocalto/models/model_sort.dart';
import 'package:shoplocalto/models/screen_models/category_page_model.dart';
import 'package:shoplocalto/models/screen_models/message_page_model.dart';
import 'package:shoplocalto/models/screen_models/product_list_page_model.dart';
import 'package:shoplocalto/models/screen_models/search_history_page_model.dart';
import 'package:shoplocalto/screens/SearchResult/searchResult.dart';
import 'package:shoplocalto/screens/chat/chat.dart';
import 'package:shoplocalto/screens/search_history/search_history.dart';
import 'package:shoplocalto/utils/translate.dart';
import 'package:shoplocalto/widgets/app_category_View_Item.dart';
import 'package:shoplocalto/widgets/app_category_item.dart';
import 'package:shoplocalto/widgets/app_message_item.dart';
import 'package:shoplocalto/widgets/app_tag.dart';
import 'package:shoplocalto/widgets/app_text_input.dart';

class CreateNewMessage extends StatefulWidget {
  const CreateNewMessage({Key key}) : super(key: key);

  @override
  State<CreateNewMessage> createState() => _CreateNewMessageState();
}

class _CreateNewMessageState extends State<CreateNewMessage> {
  num id;
  num shopid;
  String value;
  TextEditingController _textCatController;
  TextEditingController controller = new TextEditingController();
  var isLoading = false;
  CategoryViewType _modeView = CategoryViewType.gird;
  List<ListModel> _shop;
  List<ListModel> _shopModel = [];
  final _controller = RefreshController(initialRefresh: false);
  @override
  void initState() {
    _loadShops();
    _textCatController = new TextEditingController();
    // else {
    //   _loadData();
    // }
    super.initState();
  }
  Future<void> _loadShops() async {
    setState(() {
      isLoading = true;
    });
    final List<ListModel> result = await Api.getallshops();
    setState(() {
      _shop = result;
      _shopModel = _shop;
    });
    setState(() {
      isLoading = false;
    });
  }

  ///Widget build Content
  Widget _buildList() {
    ///Build list
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: AppTextInput(
                    hintText: Translate.of(context)
                        .translate('Search '),
                    icon: Icon(Icons.search),
                    controller: _textCatController,
                    onSubmitted: _onSearch,
                    onChanged: _onSearch,
                    onTapIcon: _onClearTapped,

                  ),
                  // TypeAheadField(
                  //     textFieldConfiguration: TextFieldConfiguration(
                  //       autofocus: false,
                  //       onTap: () {},
                  //       decoration: InputDecoration(
                  //         prefixIcon: Icon(Icons.search),
                  //         border: InputBorder.none,
                  //         hintText: "Enter a category",
                  //       ),
                  //       controller: _textCatController,
                  //     ),
                  //     // ignore: non_constant_identifier_names
                  //     suggestionsCallback: (Pattern) async {
                  //
                  //       List<CategoryModel2> list = _category;
                  //       var suggetionList = Pattern.isEmpty
                  //           ? _categoryPage.category
                  //           : list.where(((item) {
                  //         return item.title
                  //             .toUpperCase().contains(Pattern.toUpperCase());
                  //             // .startsWith(Pattern.toUpperCase());
                  //       })).toList();
                  //       // e.title
                  //       //     .toLowerCase()
                  //       //     .contains(Pattern.toLowerCase()))
                  //       // .toList();
                  //       return suggetionList;
                  //     },
                  //     itemBuilder: (context, suggestion) {
                  //       return ListTile(
                  //         // leading: Icon(Icons.location_city),
                  //         title: Text(suggestion.title),
                  //       );
                  //     },
                  //     onSuggestionSelected: (suggestion) {
                  //       setState(() {
                  //         value = suggestion.title;
                  //         id = suggestion.id;
                  //         _textCatController.text = value;
                  //       });
                  //     })
                ),
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            children: _listCategory(context),
          ),
        ],
      ),
    );
  }
  List<Widget> _listCategory(BuildContext context) {
    List<ListModel> listBuild = _shop == null ? [] : _shop;
    // if (listBuild.length > 1) {
    _shop = listBuild.take(listBuild.length).toList();
    // }

    if (_shop == null) {
      return List.generate(6, (index) => index).map(
            (item) {
          return Shimmer.fromColors(
            baseColor: Theme.of(context).dividerColor,
            highlightColor: Theme.of(context).highlightColor,
            enabled: true,
            child: AppTag(
              Translate.of(context).translate('loading'),
              type: TagType.gray,
            ),
          );
        },
      ).toList();
    }

    return _shop.map((item) {
      return Column(
        children: [

          InkWell(
              onTap: () {
                setState(() {
                  _textCatController.text = item.title;
                  shopid = item.id;
                });
               _onSend();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => Chat(
                //         id: item.id,
                //       )),
                // );
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                // decoration: BoxDecoration(
                //   border: Border(
                //     bottom: BorderSide(
                //       color: Theme.of(context).dividerColor,
                //     ),
                //   ),
                // ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                        ),
                        child: Image.network(
                          item.image,
                          width: 20,
                          height: 20,
                        )),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          item.title,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      );
    }).toList();
  }
  ///Build Content Page Style
  Future<void> _onClearTapped() async {
    await Future.delayed(Duration(milliseconds: 100));
    _onSearch(_textCatController.text);
  }
  Future<void> _onSend() async {
    final chat = MessageModel.fromJson({
      "id": shopid,
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
            id: shopid,
          )),
    );
    // _textChatController.clear();

    // _textChatController.text = '';
    // UtilOther.hiddenKeyboard(context);
  }
  void _onSearch(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _shop = _shop.where(((item) {
          return item.title.toUpperCase().contains(text.toUpperCase());
          // .toUpperCase().contains(text.toUpperCase());
        })).toList();
      });
    } else {
      setState(() {
        _shop = _shopModel;
      });
    }
    // List<CategoryModel2> list = _category;
    // var suggetionList1 = text.isEmpty
    //     ? _categoryPage.category
    //     : list.where(((item) {
    //   return item.title.toUpperCase().contains(text.toUpperCase());
    // })).toList();
    //
    // return suggetionList1;
  }
  ///On Load More
  Future<void> _onLoading() async {
    await Future.delayed(Duration(seconds: 1));
    _controller.loadComplete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Select Company',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: _modeView == CategoryViewType.block ? 0 : 5,
            right: _modeView == CategoryViewType.block ? 0 : 20,
            bottom: 15,
          ),
          child: _buildList(),
        ),
      )
    );
  }
}
