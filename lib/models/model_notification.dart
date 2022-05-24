import 'model.dart';

class NotificationModel {
   int id;
   String title;
   String subtitle;
  String read_at;
  int user_id;
 String date;
  // final CategoryModel2 category;

  NotificationModel(
    this.id,
    this.title,
    this.subtitle,
    this.read_at,
    this.user_id,
    this.date,
    // this.category,
  );

 @override
  String toString() {
    return toJson().toString();
  }

  
 NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    read_at = json['read_at'];
    user_id = json['user_id'];
    date = json['time'];
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
     if (title != null) json['title'] = title;
      if (subtitle != null) json['subtitle'] = subtitle;
       if (read_at != null) json['read_at'] = read_at;
        if (user_id != null) json['user_id'] = user_id;
          if (date != null) json['time'] = date;
    return json;
  }

  static List<NotificationModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<NotificationModel>()
        : json.map((value) => NotificationModel.fromJson(value)).toList();
  }
  
   static TimeModel _setDate(Map<String, dynamic> author) {
    if (author != null) {
      return TimeModel.fromJson(author);
    }
    return null;
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
