class ResultApiModel {
   bool success;
   String message;
   Map<String, dynamic> data;
   int code;

  ResultApiModel(
    this.success,
    this.message,
    this.data,
    this.code,
  );
 @override
  String toString() {
    return toJson().toString();
  }

  ResultApiModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    success = json['success'];
    message = json['message'];
    data = json['data'];
    code = json['code'];
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (success != null) json['success'] = success;
    if (message != null) json['message'] = message;
    if (data != null) json['data'] = data;
    if (code != null) json['code'] = code;
    

    return json;
  }


  // factory ResultApiModel.fromJson(Map<String, dynamic> json) {
  //   return ResultApiModel(
  //     json['success'] as bool ?? false,
  //     json['message'] as String ?? 'Unknown',
  //     json['data'] as Map<String, dynamic> ?? {},
  //     json['code'] as int ?? 0,
  //   );
  // }
}
