import 'package:shoplocalto/models/model.dart';


class NearlyModel {
  int id;
  String title;
  String subtitle;
  String image;
  String createDate;
  num rate;
  num numRate;
  String rateText;
  String status;
  bool favorite;
  String address;
  String phone;
  LocationModel location;

  NearlyModel(
    this.id,
    this.title,
    this.subtitle,
    this.image,
    this.createDate,
    this.rate,
    this.numRate,
    this.rateText,
    this.status,
    this.favorite,
    this.address,
    this.phone,
    this.location,
  );

  @override
  String toString() {
    return toJson().toString();
  }

  NearlyModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    image = json['image'];
    createDate = json['created_date'];
    rate = json['rate'];
    numRate = json['num_rate'];
    rateText = json['rate_text'];
    status = json['status'];
    favorite = json['favorite'];
    address = json['address'];
    phone = json['phone'];
    location=_setLocation(json['location']);
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (title != null) json['title'] = title;
    if (subtitle != null) json['subtitle'] = subtitle;
    if (image != null) json['image'] = image;
    if (createDate != null) json['created_date'] = createDate;
    if (rate != null) json['rate'] = rate;
    if (numRate != null) json['num_rate'] = numRate;
    if (rateText != null) json['rate_text'] = rateText;
    if (status != null) json['status'] = status;
    if (favorite != null) json['favorite'] = favorite;
    if (address != null) json['address'] = address;
    if (phone != null) json['phone'] = phone;
    if (location != null) json['location'] = location;
    return json;
  }

  static List<NearlyModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<NearlyModel>()
        : json.map((value) => NearlyModel.fromJson(value)).toList();
  }


  static LocationModel _setLocation(Map<String, dynamic> location) {
    if (location != null) {
      return LocationModel.fromJson(location);
    }
    return null;
  }


 

}
