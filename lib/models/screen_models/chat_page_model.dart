import 'package:shoplocalto/models/model.dart';

class ChatPageModel {
  String roomName;
  int online;
  List<User> member;
  List<MessageModel> message;

  ChatPageModel(
    this.roomName,
    this.online,
    this.member,
    this.message,
  );

  @override
  String toString() {
    return toJson().toString();
  }

  ChatPageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    member = _setList(json['member']);
    message = _setMessageList(json['message']);
    online = json['online'];  
    roomName = json['room_name'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (message != null) json['message'] = message;
    if (member !=null) json['member'] = member;
    if(online !=null) json['online'] = online;
    if(roomName!=null) json['roomName'] = roomName;
    return json;
  }

    static List<User> _setList(list) {
    if (list != null) {
      final Iterable refactorFeature = list;
      return refactorFeature.map((item) {
        return User.fromJson(item);
      }).toList();
    }
    return null;
  }
    static List<MessageModel> _setMessageList(list) {
    if (list != null) {
      final Iterable refactorFeature = list;
      return refactorFeature.map((item) {
        return MessageModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<ChatPageModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<ChatPageModel>()
        : json.map((value) => ChatPageModel.fromJson(value)).toList();
  }
 

  // ChatPageModel.fromJson(Map<String, dynamic> json) {
  //   if (json == null) return;
  //   final Iterable convertMessage = json['message'] ?? [];

  //   final listMessage = convertMessage.map((item) {
  //     return MessageModel.fromJson(item);
  //   }).toList();

  //   final Iterable convertUser = json['member'] ?? [];

  //   final listUser = convertUser.map((item) {
  //     return User.fromJson(item);
  //   }).toList();

  //   return ChatPageModel(
  //     json['room_name'] as String ?? '',
  //     json['online'] as int ?? 0,
  //     listUser,
  //     listMessage,
  //   );
  // }
}
