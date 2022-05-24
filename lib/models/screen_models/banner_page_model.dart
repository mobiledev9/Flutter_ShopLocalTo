import 'package:shoplocalto/models/model.dart';

class BannerPageModel {
  String success;
  String message;
  List<BannerModel> banner;

  BannerPageModel(
    this.banner,
  );
   @override
  String toString() {
    return toJson().toString();
  }

  BannerPageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    success = json['success'];
    message = json['message'];
   banner=_setList(json['list']);  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(success!=null) json['success']=success;
    if(message!=null) json['message']=message;
    if (banner != null) json['list'] = banner;
    return json;
  }

    static List<BannerModel> _setList(list) {
    if (list != null) {
      final Iterable refactorFeature = list;
      return refactorFeature.map((item) {
        return BannerModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<BannerPageModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<BannerPageModel>()
        : json.map((value) => BannerPageModel.fromJson(value)).toList();
  }
 
}