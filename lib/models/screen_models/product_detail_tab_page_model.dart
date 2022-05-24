import 'package:shoplocalto/models/model.dart';

// class ProductDetailTabPageModel {
//    List<TabModel> tab;
//    ProductModel product;

//   ProductDetailTabPageModel(
//    this.product,
//     this.tab,
//   );


//  ProductDetailTabPageModel.fromJson(Map<String, dynamic> json) {
//     if (json == null) return;
//     tab =_setTab( json['data']['tabs']); 
//     product=_setProduct(json['data']);  
//   }

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     if (tab != null) json['data']['tabs'] = tab;
//      if (product != null) json['data'] = product;

//     return json;
//   }

//   static ProductModel _setProduct(Map<String, dynamic> author) {
//     if (author != null) {
//       return ProductModel.fromJson(author);
//     }
//     return null;
//   }
//   static List<TabModel> _setTab(tab) {
//     if (tab != null) {
//       final Iterable refactorTab = tab ?? [];
//       return refactorTab.map((item) {
//         return TabModel.fromJson(item);
//       }).toList();
//     }
//     return null;
//   }

//   static List<ProductDetailTabPageModel> listFromJson(List<dynamic> json) {
//     return json == null
//         ? List<ProductDetailTabPageModel>()
//         : json.map((value) => ProductDetailTabPageModel.fromJson(value)).toList();
//   }

// }

class ProductDetailTabPageModel {
  final ProductModel product;
  final List<TabModel> tab;

  ProductDetailTabPageModel(
    this.product,
    this.tab,
  );

  static List<TabModel> _setTab(tab) {
    if (tab != null) {
      final Iterable refactorTab = tab ?? [];
      return refactorTab.map((item) {
        return TabModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  factory ProductDetailTabPageModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailTabPageModel(
      ProductModel.fromJson(json),
      _setTab( json['tabs']),
    );
  }
}