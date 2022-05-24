import 'package:shoplocalto/models/model.dart';

class ProductListPageModel {
   List<ListModel> list;

  ProductListPageModel(
    this.list,
  );

  ProductListPageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
   list=_setList(json['list']);  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (list != null) json['list'] = list;
    return json;
  }

    static List<ListModel> _setList(list) {
    if (list != null) {
      final Iterable refactorFeature = list;
      return refactorFeature.map((item) {
        return ListModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<ProductListPageModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<ProductListPageModel>()
        : json.map((value) => ProductListPageModel.fromJson(value)).toList();
  }

  // factory ProductListPageModel.fromJson(Map<String, dynamic> json) {
  //   final Iterable refactorList = json['list'] ?? [];

  //   final list = refactorList.map((item) {
  //     return ProductModel.fromJson(item);
  //   }).toList();

  //   return ProductListPageModel(list);
  // }
}
