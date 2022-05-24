import 'dart:io';

import 'package:shoplocalto/models/model.dart';

enum Status { sent, received }
enum Type { textMessage, photo }

class MessageModel {
   int id;
   String roomName;
  List<User> member;
   String from;
   String message;
  DateTime date;
  Status status;
  File file;
  Type type;

  MessageModel(
    this.id,
    this.roomName,
    this.message,
    this.from,
    this.date,
    this.file,
    this.member,
    this.status,
    this.type,
  );

   @override
  String toString() {
    return toJson().toString();
  }

  MessageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    roomName = json['room_name'];
    message = json['message'];
    from = json['full_name'];
    // date =  DateTime.tryParse(json['date']) ?? DateTime.now();
    //   if (json['file'] != null) {
    //   file = File(json['file']);
    //   type = Type.photo;
    // }
    member = _setUser(json['member']);
    if (json['status'] == 'received') {
      status = Status.received;
    }
    type = Type.textMessage;
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (roomName != null) json['room_name'] = roomName;
    if (message != null) json['message'] = message;
    
    
    return json;
  }

  static List<MessageModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<MessageModel>()
        : json.map((value) => MessageModel.fromJson(value)).toList();
  }
  static  List<User> _setUser(nearby) {
    if (nearby != null) {
      final Iterable refactorFeature = nearby;
      return refactorFeature.map((item) {
        return User.fromJson(item);
      }).toList();
    }
    return null;
  }
  // factory MessageModel.fromJson(Map<String, dynamic> json) {
  //   Status status = Status.sent;
  //   File file;
  //   Type type = Type.textMessage;
  //   List<User> member;
  //   User from;

  //   if (json['status'] == 'received') {
  //     status = Status.received;
  //   }

  //   if (json['file'] != null) {
  //     file = File(json['file']);
  //     type = Type.photo;
  //   }

  //   if (json['member'] != null) {
  //     final Iterable convertUser = json['member'] ?? [];
  //     member = convertUser.map((item) {
  //       return User.fromJson(item);
  //     }).toList();
  //   }

  //   if (json['from'] != null) {
  //     from = User.fromJson(json['from']);
  //   }

  //   return MessageModel(
  //     json['id'] as int ?? 0,
  //     json['room_name'] as String ?? '',
  //     member,
  //     from,
  //     json['message'] as String ?? 'Unknown',
  //     DateTime.tryParse(json['date']) ?? DateTime.now(),
  //     status,
  //     file,
  //     type,
  //   );
  // }
}
