class LocationModel {
  int id;
  String name;
  double lat;
  double long;

  LocationModel(
    this.id,
    this.name,
    this.lat,
    this.long,
  );
LocationModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    long= json['long'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (name != null) json['name'] = name;
    if (lat != null) json['lat'] = lat;
    if (long!=null) json['long'] = long;
    return json;
  }

  static List<LocationModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<LocationModel>()
        : json.map((value) => LocationModel.fromJson(value)).toList();
  }
  
}
