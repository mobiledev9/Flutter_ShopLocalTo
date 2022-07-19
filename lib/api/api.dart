import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shoplocalto/api/http_manager.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:http/http.dart' as http;

// firebase_core: ^0.4.4+3
class Api {
  ///URL API
  static const String AUTH_LOGIN = "/jwt-auth/v1/token";
  static const String AUTH_VALIDATE = "/jwt-auth/v1/token/validate";
  static const String GET_SETTING = "/listar/v1/setting/init";
  static const String Post_Login = "http://dev.shoplocalto.ca/api/login";
  static const String Post_Signup = "http://dev.shoplocalto.ca/api/signup";
  static const String Location =
      "http://dev.shoplocalto.ca/api/locations/featured";
  FlutterSecureStorage storage = FlutterSecureStorage();

  ///Login api
  static Future<dynamic> login({String email, String password}) async {
    // print('this is username :$email');
    // print('this is password:$password');
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.noTokenPost(
        url: 'http://dev.shoplocalto.ca/api/login?email=' +
            email +
            '&password=' +
            password);
    return result;
  }

  static Future<dynamic> logOut() async {
    await Future.delayed(Duration(seconds: 1));
    final result =
    await httpManager.post(url: 'http://dev.shoplocalto.ca/api/logout');
    return result;
  }

  //SignUp api
  static Future<dynamic> signup(
      {String username,
        String email,
        String password,
        String phone,
        String location}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.noTokenPost(
        url: 'http://dev.shoplocalto.ca/api/signup?name=' +
            username +
            '&email=' +
            email +
            '&location=' +
            location +
            '&password=' +
            password + "&phone=" + phone);
    print('sign log=-=-=- $result');

    return result;
  }

  //Social login api
  static Future<dynamic> socialLogin(
      {String name,
        String email,
        String provider,
        String provider_id,
        String profile_image}) async {
    final result = await httpManager.noTokenPost(
        url: 'http://dev.shoplocalto.ca/api/social-login?name=' +
            name +
            '&email=' +
            email +
            '&provider=' +
            provider +
            '&provider_id=' +
            provider_id +
            '&profile_image=' +
            profile_image);
    log(result.toString());
    return result;
  }

  static Future<List<MyLocation>> getSuggestedLocation() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.noTokenPost(
        url: 'http://dev.shoplocalto.ca/api/locations');
    return MyLocation.listFromJson(result['data']['locations']);
  }

  // /Update profile api
  static Future<dynamic> contactUs({
    String username,
    String email,
    String comment,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/contact-us?name=' +
            username +
            '&email=' +
            email +
            '&comment=' +
            comment);
    return result;
  }

  static Future<BannerPageModel> getUserBanner() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.noTokenPost(
        url: "http://dev.shoplocalto.ca/api/intro-banners");
    print(
        'jcbnujnddjndfvhnfjnvdfvhdfbnjv ........... fvjfbnjbnjbnjdnjcn kjcnjnj fbv d dv f ${result['data']}');
    return BannerPageModel.fromJson(result['data']);
  }

//up[date chating session
  static Future<dynamic> chatWithUs({String comment, int companyid}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/messages?comment=' +
            comment +
            '&company_id=' +
            companyid.toString());
    return result;
  }

  static Future<dynamic> deletemsg({int id}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/delete-messages?id=' +
            id.toString());
    return result;
  }

  // /Update profile api
  static Future<dynamic> editProfile(
      {String username,
        String email,
        String address,
        String website,
        String phone,
        String info,
        File image}) async {
    // await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/update-profile?name=' +
            username +
            '&email=' +
            email +
            '&address=' +
            address +
            '&website=' +
            website +
            '&information=' +
            info +
            '&phone=' +
            phone,
        data: {'image': image});
    return result;
  }

  Future<http.StreamedResponse> editImage(String filePath) async {
    String token = await storage.read(key: 'token');
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://dev.shoplocalto.ca/api/update-profile'));
    request.files.add(await http.MultipartFile.fromPath('image', filePath));
    request.headers.addAll({
      'Content-type': 'multipart/form-data',
      'Authorization': 'Bearer $token'
    });
    var response = request.send();
    return response;
  }

  // /Update password api
  static Future<dynamic> editPassword(
      {String password, String confirmpassword}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/update-password?password=' +
            password +
            '&confirm_password=' +
            confirmpassword);
    return result;
  }

  // Reset password send code api
  static Future<dynamic> resetPasswordsendcode({
    String email,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/send-reset-code?email=' + email);
    return result;
  }

  // verify code api
  static Future<dynamic> verifycode({String email, String code}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/verify-code?email=' +
            email +
            '&code=' +
            code);
    return result;
  }

  // verify code api
  static Future<dynamic> setnewpassword({
    String email,
    String code,
    String newpass,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/reset-password?email=' +
            email +
            '&code=' +
            code +
            '&password=' +
            newpass);
    return result;
  }

  // Get sHOP DETAIL @SANJANA
  static Future<dynamic> getDetail({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/vendortabs?id=14' + id.toString());
    return result;
  }

  // // sanjana
  //  static Future<NearlyModel> getNearlyDetail({id: 0}) async {
  //   await Future.delayed(Duration(seconds: 1));
  //   final result = await httpManager.post(url:'http://dev.shoplocalto.ca/api/vendortabs?id='+id.toString());
  //    print('...........getNearlyDetail()............:${result['data']['nearly']}');
  //   return NearlyModel.fromJson(result['data']['nearly']);
  // }

  // sanjana
  static Future<UserModel> getUserDetail({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/vendortabs?id=' + id.toString());
    // print('...........getUserDetail()............:${result['data']['author']}');
    return UserModel.fromJson(result['data']['author']);
  }

  static Future<List<ImageModel>> getbannerPhoto({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/vendortabs?id=' + id.toString());
    //  print('getShops():$result.runT');
    return ImageModel.listFromJson(result['data']['photo']);
  }

  //  static Future<List<TabModel>> getTabDetail({id: 0}) async {
  //   await Future.delayed(Duration(seconds: 1));
  //   final result = await httpManager.post(url:'http://dev.shoplocalto.ca/api/vendortabs?id='+id.toString());
  // //  print('getShops():$result.runT');
  //  return TabModel.listFromJson(result['data']['tabs']);
  // }
  static Future<CategoryModel2> getCategoryDetailList({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/category-vendors?id=' +
            id.toString());
    //  print('getCategoryDetailList():__________________________________${result['data']['list']}');
    return CategoryModel2.fromJson(result['data']);
  }

  ///id home required
  static Future<CategoryPageModel> getCategoryViewList() async {
    await Future.delayed(Duration(seconds: 1));
    final result =
    await httpManager.post(url: 'http://dev.shoplocalto.ca/api/home');
    return CategoryPageModel.fromJson(result['data']);
  }

  static Future<List<ListModel>> getListDetailList({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/category-vendors?id=' +
            id.toString());
    //  print('getListDetailList():__________________________________${result['data']['list']}');
    return ListModel.listFromJson(result['data']['list']);
  }

  // sanjana
  static Future<ProductModel> getShopDataDetail({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/vendortabs?id=' + id.toString());
    print('...........getShopDataDetail()............:${result['data']['id']}');
    return ProductModel.fromJson(result['data']);
  }

  // // sanjana
  static Future<PopularModel> getLocationDataDetail({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/location-details?id=' +
            id.toString());
    return PopularModel.fromJson(result['data']);
  }

  // sanjana
  static Future<List<RelatedModel>> getRelatedDetail({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/vendortabs?id=' + id.toString());
    //  print('...........getRelatedDetail()............:${result['data']['feature']}');
    return RelatedModel.listFromJson(result['data']['related']);
  }

  // sanjana
  static Future<List<FeatureModel>> getFeatureDetail({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/vendortabs?id=' + id.toString());
    return FeatureModel.listFromJson(result['data']['feature']);
  }

  // sanjana
  static Future<List<NearbyModel>> getLocationNearbyDetail({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/location-details?id=' +
            id.toString());
    // print("//////////////////////////////////////////////////////////////////////////////////////////////////${result['data']['nearby']}");
    return NearbyModel.listFromJson(result['data']['nearby']);
  }

  static Future<List<ShopModel>> getLocationShopDetail({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/location-details?id=' +
            id.toString());
    // print("//////////////////////////////////////////////////////////////////////////////////////////////////${result['data']['nearby']}");
    return ShopModel.listFromJson(result['data']['list']);
  }

  ///Validate token valid
  static Future<dynamic> validateToken() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/valid_token.json");
    return ResultApiModel.fromJson(result);
  }

  ///Forgot password
  static Future<dynamic> forgotPassword() async {
    return await httpManager.post(url: "");
  }

  ///Get Setting
  static Future<dynamic> getSetting() async {
    final result = await httpManager.get(url: GET_SETTING);
    return ResultApiModel.fromJson(result);
  }

  ///Get Profile Detail
  static Future<dynamic> getProfile() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/profile.json");
    return ResultApiModel.fromJson(result);
  }

  // /Get Profile Detail
  static Future<UserModel> getUserProfile() async {
    await Future.delayed(Duration(seconds: 1));
    final result =
    await httpManager.post(url: 'http://dev.shoplocalto.ca/api/user');
    print('this is ...............getUserProfile...........$result');
    return UserModel.fromJson(result);
  }

  ///Get Category
  static Future<dynamic> getCategory() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/category.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get About Us
  static Future<dynamic> getAboutUs() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/about_us.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get About Us sANJANA
  static Future<AboutUsModel> getAboutUsInfo() async {
    await Future.delayed(Duration(seconds: 1));
    final result =
    await httpManager.post(url: 'http://dev.shoplocalto.ca/api/about-us');
    print(
        'getAboutUsInfo()..............#############>.........${result['data']['details']}');
    return AboutUsModel.fromJson(result['data']['details']);
  }

  ///Get Home
  static Future<HomePageModel> getHome({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/home?id=' + id.toString());
    print(
        'jdbvjkdbjkvbj fjbkjdb dbfubm fjkbd......mmmmmmmmmmmmmm....${result['data']['banners']}');
    print(id);
    log(id.toString());
    return HomePageModel.fromJson(result['data']);
  }

  ///Get Messages
  static Future<dynamic> getMessage() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/message.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Messages list already chatted memebers list
  static Future<dynamic> getMessagesList() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/allmessages');
    print(
        '+++++++++++++++++++++++++++++++++++------------------------${result['data']}');
    return MessagePageModel.fromJson(result['data']);
  }

  ///Get Detail Messages
  static Future<dynamic> getDetailMessage({int id}) async {
    await Future.delayed(Duration(seconds: 1));
    final result =
    await UtilAsset.loadJson("assets/data/message_detail_$id.json");
    print('$result');
    return ResultApiModel.fromJson(result);
  }

//I/flutter (16292): request option http://dev.shoplocalto.ca/api/messages?comment=Lets%20Chat&company_id=17
// I/flutter (16292): request option http://dev.shoplocalto.ca/api/message-list?company_id=17
  ///Get Detail Messages
  static Future<dynamic> getVendorMessage({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/message-list?company_id=' +
            id.toString());
    print('$result');
    return ChatPageModel.fromJson(result['data']);
  }

  ///Get Notification
  static Future<dynamic> getNotification() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/notification.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Notification sanjana
  static Future<NotificationPageModel> getUserNotification() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: "http://dev.shoplocalto.ca/api/notifications");
    print(
        'jcbnujnddjndfvhnfjnvdfvhdfbnjv ........... fvjfbnjbnjbnjdnjcn kjcnjnj fbv d dv f ${result['data']}');
    return NotificationPageModel.fromJson(result['data']);
  }

  // /Get ProductDetail and Product Detail Tab
  static Future<dynamic> getProductDetail({id: 0, tabExtend: false}) async {
    await Future.delayed(Duration(seconds: 1));
    String path = "assets/data/product_detail_$id.json";
    if (tabExtend) {
      path = "assets/data/product_detail_tab_$id.json";
    }
    final result = await UtilAsset.loadJson(path);
    return ResultApiModel.fromJson(result);
  }

  static Future<dynamic> getLoadTabDetail({id: 0, tabExtend: false}) async {
    await Future.delayed(Duration(seconds: 1));
    String path =
        'http://dev.shoplocalto.ca/api/vendortabs?id=' + id.toString();
    if (tabExtend) {
      path = 'http://dev.shoplocalto.ca/api/vendortabs?id=' + id.toString();
    }
    final result = await httpManager.post(url: path);
    print('this is the............................... result tab data$result');
    return ResultApiModel.fromJson(result);
  }

  // sanjana
  // static Future<List<TabModel>> getTabtabDetail({id: 0, tabExtend: false}) async {
  //   await Future.delayed(Duration(seconds: 1));
  //   final result = await httpManager.post(url:'http://dev.shoplocalto.ca/api/vendortabs?id='+id.toString());
  //   // print('this is the result tab data${result['data']['tabs']}');
  //   return TabModel.listFromJson(result['data']['tabs']);
  // }
// getLIST SANJANA

  static Future<ProductListPageModel> getList({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/category-vendors?id=' +
            id.toString());
    // print('/././//............./////...getList${result['data']}');
    return ProductListPageModel.fromJson(result['data']);
  }

  static Future<dynamic> addwishList({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/add-wishlist?id=' + id.toString());
    return result;
  }

  static Future<dynamic> removewishList({id: 0}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/del-wishlist?id=' + id.toString());
    return result;
  }

  static Future<ProductListPageModel> getSearchResult(
      {String id, String keyword}) async {
    // await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/search-results?category_id=' +
            id.toString() +
            '&search_keyword=' +
            keyword);
    //  print('getShops():$result.runT');
    print("searchapi: ${result.toString()}");
    return ProductListPageModel.fromJson(result['data']['data']);
  }

  static Future<ProductListPageModel> getSearchResultfac(
      {int id,
        String keyword,
        List<dynamic> facilities,
        String opentime,
        String closetime,
        String minprice,
        String maxprice}) async {
    // await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/search-results?category_id=' +
            id.toString() +
            '&search_keyword=' +
            keyword +
            '&facilities=' +
            facilities.toString() +
            '&open_time=' +
            opentime +
            '&close_time=' +
            closetime +
            '&min_price=' +
            minprice.toString() +
            '&max_price=' +
            maxprice.toString());
    print("searchapifilters: ${result}");

    return ProductListPageModel.fromJson(result['data']['data']);
  }

  static Future<ProductListPageModel> getSearchResultwithoutfac(
      {int id,
        String keyword,
        String opentime,
        String closetime,
        String minprice,
        String maxprice}) async {
    // await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/search-results?category_id=' +
            id.toString() +
            '&search_keyword=' +
            keyword +
            '&open_time=' +
            opentime +
            '&close_time=' +
            closetime +
            '&min_price=' +
            minprice.toString() +
            '&max_price=' +
            maxprice.toString());
    print("searchapifilters: ${result}");

    return ProductListPageModel.fromJson(result['data']['data']);
  }

  static Future<ProductListPageModel> getfilters() async {
    // await Future.delayed(Duration(seconds: 1));
    final result =
    await httpManager.post(url: 'http://dev.shoplocalto.ca/api/facilities');
    //  print('getShops():$result.runT');
    print('faci: $result');
    return ProductListPageModel.fromJson(result['data']);
  }

  static Future<List<ListModel>> getallshops() async {
    // await Future.delayed(Duration(seconds: 1));
    final result =
    await httpManager.post(url: 'http://dev.shoplocalto.ca/api/allshops');
    //  print('getShops():$result.runT');
    print('allshops: $result');
    return ListModel.listFromJson(result['data']['list']);
  }

  // static Future<ProductListPageModel> getSearchResult({
  //   id: 0,
  //   keyword: 'abc',
  //   minprice: 10,
  //   maxprice: 100,
  //   opentime:10,
  //   closetime:10,
  // facilities:'abc'
  //
  // }) async {
  //   // await Future.delayed(Duration(seconds: 1));
  //  final header = {
  //     'category_id': id,
  //     'search_keyword': keyword,
  //     'min_price': minprice,
  //     'max_price': maxprice,
  //     'open_time': opentime,
  //     'close_time': closetime,
  //     'facilities': facilities,
  //   };
  //   final result = await httpManager.post(
  //       url: 'http://dev.shoplocalto.ca/api/search-results?',);
  //   //  print('getShops():$result.runT');
  //   return ProductListPageModel.fromJson(result['data']['data']);
  // }

  ///Get Product List
  // static Future<ProductListPageModel> getList({id: 0}) async {
  //   await Future.delayed(Duration(seconds: 1));
  //   final result = await httpManager.post(url:'http://dev.shoplocalto.ca/api/category-vendors?id='+id.toString());
  //   print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${result['data']}');
  //   print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhgetListhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${result['data']['list']}');
  //   return ProductListPageModel.fromJson(result['data']);
  // }
  //   static Future<List<ListModel>> getListList({id: 0}) async {
  //   await Future.delayed(Duration(seconds: 1));
  //   final result = await httpManager.post(url:'http://dev.shoplocalto.ca/api/category-vendors?id='+id.toString());
  //   print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${result['data']}');
  //   print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhgetListhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${result['data']['list']}');
  //   return ListModel.listFromJson(result['data']['list']);
  // }

  ///Get History Search
  static Future<dynamic> getHistorySearch() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/search_history.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Wish List edited sanjana
//   static Future<dynamic> getWishList() async {
//     await Future.delayed(Duration(seconds: 1));
// //  final result = await httpManager.post(url:'http://dev.shoplocalto.ca/api/locations');
//   //  print('getPopular():$result.runT');
//   //  return ShopModel.listFromJson(result['locations']);
//     final result = await UtilAsset.loadJson("assets/data/wishlist.json");
//     return ResultApiModel.fromJson(result);
//   }
  static Future<dynamic> getRefreshToken() async {
    await httpManager.post(url: 'http://dev.shoplocalto.ca/api/refresh');
  }

  static Future<WishListPageModel> getWishList() async {
    await Future.delayed(Duration(seconds: 1));
    final result =
    await httpManager.post(url: 'http://dev.shoplocalto.ca/api/wishlist');
    print('..........wishlist................::::::$result');

    return WishListPageModel.fromJson(result['data']);
  }

  ///On Search
  static Future<dynamic> onSearchData() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/search_result.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Location List
  static Future<dynamic> getLocationList() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/location.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Product List
  static Future<dynamic> getProduct() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/product_list.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Review
  static Future<dynamic> getReview() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/review.json");
    return ResultApiModel.fromJson(result);
  }
  // @sanjana

  static Future<HomePageModel> getHomePage({
    id: 0,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
        url: 'http://dev.shoplocalto.ca/api/home?id=' + id);
    //  print('getPopular():${result['data']['locations']}');
    return HomePageModel.fromJson(result['data']);
  }

  static Future<List<MyLocation>> getPopular() async {
    await Future.delayed(Duration(seconds: 1));
    final result =
    await httpManager.post(url: 'http://dev.shoplocalto.ca/api/home');
    //  print('getPopular():${result['data']['locations']}');
    return MyLocation.listFromJson(result['data']['popular']);
  }
// non token api

  static Future<List<CategoryModel2>> getCategoryList() async {
    await Future.delayed(Duration(seconds: 1));
    final result =
    await httpManager.post(url: 'http://dev.shoplocalto.ca/api/home');
    print(
        'getCategoryList()..........................................................................................:${result['data']['category']}');
    return CategoryModel2.listFromJson(result['data']['category']);
  }

  static Future<List<ShopModel>> getShops({
    id: 0,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await httpManager.post(
      url: 'http://dev.shoplocalto.ca/api/home?id=' + id.toString(),
    );
    //  print('getShops():$result.runT');
    return ShopModel.listFromJson(result['data']['list']);
  }



  static Future<List<PopularPageModel>> getHomeData() async {
    await Future.delayed(Duration(seconds: 1));
    final result =
    await httpManager.post(url: 'http://dev.shoplocalto.ca/api/home');
    //  print('getHomeData():$result.runT');
    return PopularPageModel.listFromJson(result['data']);
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
