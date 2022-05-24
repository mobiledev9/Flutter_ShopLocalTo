class HourModel {
   String title;
   String time;

  HourModel(
    this.title,
    this.time,
  );

  HourModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    title = json['title'];
    time = json['time'];
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (title != null) json['id'] = title;
    if (time != null) json['time'] = time;
    return json;
  }
  static List<HourModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<HourModel>()
        : json.map((value) => HourModel.fromJson(value)).toList();
  }

  // factory HourModel.fromJson(Map<String, dynamic> json) {
  //   return HourModel(
  //     json['title'] as String ?? "Unknown",
  //     json['time'] as String ?? "Unknown",
  //   );
  // }
}
