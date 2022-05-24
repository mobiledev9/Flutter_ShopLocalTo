// import 'package:flutter/material.dart';
// import 'package:shoplocalto/models/model.dart';

// class TabModel {
//   int id;
//   String key;
//   GlobalKey keyContentItem;
//   GlobalKey keyTabItem;
//   String title;
//   List<ProductModel> list;

//   TabModel(
//     this.id,
//     this.key,
//     this.keyContentItem,
//     this.keyTabItem,
//     this.title,
//     this.list,
//   );

  

//   TabModel.fromJson(Map<String, dynamic> json) {
//     if (json == null) return;
//     id = json['id'];
//     key = json['key'];
//     keyContentItem = GlobalKey();
//     keyTabItem = GlobalKey();
//     title = json['title'];
//     list=_setList(json['list']);

    
//   }

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     if (id != null) json['id'] = id;
//     if (key!= null) json['key'] = key;
//      GlobalKey();
//       GlobalKey();
//     if(title!=null) json['title']=title;
//     if(list!=null) json['list']=list;
//     return json;
//   }

//    static List<TabModel> listFromJson(List<dynamic> json) {
//     return json == null
//         ? List<TabModel>()
//         : json.map((value) => TabModel.fromJson(value)).toList();
//   }

// static List<ProductModel> _setList(list) {
//     if (list != null) {
//       final Iterable refactorList = list;
//       return refactorList.map((item) {
//         return ProductModel.fromJson(item);
//       }).toList();
//     }
//     return null;
//   }
//   // factory TabModel.fromJson(Map<String, dynamic> json) {
//   //   return TabModel(
//   //     json['id'] as int ?? 0,
//   //     json['key'] as String ?? 'Unknown',
//   //     GlobalKey(),
//   //     GlobalKey(),
//   //     json['title'] as String ?? 'Unknown',
//   //     _setList(json['list']),
//   //   );
//   // }
// }
import 'package:flutter/material.dart';
import 'package:shoplocalto/models/model.dart';

class TabModel {
  final int id;
  final String key;
  final GlobalKey keyContentItem;
  final GlobalKey keyTabItem;
  final String title;
  final List<ProductModel> list;

  TabModel(
    this.id,
    this.key,
    this.keyContentItem,
    this.keyTabItem,
    this.title,
    this.list,
  );

  static List<ProductModel> _setList(list) {
    if (list != null) {
      final Iterable refactorList = list;
      return refactorList.map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  factory TabModel.fromJson(Map<String, dynamic> json) {
    return TabModel(
      json['id'] as int ?? 0,
      json['key'] as String ?? 'Unknown',
      GlobalKey(),
      GlobalKey(),
      json['title'] as String ?? 'Unknown',
      _setList(json['list']),
    );
  }
}
