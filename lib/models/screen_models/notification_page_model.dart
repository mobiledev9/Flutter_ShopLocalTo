import 'package:shoplocalto/models/model.dart';

class NotificationPageModel {
  bool success;
  String message;
  List<NotificationModel> notifications;

  NotificationPageModel(
    this.notifications,
  );
   @override
  String toString() {
    return toJson().toString();
  }

  NotificationPageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    success = json['success'];
    message = json['message'];
   notifications=_setList(json['notifications']);  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(success!=null) json['success']=success;
    if(message!=null) json['message']=message;
    if (notifications != null) json['notifications'] = notifications;
    return json;
  }

    static List<NotificationModel> _setList(list) {
    if (list != null) {
      final Iterable refactorFeature = list;
      return refactorFeature.map((item) {
        return NotificationModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<NotificationPageModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<NotificationPageModel>()
        : json.map((value) => NotificationPageModel.fromJson(value)).toList();
  }
 
}
