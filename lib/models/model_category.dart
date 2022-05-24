import 'package:flutter/cupertino.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/utils/utils.dart';

class CategoryModel {
  int id;
  String title;
  int count;
  String image;
  IconData icon;
  Color color;
  ProductType type;

  CategoryModel({
    this.id,
    this.title,
    this.count,
    this.image,
    this.icon,
    this.color,
    this.type,
  });


  // static ProductType _setType(String type) {
  //   switch (type) {
  //     case 'shop':
  //       return ProductType.shop;
  //     case 'drink':
  //       return ProductType.drink;
  //     case 'event':
  //       return ProductType.event;
  //     case 'estate':
  //       return ProductType.estate;
  //     case 'job':
  //       return ProductType.job;
  //     case 'restaurant':
  //       return ProductType.restaurant;
  //     case 'automotive':
  //       return ProductType.automotive;
  //     case 'hotel':
  //       return ProductType.hotel;
  //     default:
  //       return ProductType.more;
  //   }
  // }



  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final icon = UtilIcon.getIconData(json['icon'] ?? "Unknown");
    final color = UtilColor.getColorFromHex(json['color'] ?? "#ff8a65");
    return CategoryModel(
      id: json['id'] as int ?? 0,
      title: json['title'] as String ?? 'Unknown',
      count: json['count'] as int ?? 0,
      image: json['image'] as String ?? 'Unknown',
      icon: icon,
      color: color,
      // type: _setType(json['type'] as String ?? "Unknown"),
    );
  }

  
}
