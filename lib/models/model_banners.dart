

class BannerModel {
  String image;
  String description;
  // final CategoryModel2 category;

  BannerModel(
    this.image,
    this.description,
    // this.category,
  );

 @override
  String toString() {
    return toJson().toString();
  }

  
 BannerModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    image = json['image'];
    description = json['description'];
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (image != null) json['image'] = image;
     if (description != null) json['description'] = description;
    
    return json;
  }

  static List<BannerModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<BannerModel>()
        : json.map((value) => BannerModel.fromJson(value)).toList();
  }
  




  // factory NotificationModel.fromJson(Map<String, dynamic> json) {
  //   return NotificationModel(
  //     json['id'] as int,
  //     json['title'] as String,
  //     json['subtitle'] as String,
  //     DateTime.tryParse(json['date']) ?? DateTime.now(),
  //     new CategoryModel2.fromJson(json['category']),
  //   );
  // }
}
