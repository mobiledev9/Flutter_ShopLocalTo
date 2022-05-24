

class MyLocation {
  int id;
  String title;
  String subtitle;
  String image;
  String name;
  String latitude;
  String longitude;


  MyLocation(
    this.id,
    this.title,
    this.subtitle,
    this.image,
    this.name,
    this.latitude,
    this.longitude
 
    
  );


   @override
  String toString() {
    return toJson().toString();
  }

  MyLocation.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    image = json['image'];
    name = json['name'];
    latitude =json['latitude'];
    longitude = json['lomgitude'];

    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (title != null) json['title'] = title;
    if (subtitle != null) json['subtitle'] = subtitle;
    if (image != null) json['image'] = image;
    if (name != null) json['name'] = name;
    if (latitude != null) json['latitude'] = latitude;
    if (longitude != null) json['longitude'] = longitude;

    
    return json;
  }

  static List<MyLocation> listFromJson(List<dynamic> json) {
    return json == null
        ? List<MyLocation>()
        : json.map((value) => MyLocation.fromJson(value)).toList();
  }
  
}
