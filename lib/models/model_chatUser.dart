class User {
   int id;
   String name;
   String nickname;
   String image;
   String link;
   String level;
   String description;
  String tag;
  double rate;
  String token;

  User(
    this.id,
    this.name,
    this.nickname,
    this.image,
    this.link,
    this.level,
    this.description,
    this.tag,
    this.rate,
    this.token,
  );
  @override
  String toString() {
    return toJson().toString();
  }

  User.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
   id = json['id'];
    image = json['image'];
     description = json['description'];
    name = json['name'];
    level = json['level'];
    link = json['link'];
    nickname = json['nickName'];
    rate = json['rate'];
    tag = json['tag'];
    token = json['token'];

    
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (image != null) json['image'] = image;
    if (description != null) json['description'] = description;
    if (name != null) json['name'] = name;
    if (level != null) json['level'] = level;
    if (link != null) json['link'] = link;
    if (nickname != null) json['nickname'] = nickname;
    if (rate != null) json['rate'] = rate;
    if (tag != null) json['tag'] = tag;
    if (token != null) json['token'] = token;

    return json;
  }
  static List<User> listFromJson(List<dynamic> json) {
    return json == null
        ? List<User>()
        : json.map((value) => User.fromJson(value)).toList();
  }
  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     json['id'] as int ?? 0,
  //     json['full_name'] as String ?? 'Unknown',
  //     json['nickname'] as String ?? 'Unknown',
  //     json['photo'] as String ?? 'Unknown',
  //     json['url'] as String ?? 'Unknown',
  //     json['level'] as String ?? 'Unknown',
  //     json['description'] as String ?? 'Unknown',
  //     json['tag'] as String ?? 'Unknown',
  //     json['rate'] as double ?? 0.0,
  //     json['token'] as String ?? 'Unknown',
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'full_name': name,
  //     'nickname': nickname,
  //     'photo': image,
  //     'url': link,
  //     'level': level,
  //     'description': description,
  //     'tag': tag,
  //     'rate': rate,
  //     'token': token,
  //   };
  // }
}
