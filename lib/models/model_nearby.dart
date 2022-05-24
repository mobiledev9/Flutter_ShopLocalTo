


class NearbyModel {
  int id;
  String name;
  String slug;
  String description;
  String latitude;
  String longitude;
  String picture;

  NearbyModel(
    this.id,
    this.name,
    this.slug,
    this.picture,
    this.description,
    this.latitude,
    this.longitude,
  );

  @override
  String toString() {
    return toJson().toString();
  }

  NearbyModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    picture = json['picture'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (name != null) json['name'] = name;
    if (slug != null) json['slug'] = slug;
    if (picture != null) json['picture'] = picture;
    if (description != null) json['description'] = description;
    if (latitude != null) json['latitude'] = latitude;
    if (longitude != null) json['longitude'] = longitude;

    return json;
  }

  static List<NearbyModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<NearbyModel>()
        : json.map((value) => NearbyModel.fromJson(value)).toList();
  }


  // static LocationModel _setLocation(Map<String, dynamic> location) {
  //   if (location != null) {
  //     return LocationModel.fromJson(location);
  //   }
  //   return null;
  // }


 

}
