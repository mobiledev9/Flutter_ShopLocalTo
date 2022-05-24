class TimeModel {
   String date;
   int timezone_type;
  String timezone;
  TimeModel(
   this.date,
   this.timezone,
   this.timezone_type

  );

 @override
  String toString() {
    return toJson().toString();
  }

  
 TimeModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    date = json['date'];
    timezone = json['timezone'];
    timezone_type = json['timezone_type'];
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (date != null) json['date'] = date;
     if (timezone != null) json['timezone'] = timezone;
      if (timezone_type != null) json['timezone_type'] = timezone_type;
      
    
    return json;
  }

  static List<TimeModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<TimeModel>()
        : json.map((value) => TimeModel.fromJson(value)).toList();
  }
  
}