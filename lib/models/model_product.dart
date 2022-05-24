import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/model_marketplace.dart';

enum ProductType {
  place,
  hotel,
  shop,
  drink,
  event,
  estate,
  job,
  restaurant,
  automotive,
  more
}

class ProductModel {
  int id;
  String title;
  String subtitle;
  String image;
  String createDate;
  bool like;
  num rate;
  num numRate;
  String rateText;
  String status;
  bool favorite;
  String address;
  String phone;
  String email;
  String website;
  String hour;
  String description;
  String date;
  String priceRange;
  List<ImageModel> photo;
  List<HourModel> hourDetail;
  List<IconModel> service;
  List<Marketplace> marketplace;
  List<ProductModel> feature;
  List<ProductModel> related;
  List<NearlyModel> nearly;
  List<ProductModel> tabs;
  List<NearbyModel> nearby;
  List<ListModel> list;
  List<SocialIcon> social;
  LocationModel location;
  UserModel author;
  ProductType type;
  // List<SocialIcon> socialicon;
  SocialIcon socialicon;
  String neighbourhoodName;
  String iconData;
  String social_media;
  String link;
  String icon;
  bool wishlist;
  // icon: FaIcon(FontAwesomeIcons.gamepad),

  ProductModel(
    this.id,
    this.title,
    this.subtitle,
    this.image,
    this.createDate,
    this.like,
    this.rate,
    this.numRate,
    this.rateText,
    this.status,
    this.favorite,
    this.address,
    this.phone,
    this.email,
    this.website,
    this.hour,
    this.description,
    this.date,
    this.priceRange,
    this.hourDetail,
    this.service,
    this.marketplace,
    this.photo,
    this.feature,
    this.related,
    this.location,
    this.author,
    this.type,
    this.socialicon,
    this.tabs,
    this.nearly,
    this.nearby,
    this.list,
    this.neighbourhoodName,
    this.iconData,
    this.social,
    this.social_media,
    this.link,
    this.icon,
    this.wishlist,
  );

  @override
  String toString() {
    return toJson().toString();
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    image = json['image'];
    createDate = json['createDate'];
    like = json['like'];
    rate = json['rate'];
    numRate = json['num_rate'];
    rateText = json['rate_text'];
    status = json['status'];
    favorite = json['favourite'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    hourDetail = _setHourDetail(json['hour_detail']);
    description = json['description'];
    date = json['date'];
    priceRange = json['price_range'];
    hour = json['hour'];
    service = _setService(json['service']);
    marketplace = _setMarketPlace(json['marketplace']);
    photo = _setPhoto(json['photo']);
    feature = _setFeature(json['feature']);
    related = _setRelated(json['related']);
    location = _setLocation(json['location']);
    author = _setAuthor(json['author']);
    type = _setType(json['type']);
    tabs = _setTab(json['tabs']);
    socialicon = _setSocial(json['socialicon']);
    nearly = _setNearly(json['nearly']);
    nearby = _setNearby(json['nearby']);
    list = _setList(json['list']);
    neighbourhoodName = json['neighbourhood'];
    iconData = json['icon'];
    social = _setSocialList(json['social']);
    wishlist = json['wishlist'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (title != null) json['title'] = title;
    if (subtitle != null) json['subtitle'] = subtitle;
    if (image != null) json['image'] = image;
    if (type != null) json['type'] = type;
    if (createDate != null) json['createDate'] = createDate;
    if (like != null) json['like'] = like;
    if (rate != null) json['rate'] = rate;
    if (numRate != null) json['num_rate'] = numRate;
    if (rateText != null) json['rate_text'] = rateText;
    if (status != null) json['status'] = status;
    if (favorite != null) json['favourite'] = favorite;
    if (address != null) json['address'] = address;
    if (phone != null) json['phone'] = phone;
    if (email != null) json['email'] = email;
    if (website != null) json['website'] = website;
    if (hour != null) json['hour'] = hour;
    if (description != null) json['description'] = description;
    if (date != null) json['date'] = date;
    if (priceRange != null) json['price_range'] = priceRange;
    if (hourDetail != null) json['hourDetail'] = hourDetail;
    if (service != null) json['service'] = service;
    if (marketplace != null) json['marketplace'] = marketplace;
    if (photo != null) json['photo'] = photo;
    if (feature != null) json['feature'] = feature;
    if (related != null) json['related'] = related;
    if (location != null) json['location'] = location;
    if (author != null) json['author'] = author;
    if (type != null) json['type'] = type;
    if (tabs != null) json['tabs'] = tabs;
    if (nearly != null) json['nearly'] = nearly;
    if (nearby != null) json['nearby'] = nearby;
    if (list != null) json['list'] = list;
    if (neighbourhoodName != null) json['neighbourhood'] = neighbourhoodName;
    if (iconData != null) json['icon'] = iconData;
    if (social != null) json['social'] = social;
    if (wishlist != null) json['wishlist'] = wishlist;
    // if (socialicon != null) json['socialicon'] = socialicon;

    return json;
  }

  static List<ProductModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<ProductModel>()
        : json.map((value) => ProductModel.fromJson(value)).toList();
  }

  static List<HourModel> _setHourDetail(hourDetail) {
    if (hourDetail != null) {
      final Iterable refactorHour = hourDetail;
      return refactorHour.map((item) {
        return HourModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<IconModel> _setService(icon) {
    if (icon != null) {
      final Iterable refactorService = icon;
      return refactorService.map((item) {
        return IconModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<Marketplace> _setMarketPlace(marketplace) {
    if (marketplace != null) {
      final Iterable refactorMarketplace = marketplace;
      return refactorMarketplace.map((item) {
        return Marketplace.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<ImageModel> _setPhoto(photo) {
    if (photo != null) {
      final Iterable refactorPhoto = photo;
      return refactorPhoto.map((item) {
        return ImageModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<ProductModel> _setFeature(feature) {
    if (feature != null) {
      final Iterable refactorFeature = feature;
      return refactorFeature.map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<SocialIcon> _setSocialList(social) {
    if (social != null) {
      final Iterable refactorSocial = social;
      return refactorSocial.map((item) {
        return SocialIcon.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<NearlyModel> _setNearly(nearly) {
    if (nearly != null) {
      final Iterable refactorFeature = nearly;
      return refactorFeature.map((item) {
        return NearlyModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<NearbyModel> _setNearby(nearby) {
    if (nearby != null) {
      final Iterable refactorFeature = nearby;
      return refactorFeature.map((item) {
        return NearbyModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<ListModel> _setList(nearby) {
    if (nearby != null) {
      final Iterable refactorFeature = nearby;
      return refactorFeature.map((item) {
        return ListModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<ProductModel> _setTab(tabs) {
    if (tabs != null) {
      final Iterable refactorFeature = tabs;
      return refactorFeature.map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<ProductModel> _setRelated(related) {
    if (related != null) {
      final Iterable refactorRelated = related;
      return refactorRelated.map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static LocationModel _setLocation(Map<String, dynamic> location) {
    if (location != null) {
      return LocationModel.fromJson(location);
    }
    return null;
  }

  static UserModel _setAuthor(Map<String, dynamic> author) {
    if (author != null) {
      return UserModel.fromJson(author);
    }
    return null;
  }

  // temporary social icon
  static SocialIcon _setSocial(socialicon) {
    if (socialicon != null) {
      return SocialIcon.fromJson(socialicon);
    }
    return null;
  }
// real social icon
  // static List<SocialIcon> _setSocial(socialicon) {
  //   if (socialicon != null) {
  //     final Iterable refactorSocial = socialicon;
  //     return refactorSocial.map((item) {
  //       return SocialIcon.fromJson(item);
  //     }).toList();
  //   }
  //   return null;
  // }

  static ProductType _setType(String type) {
    switch (type) {
      case 'hotel':
        return ProductType.hotel;
      case 'shop':
        return ProductType.shop;
      case 'drink':
        return ProductType.drink;
      case 'event':
        return ProductType.event;
      case 'estate':
        return ProductType.estate;
      case 'job':
        return ProductType.job;
      case 'restaurant':
        return ProductType.restaurant;
      case 'automotive':
        return ProductType.automotive;
      default:
        return ProductType.place;
    }
  }
}
// import 'package:shoplocalto/models/model.dart';

// enum ProductType {
//   place,
//   hotel,
//   shop,
//   drink,
//   event,
//   estate,
//   job,
//   restaurant,
//   automotive,
//   more
// }

// class ProductModel {
//   final int id;
//   final String title;
//   final String subtitle;
//   final String image;
//   final String createDate;
//   final bool like;
//   final num rate;
//   final num numRate;
//   final String rateText;
//   final String status;
//   final bool favorite;
//   final String address;
//   final String phone;
//   final String email;
//   final String website;
//   final String hour;
//   final String description;
//   final String date;
//   final String priceRange;
//   final List<ImageModel> photo;
//   final List<HourModel> hourDetail;
//   final List<IconModel> service;
//   final List<ProductModel> feature;
//   final List<ProductModel> related;
//   final LocationModel location;
//   final UserModel author;
//   final ProductType type;

//   ProductModel(
//     this.id,
//     this.title,
//     this.subtitle,
//     this.image,
//     this.createDate,
//     this.like,
//     this.rate,
//     this.numRate,
//     this.rateText,
//     this.status,
//     this.favorite,
//     this.address,
//     this.phone,
//     this.email,
//     this.website,
//     this.hour,
//     this.description,
//     this.date,
//     this.priceRange,
//     this.hourDetail,
//     this.service,
//     this.photo,
//     this.feature,
//     this.related,
//     this.location,
//     this.author,
//     this.type,
//   );

//   static List<HourModel> _setHourDetail(hour) {
//     if (hour != null) {
//       final Iterable refactorHour = hour;
//       return refactorHour.map((item) {
//         return HourModel.fromJson(item);
//       }).toList();
//     }
//     return null;
//   }

//   static List<IconModel> _setService(icon) {
//     if (icon != null) {
//       final Iterable refactorService = icon;
//       return refactorService.map((item) {
//         return IconModel.fromJson(item);
//       }).toList();
//     }
//     return null;
//   }

//   static List<ImageModel> _setPhoto(photo) {
//     if (photo != null) {
//       final Iterable refactorPhoto = photo;
//       return refactorPhoto.map((item) {
//         return ImageModel.fromJson(item);
//       }).toList();
//     }
//     return null;
//   }

//   static List<ProductModel> _setFeature(feature) {
//     if (feature != null) {
//       final Iterable refactorFeature = feature;
//       return refactorFeature.map((item) {
//         return ProductModel.fromJson(item);
//       }).toList();
//     }
//     return null;
//   }

//   static List<ProductModel> _setRelated(related) {
//     if (related != null) {
//       final Iterable refactorRelated = related;
//       return refactorRelated.map((item) {
//         return ProductModel.fromJson(item);
//       }).toList();
//     }
//     return null;
//   }

//   static LocationModel _setLocation(Map<String, dynamic> location) {
//     if (location != null) {
//       return LocationModel.fromJson(location);
//     }
//     return null;
//   }

//   static UserModel _setAuthor(Map<String, dynamic> author) {
//     if (author != null) {
//       return UserModel.fromJson(author);
//     }
//     return null;
//   }

//   static ProductType _setType(String type) {
//     switch (type) {
//       case 'hotel':
//         return ProductType.hotel;
//       case 'shop':
//         return ProductType.shop;
//       case 'drink':
//         return ProductType.drink;
//       case 'event':
//         return ProductType.event;
//       case 'estate':
//         return ProductType.estate;
//       case 'job':
//         return ProductType.job;
//       case 'restaurant':
//         return ProductType.restaurant;
//       case 'automotive':
//         return ProductType.automotive;
//       default:
//         return ProductType.place;
//     }
//   }

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       json['id'] as int ?? 0,
//       json['title'] as String ?? 'Unknown',
//       json['subtitle'] as String ?? 'Unknown',
//       json['image'] as String ?? 'Unknown',
//       json['created_date'] as String ?? 'Unknown',
//       json['like'] as bool ?? false,
//       json['rate'] as num ?? 0,
//       json['num_rate'] as num ?? 0,
//       json['rate_text'] as String ?? 'Unknown',
//       json['status'] as String ?? null,
//       json['favorite'] as bool ?? false,
//       json['address'] as String ?? 'Unknown',
//       json['phone'] as String ?? 'Unknown',
//       json['email'] as String ?? 'Unknown',
//       json['website'] as String ?? 'Unknown',
//       json['hour'] as String ?? 'Unknown',
//       json['description'] as String ?? 'Unknown',
//       json['date'] as String ?? 'Unknown',
//       json['price_range'] as String ?? 'Unknown',
//       _setHourDetail(json['hour_detail']),
//       _setService(json['service']),
//       _setPhoto(json['photo']),
//       _setFeature(json['feature']),
//       _setRelated(json['related']),
//       _setLocation(json['location']),
//       _setAuthor(json['author']),
//       _setType(json['type']),
//     );
//   }
// }
