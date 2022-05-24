import 'package:shoplocalto/models/model.dart';

class WishListPageModel {
  List<ProductModel> list;

  WishListPageModel(
    this.list,
  );

   @override
  String toString() {
    return toJson().toString();
  }

  WishListPageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
   list=_setList(json['list']);  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (list != null) json['list'] = list;
    return json;
  }

    static List<ProductModel> _setList(list) {
    if (list != null) {
      final Iterable refactorFeature = list;
      return refactorFeature.map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<WishListPageModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<WishListPageModel>()
        : json.map((value) => WishListPageModel.fromJson(value)).toList();
  }


  // factory WishListPageModel.fromJson(Map<String, dynamic> json) {
  //   final Iterable refactorList = json['list'] ?? [];

  //   final list = refactorList.map((item) {
  //     return ProductModel.fromJson(item);
  //   }).toList();

  //   return WishListPageModel(list);
  // }
}
