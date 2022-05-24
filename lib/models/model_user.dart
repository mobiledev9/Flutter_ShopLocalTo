class UserModel {
 int id;
 String token;
 String name;
 String nickname;
 String full_name;
 String email;
  String phone;
String location;
String address;
String city;
String province;
String profile_image;
String photo;
 String country;
 String event_date;
  String event_role;
String mail_allow;
String role;
String provider;
String provider_id;
String status;
String verify;
 String guest;
 String api_token;
  String category_id;
String website;
String information;
String created_at;
String updated_at;
String comment;
int neighbourhoodid;


  UserModel(
    this.id,
    this.token,
    this.name,
    this.nickname,
    this.full_name,
    this.email,
    this.location,
    this.phone,
    this.address,
    this.city,
    this.province,
    //
    this.api_token,
    this.category_id,
    this.country,
    this.created_at,
    this.event_date,
    this.event_role,
    this.guest,
    this.information,
    this.mail_allow,
    this.profile_image,
    this.photo,
    this.provider,
    this.provider_id,
    this.role,
    this.status,
    this.updated_at,
    this.verify,
    this.website,
    this.comment,
    this.neighbourhoodid,
  );

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    token = json['access_token'];
    name = json['name'];
    nickname = json['nickname'];
    full_name = json['full_name'];
    email = json['email'];
    location = json['location'];
    phone=json['phone'];
    address=json['address'];
    city = json['city'];
    province=json['province'];
    information = json['information'];
    //
    api_token = json['api_token'];
    category_id = json['category_id'];
    country = json['country'];
    created_at = json['created_at'];
    event_date = json['event_date'];
    event_role=json['event_role'];
    guest=json['guest'];
    mail_allow = json['mail_allow'];
    profile_image=json['profile_image'];
    photo=json['photo'];
    //
    provider = json['provider'];
    provider_id = json['provider_id'];
    role = json['role'];
    status = json['status'];
    updated_at = json['updated_at'];
    verify=json['verify'];
    website=json['website'];
    comment = json['comment'];
    neighbourhoodid = json['neighbourhood_id'];
    
  }

  @override
  String toString() {
    return toJson().toString();
  }

 static List<UserModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<UserModel>()
        : json.map((value) => UserModel.fromJson(value)).toList();
  }
  
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if(token!=null) json['access_token'] = token;
    if(name!=null) json['name']=name;
    if(nickname!=null) json['nickname']=nickname;
    if(full_name!=null) json['full_name']=full_name;
    if(email!=null) json['email']=email;
    if(location!=null) json['location']=location;
    if(phone!=null) json['phone']=phone;
    //
    if(api_token!=null) json['api_token']=api_token;
    if(category_id!=null) json['category_id']=category_id;
    if(country!=null) json['country']=country;
    if(created_at!=null) json['created_at']=created_at;
    if(event_date!=null) json['event_date']=event_date;
    //
    if(event_role!=null) json['event_role']=event_role;
    if(guest!=null) json['guest']=guest;
    if(information!=null) json['information']=information;
    if(mail_allow!=null) json['mail_allow']=mail_allow;
    if(profile_image!=null) json['profile_image']=profile_image;
    if(photo!=null) json['photo']=photo;
    //
    if(provider!=null) json['provider']=provider;
    if(provider_id!=null) json['provider_id']=provider_id;
    if(role!=null) json['role']=role;
    if(status!=null) json['status']=status;
    if(updated_at!=null) json['phone']=updated_at;
     if(verify!=null) json['verify']=verify;
    if(website!=null) json['website']=website;
    if(comment!=null) json['comment']=comment;
    if(neighbourhoodid !=null) json['neighbourhood_id'] =neighbourhoodid;
    return json;
  }
// factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       json['id'] as int ?? 0,
//       json['full_name'] as String ?? 'Unknown',
//       json['nickname'] as String ?? 'Unknown',
//       json['photo'] as String ?? 'Unknown',
//       json['url'] as String ?? 'Unknown',
//       json['level'] as String ?? 'Unknown',
//       json['description'] as String ?? 'Unknown',
//       json['tag'] as String ?? 'Unknown',
//       // json['rate'] as double ?? 0.0,
//       json['token'] as String ?? 'Unknown',
//       json['email'] as String ?? 'Unknown',
//       json['phone'] as String ?? 'Unknown',
//       json['location'] as String ?? 'Unknown',
//     );
//   }
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'full_name': name,
  //     'nickname': nickname,
  //     // 'photo': photo,
  //     // 'url': url,
  //     // 'level': level,
  //     // 'description': description,
  //     // 'tag': tag,
  //     // 'rate': rate,
  //     'token': token,
  //     'email': email,
  //     'phone':phone,
  //     'location': location
  //   };
  // }
}
