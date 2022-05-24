class IconModel {
 String title;
 String icon;
 String image;

  IconModel(
    this.title,
    this.icon,
    this.image
  );

  IconModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    title = json['title'];
    icon = json['icon'];
    image = json['image'];
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (title != null) json['id'] = title;
    if (icon != null) json['icon'] = icon;
    if (image != null) json['image'] = image;

    return json;
  }
  static List<IconModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<IconModel>()
        : json.map((value) => IconModel.fromJson(value)).toList();
  }


  // factory IconModel.fromJson(Map<String, dynamic> json) {
  //   return IconModel(
  //     json['title'] as String ?? "Unknown",
  //     json['icon'] as String ?? "Unknown",
  //     json['image'] as String ?? "Unknown",
  //   );
  // }
}
