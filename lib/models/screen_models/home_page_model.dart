import 'package:shoplocalto/models/model.dart';

class HomePageModel {
   List<ImageModel> banners;
bool success;
String message;
   List<MyLocation> locations;
  List<ShopModel> shops;
   List<CategoryModel2> category;
  // final List<ProductModel> popular;
  // final List<ProductModel> list;

  HomePageModel(
    this.banners,
    this.message,
    this.success,
    this.category,
    this.locations,
    this.shops,
  );

  @override
  String toString() {
    return toJson().toString();
  }

  HomePageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    success = json['success'];
    message = json['message'];
    category = _setCategory(json['category']);
    locations = _setLocations(json['popular']);
    shops = _setShops(json['list']);
    banners = _setBanner(json['banners']);

  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if(success!=null) json['success']=success;
    if(message!=null) json['message']=message;
    if(category!=null) json['category']=category;
    if(locations!=null) json['popular']=locations;
    if(shops!=null) json['list']=shops;
     if(banners!=null) json['banners']=banners;

    return json;
  }

    static List<CategoryModel2> _setCategory(category) {
    if (category != null) {
      final Iterable refactorFeature = category;
      return refactorFeature.map((item) {
        return CategoryModel2.fromJson(item);
      }).toList();
    }
    return null;
  }
    static List<MyLocation> _setLocations(popular) {
    if (popular != null) {
      final Iterable refactorFeature = popular;
      return refactorFeature.map((item) {
        return MyLocation.fromJson(item);
      }).toList();
    }
    return null;
  }
    static List<ShopModel> _setShops(list) {
    if (list != null) {
      final Iterable refactorFeature = list;
      return refactorFeature.map((item) {
        return ShopModel.fromJson(item);
      }).toList();
    }
    return null;
  }

   static List<ImageModel> _setBanner(banners) {
    if (banners != null) {
      final Iterable refactorFeature = banners;
      return refactorFeature.map((item) {
        return ImageModel.fromJson(item);
      }).toList();
    }
    return null;
  }


  static List<HomePageModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<HomePageModel>()
        : json.map((value) => HomePageModel.fromJson(value)).toList();
  }

  // factory HomePageModel.fromJson(Map<String, dynamic> json) {
  //   final Iterable refactorBanner = json['banner'] ?? [];
  //   final Iterable refactorCategory = json['category'] ?? [];
  //   final Iterable refactorPopular = json['popular'] ?? [];
  //   final Iterable refactorList = json['list'] ?? [];

  //   final listBanner = refactorBanner.map((item) {
  //     return ImageModel.fromJson(item);
  //   }).toList();

  //   final listCategory = refactorCategory.map((item) {
  //     return CategoryModel.fromJson(item);
  //   }).toList();

  //   final listPopular = refactorPopular.map((item) {
  //     return ProductModel.fromJson(item);
  //   }).toList();

  //   final listProduct = refactorList.map((item) {
  //     return ProductModel.fromJson(item);
  //   }).toList();


  //   return HomePageModel(
  //     listBanner,
  //     listCategory,
  //     listPopular,
  //     listProduct,
  //   );
  // }
}
