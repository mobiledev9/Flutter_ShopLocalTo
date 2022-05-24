import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/screens/SearchResult/searchResult.dart';
import 'package:shoplocalto/screens/screen.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';

import 'search_result_list.dart';
import 'search_suggest_list.dart';

class SearchHistory extends StatefulWidget {
  final num id;
  SearchHistory({Key key, this.id}) : super(key: key);

  @override
  _SearchHistoryState createState() {
    return _SearchHistoryState();
  }
}

class _SearchHistoryState extends State<SearchHistory> {
  SearchHistoryPageModel _historyPage;
  SearchHistorySearchDelegate _delegate = SearchHistorySearchDelegate();

  num id;
  num shopid;
  String value;
  final _textController = TextEditingController();
  TextEditingController _textCatController;
  final _suggestionsBoxController = SuggestionsBoxController();
  TextEditingController controller = new TextEditingController();
  var loading = false;
  CategoryType _type = CategoryType.full;
  CategoryPageModel _categoryPage;
  List<CategoryModel2> _category;
  List<ListModel> _shop;
  List<ListModel> _shopModel = [];
  @override
  void initState() {
    // _loadData();
    _loadCategory();
    _loadShops();
    _textCatController = new TextEditingController();
    super.initState();
  }

  Future<void> _onClearTapped() async {
    await Future.delayed(Duration(milliseconds: 100));
    _textController.text = '';
    _onSearch('');
  }

  void _onSearch(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _category = _category.where(((item) {
          return item.title.toUpperCase().contains(text.toUpperCase());
          // .toUpperCase().contains(text.toUpperCase());
        })).toList();
      });
    } else {
      setState(() {
        _category = _categoryPage.category;
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

  Future<void> _loadCategory() async {
    setState(() {
      loading = true;
    });
    final dynamic result = await Api.getCategoryViewList();
    setState(() {
      _categoryPage = result;
      _category = _categoryPage.category;
      print("cate ${_category.length}");
      setState(() {
        loading = false;
      });
    });
  }

  Future<void> _loadShops() async {
    setState(() {
      loading = true;
    });
    final List<ListModel> result = await Api.getallshops();
    setState(() {
      _shop = result;
      _shopModel = _shop;
    });
    setState(() {
      loading = false;
    });
  }

  Color colorConvert(String color) {
    print('color666666666666666666666///////:$color');
    color = color.replaceFirst("#", "");
    var converted;
    if (color.length == 6) {
      converted = Color(int.parse("0xFF" + color));
    } else if (color.length == 8) {
      converted = Color(int.parse("0x" + color));
    }
    return converted;
  }

  ///On navigate list product

  List<Widget> _listCategory(BuildContext context) {
    List<CategoryModel2> listBuild = _category == null ? [] : _category;
    // if (listBuild.length > 1) {
    _category = listBuild.take(listBuild.length).toList();
    // }

    if (_category == null) {
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

    return _category.map((item) {
      return InkWell(
          onTap: () {
            setState(() {
              _textCatController.text = item.title;
              id = item.id;
            });
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
                      color: colorConvert(item.color),
                    ),
                    child: Image.network(
                      item.icon,
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
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('search_title')),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                    // color: Theme.of(context).hoverColor,
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: TypeAheadField(
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      autofocus: false,
                                      onTap: () {},
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(Icons.search),
                                        border: InputBorder.none,
                                        hintText:
                                            "Find food, mobile, cosmetics",
                                      ),
                                      controller: _textController,
                                    ),
                                    suggestionsCallback: (Pattern) async {
                                      List<ListModel> list = _shop;
                                      var suggestionsList = Pattern.isEmpty
                                          ? _shopModel
                                          : list.where(((item) {
                                              return item.title
                                                  .toLowerCase()
                                                  .contains(
                                                      Pattern.toLowerCase());
                                              // .startsWith(Pattern.toUpperCase());
                                            })).toList();
                                      return suggestionsList;
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        title: Text(suggestion.title),
                                      );
                                    },
                                    onSuggestionSelected: (suggestion) {
                                      setState(() {
                                        value = suggestion.title;
                                        shopid = suggestion.id;
                                        _textController.text = value;
                                      });
                                    },
                                  )

                                  // AppTextInput(
                                  //   hintText: Translate.of(context)
                                  //       .translate('Find food, mobile, cosmetics'),
                                  //   icon: Icon(Icons.search),
                                  //   controller: _textController,
                                  //   onSubmitted: _onSearch,
                                  //   onChanged: _onSearch,
                                  //   onTapIcon: _onClearTapped,
                                  // ),

                                  // // previous search by sanjana search.txt
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                decoration: BoxDecoration(
                                  color: Colors.grey[500],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: AppTextInput(
                                  hintText: Translate.of(context)
                                      .translate('Enter a category'),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchResult(
                                          id: id != null ? id : shopid,
                                          title: _textCatController.text != null
                                              ? _textCatController.text
                                              : _textController.text,
                                          searchkeyword:
                                              _textController.text != null
                                                  ? _textController.text
                                                  : '',
                                        )),
                              );
                            },
                            text: Translate.of(context).translate('Search '),
                            disableTouchWhenLoading: true,
                          ),
                        ),
                        _recentsearches(context),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                Translate.of(context)
                                    .translate('Popular Categories')
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 10,
                            children: _listCategory(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _recentsearches(BuildContext context) {
    String _recent = null;
    if (_recent == null) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          Translate.of(context).translate('Recent Searches').toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.w600),
        ),
        // recent
      ],
    );
  }
}

class SearchHistorySearchDelegate extends SearchDelegate<ProductModel> {
  SearchHistorySearchDelegate();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    if (isDark) {
      return theme;
    }

    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SuggestionList(query: query);
  }

  @override
  Widget buildResults(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return ResultList(query: query, statusBarHeight: statusBarHeight);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
      ];
    }
    return null;
  }
}
