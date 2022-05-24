
import 'package:shoplocalto/models/model.dart';

enum ShopType {
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
class ShopModel {
  int id;
  String type;
  String title;
  String subtitle;
  String image;
  String created_date;
  double rate;
  int num_rate;
  String rate_text;
  String status;
  bool favourite;
  String address;
  String phone;
  List<LocationModel> location;
  ShopType model;

  ShopModel({
   this.id,
  this.type,
  this.title,
  this.subtitle,
  this.image,
  this.created_date,
this.rate,
  this.num_rate,
  this.rate_text,
  this.status,
  this.favourite,
  this.address,
  this.phone,
  this.location,
  this.model
  });

  
 ShopModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    address = json['address'];
    // location = _setLocation(json['location']);
    type = json['type'];
    image= json['image'];
    created_date = json['created_date'];
    rate = json['rate'];
    num_rate = json['num_rate'];
    rate_text = json['rate_text'];
    favourite = json['favourite'];
    phone = json['phone'];
    status = json['status'];
    subtitle = json['subtitle'];
    title = json['title'];
    model=_setType(json['type']);
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (address != null) json['address'] = address;
    if (location != null) json['location'] = location;
    if (type!=null) json['type'] = type;
    if (image!=null) json['image'] =type;
    if(created_date!=null) json['created_date'] = created_date;
    if(rate!=null) json['rate'] = rate;
    if(num_rate!=null) json['num_rate'] = num_rate;
    if(rate_text!=null) json['rate_text']=rate_text;
    if(favourite!=null) json['favourite']=favourite;
    if(phone!=null) json['phone']=phone;
        if (status != null) json['status'] = status;
    if (subtitle != null) json['subtitle'] = subtitle;
    if (title != null) json['title'] = title;
   if (model!=null) json['model'] = model;
    return json;
  }

  static ShopType _setType(String type) {
    switch (type) {
      case 'hotel':
        return ShopType.hotel;
      case 'shop':
        return ShopType.shop;
      case 'drink':
        return ShopType.drink;
      case 'event':
        return ShopType.event;
      case 'estate':
        return ShopType.estate;
      case 'job':
        return ShopType.job;
      case 'restaurant':
        return ShopType.restaurant;
      case 'automotive':
        return ShopType.automotive;
      default:
        return ShopType.place;
    }
  }

  static List<ShopModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<ShopModel>()
        : json.map((value) => ShopModel.fromJson(value)).toList();
  }

  // static List<LocationModel> _setLocation(List<dynamic> json) {
  //   return json == null
  //       ? List<LocationModel>()
  //       : json.map((value) => LocationModel.fromJson(value)).toList();
  // }

  

}

List<ShopModel> shopModels = [
  ShopModel(
    id:1,
    
    title: "Launge Coffe Bar",
   


  ),
  ShopModel(
    id:2,
  
   
    title: "cozy royal room",
  
  ),
  ShopModel(
    id:3,
   
    title: "Adorable Room",
  

  ),
  ShopModel(
    id:4,
   
    title: "Vallejo",
   
  ),
  ShopModel(
    id:5,
   

    title: "Park loyal",
   
  ),
];

// class LeaderBoard {
//   // List<NeighbourImages> images; 
//   String name;
//   int number;
  


//   LeaderBoard({
//    this.name,
//    this.number,
//   });
// }