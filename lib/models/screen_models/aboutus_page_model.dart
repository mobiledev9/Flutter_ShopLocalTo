import 'package:shoplocalto/models/model.dart';

class AboutUsPageModel {
  String message;
  bool success;
  // final String banner;
  // final String whoWeAre;
  // final List<String> whatWeDo;
  AboutUsModel team;

  AboutUsPageModel(
    this.message,
    this.success,
    // this.banner,
    // this.whoWeAre,
    // this.whatWeDo,
    this.team,
  );
 @override
  String toString() {
    return toJson().toString();
  }

  AboutUsPageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    success = json['success'];
    message = json['message'];
   team=_setAbout(json['details']);  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(success!=null) json['success']=success;
    if(message!=null) json['message']=message;
    if (team != null) json['details'] = team;
    return json;
  }

    static AboutUsModel _setAbout(Map<String, dynamic> author) {
    if (author != null) {
      return AboutUsModel.fromJson(author);
    }
    return null;
  }

  static List<AboutUsPageModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<AboutUsPageModel>()
        : json.map((value) => AboutUsPageModel.fromJson(value)).toList();
  }
  // factory AboutUsPageModel.fromJson(Map<String, dynamic> json) {
  //   final Iterable refactorTeam = json['team'] ?? [];

  //   final listTeam = refactorTeam.map((item) {
  //     return UserModel.fromJson(item);
  //   }).toList();

  //   return AboutUsPageModel(
  //     json['banner'] as String ?? 'Unknown',
  //     json['who_we_are'] as String ?? 'Unknown',
  //     json['what_we_do'].cast<String>() ?? [],
  //     listTeam,
  //   );
  // }
}
