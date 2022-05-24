

// import 'package:flutter/cupertino.dart';
import 'package:shoplocalto/models/model.dart';

enum CategoryType2 {
  place,
  hotel,
  shop,
  drink,
  event,
  estate,
  job,
  restaurant,
  automotive,
  more
}

class CategoryModel2 {
  int id;
  String title;
  String count;
  String image;
  String icon;
  String color;
  String picture;
  List<ListModel> list;
  CategoryType2 type;
  String icon_bg;


  CategoryModel2({
    this.id,
    this.title,
    this.count,
    this.image,
    this.icon,
    this.color,
    this.type,
    this.list,
    this.picture,
    this.icon_bg,
  });

  static CategoryType2 _setType(String type) {
    switch (type) {
      case 'shop':
        return CategoryType2.shop;
      case 'drink':
        return CategoryType2.drink;
      case 'event':
        return CategoryType2.event;
      case 'estate':
        return CategoryType2.estate;
      case 'job':
        return CategoryType2.job;
      case 'restaurant':
        return CategoryType2.restaurant;
      case 'automotive':
        return CategoryType2.automotive;
      case 'hotel':
        return CategoryType2.hotel;
      default:
        return CategoryType2.more;
    }
  }

   CategoryModel2.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    count = json['count'];
    image = json['image'];
    icon =  json['icon'];
    color =  json['color'];
    icon_bg = json['icon_bg'];
    picture = json['picture'];
    type = _setType(json['type']);
    list = _setCategory(json['list']);

  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (title != null) json['title'] = title;
    if (count != null) json['count'] = count;
    if (image != null) json['image'] = image;
    if (icon != null)  json['icon'] = icon;
    if (color != null)  json['color'] = color;
    if(type != null) json['type'] = type;
    if(list!=null) json['list']=list;
    if(picture!=null) json['picture'] = picture;
    if(icon_bg!=null) json['icon_bg'] = icon_bg;
    return json;
  }

  static List<CategoryModel2> listFromJson(List<dynamic> json) {
    return json == null
        ? List<CategoryModel2>()
        : json.map((value) => CategoryModel2.fromJson(value)).toList();
  }
   static List<ListModel> _setCategory(list) {
    if (list != null) {
      final Iterable refactorFeature = list;
      return refactorFeature.map((item) {
        return ListModel.fromJson(item);
      }).toList();
    }
    return null;
  }
   static List<ListModel> listModelfromJson(List<dynamic> json) {
    return json == null
        ? List<ListModel>()
        : json.map((value) => ListModel.fromJson(value)).toList();
  }

}