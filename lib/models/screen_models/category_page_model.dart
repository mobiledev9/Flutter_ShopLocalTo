import 'package:shoplocalto/models/model.dart';

class CategoryPageModel {
  bool success;
    String message;
  List<CategoryModel2> category;

  CategoryPageModel(
    this.success,
    this.message,
    this.category,
  );

  @override
  String toString() {
    return toJson().toString();
  }

  CategoryPageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    success = json['success'];
    message = json['message'];
   category=_setCategory(json['category']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(success!=null) json['success']=success;
    if(message!=null) json['message']=message;
    if (category != null) json['list'] = category;
    return json;
  }

    static List<CategoryModel2> _setCategory(category) {
    if (category != null) {
      final Iterable refactorFeature = category;
      return refactorFeature.map((item) {
        return CategoryModel2.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<CategoryPageModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<CategoryPageModel>()
        : json.map((value) => CategoryPageModel.fromJson(value)).toList();
  }

  // factory CategoryPageModel.fromJson(Map<String, dynamic> json) {
  //   final Iterable convertCategory = json['category'] ?? [];

  //   final listCategory = convertCategory.map((item) {
  //     return CategoryModel.fromJson(item);
  //   }).toList();

  //   return CategoryPageModel(
  //     listCategory,
  //   );
  // }
}
