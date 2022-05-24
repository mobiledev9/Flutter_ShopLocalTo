import 'package:flutter/material.dart';

class SocialIcon {
  String social_media;
  String link;
  String icon;

  SocialIcon(
    this.social_media,
    this.link,
    this.icon,
  );

  @override
  String toString() {
    return toJson().toString();
  }

  SocialIcon.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    social_media = json['social_media'];
    link = json['link'];
    icon = json['icon'];
    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (social_media != null) json['social_media'] = social_media;
    if (link != null) json['link'] = link;
    if (icon != null) json['icon'] = icon;
    return json;
  }

  static List<SocialIcon> listFromJson(List<dynamic> json) {
    return json == null
        ? List<SocialIcon>()
        : json.map((value) => SocialIcon.fromJson(value)).toList();
  }
}