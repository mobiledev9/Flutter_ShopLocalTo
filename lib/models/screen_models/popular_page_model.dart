import 'package:shoplocalto/models/model.dart';

class PopularPageModel {
  String status;
  String message;
  
  List<MyLocation> list;
  List<CategoryModel2> category;
  List<ShopModel> shops;

  PopularPageModel(
    this.status,
    this.message,
    this.list,
    this.category,
    this.shops
  );


  
  PopularPageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    status = json['id'];
    message = json['address'];
    list = _setList(json['list']);
    category = _setCategory(json['list']);
    shops= _setShops(json['list']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (status != null) json['id'] = status;
    if (message != null) json['address'] = message;
    if (list != null) json['location'] = list;
    if (category!=null) json['type'] = category;
    if (shops!=null) json['image'] =shops;
    return json;
  }
static List<MyLocation> _setList(List<dynamic> json) {
    return json == null
        ? List<MyLocation>()
        : json.map((value) => MyLocation.fromJson(value)).toList();
  }

  static List<CategoryModel2> _setCategory(List<dynamic> json) {
    return json == null
        ? List<CategoryModel2>()
        : json.map((value) => CategoryModel2.fromJson(value)).toList();
  }

  static List<ShopModel> _setShops(List<dynamic> json) {
    return json == null
        ? List<ShopModel>()
        : json.map((value) => ShopModel.fromJson(value)).toList();
  }

   static List<PopularPageModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<PopularPageModel>()
        : json.map((value) => ShopModel.fromJson(value)).toList();
  }


}