// import 'package:flutter/cupertino.dart';
import 'package:shoplocalto/models/model.dart';

enum ListType {
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

class ListModel {
  int id;
  String title;
  String name;
  String subtitle;
  String details;
  String created_date;
  double rate;
  int num_rate;
  String rate_text;
  String status;
  bool favourite;
  String address;
  String phone;
  LocationModel location;
  String count;
  String image;
  String icon;
  String color;
  ListType type;

  ListModel({
    this.id,
    this.title,
    this.name,
    this.count,
    this.image,
    this.icon,
    this.color,
    this.type,
    this.address,
    this.created_date,
    this.favourite,
    this.location,
    this.num_rate,
    this.phone,
    this.rate,
    this.rate_text,
    this.status,
    this.subtitle,
    this.details,
  });

  @override
  String toString() {
    return toJson().toString();
  }

  ListModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;

    id = json['id'];
    title = json['title'];
    name = json['name'];
    count = json['count'];
    image = json['image'];
    icon = json['icon'];
    color = json['color'];
    address = json['address'];
    created_date = json['created_date'];
    favourite = json['favourite'];
    location = _setLocation(json['location']);
    num_rate = json['num_rate'];
    phone = json['phone'];
    rate = json['rate'];
    rate_text = json['rate_text'];
    status = json['status'];
    subtitle = json['subtitle'];
    details = json['details'];
    type = _setType(json['type']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (title != null) json['title'] = title;
    if (name != null) json['name'] = name;
    if (count != null) json['count'] = count;
    if (image != null) json['image'] = image;
    if (icon != null) json['icon'] = icon;
    if (color != null) json['color'] = color;
    if (type != null) json['type'] = type;
    if (address != null) json['address'] = address;
    if (created_date != null) json['created_date'] = created_date;
    if (location != null) json['location'] = location;
    if (num_rate != null) json['num_rate'] = num_rate;
    if (favourite != null) json['favourite'] = favourite;
    if (phone != null) json['phone'] = phone;
    if (rate != null) json['rate'] = rate;
    if (rate_text != null) json['rate_text'] = rate_text;
    if (status != null) json['status'] = status;
    if (subtitle != null) json['subtitle'] = subtitle;
    if (details != null) json['details'] = details;
    return json;
  }

  static ListType _setType(String type) {
    switch (type) {
      case 'shop':
        return ListType.shop;
      case 'drink':
        return ListType.drink;
      case 'event':
        return ListType.event;
      case 'estate':
        return ListType.estate;
      case 'job':
        return ListType.job;
      case 'restaurant':
        return ListType.restaurant;
      case 'automotive':
        return ListType.automotive;
      case 'hotel':
        return ListType.hotel;
      default:
        return ListType.more;
    }
  }

  static LocationModel _setLocation(Map<String, dynamic> location) {
    if (location != null) {
      return LocationModel.fromJson(location);
    }
    return null;
  }

  static List<ListModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<ListModel>()
        : json.map((value) => ListModel.fromJson(value)).toList();
  }
}
