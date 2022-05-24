import 'package:shoplocalto/models/model.dart';

class MessagePageModel {
   List<MessageModel> messages;

  MessagePageModel(
    this.messages,
  );
 @override
  String toString() {
    return toJson().toString();
  }

  MessagePageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
   messages=_setList(json['message']);  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (messages != null) json['message'] = messages;
    return json;
  }

    static List<MessageModel> _setList(list) {
    if (list != null) {
      final Iterable refactorFeature = list;
      return refactorFeature.map((item) {
        return MessageModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<MessagePageModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<MessagePageModel>()
        : json.map((value) => MessagePageModel.fromJson(value)).toList();
  }
 
  // factory MessagePageModel.fromJson(Map<String, dynamic> json) {
  //   final Iterable convertMessage = json['message'] ?? [];

  //   final listMessage = convertMessage.map((item) {
  //     return MessageModel.fromJson(item);
  //   }).toList();

  //   return MessagePageModel(
  //     listMessage,
  //   );
  // }

}
