class AboutUsModel{
  String image;
  String description;

  AboutUsModel(
    this.description,
    this.image,
  );
@override
  String toString() {
    return toJson().toString();
  }

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    image = json['image'];
    description = json['description'];  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(image!=null) json['image']=image;
    if(description!=null) json['description']=description;
    return json;
  }

  static List<AboutUsModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<AboutUsModel>()
        : json.map((value) => AboutUsModel.fromJson(value)).toList();
  }

}