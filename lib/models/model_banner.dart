class ImageModel {
  int id;
  String image;
  String name;  
  String title;             
  String description;            
      

  ImageModel(
    this.id,
    this.image,
    this.description,
    this.name,
    this.title,
  );
   @override
  String toString() {
    return toJson().toString();
  }

  ImageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
   id = json['id'];
    image = json['image'];
     description = json['description'];
    name = json['name'];
     title = json['title'];

    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (image != null) json['image'] = image;
    if (description != null) json['description'] = description;
    if (name != null) json['name'] = name;
    if (title != null) json['title'] = title;
    return json;
  }
  static List<ImageModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<ImageModel>()
        : json.map((value) => ImageModel.fromJson(value)).toList();
  }
}
