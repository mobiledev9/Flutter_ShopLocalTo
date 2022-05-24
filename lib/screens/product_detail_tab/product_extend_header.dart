import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/screens/product_detail_tab/product_detail_tab.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';

class ProductHeader extends SliverPersistentHeaderDelegate {
  final double height;
  final ProductDetailTabPageModel productTabPage;
  bool like;
  final VoidCallback onPressLike;
  final VoidCallback onLocation;
  final VoidCallback onMessagesend;
  final VoidCallback onPressunLike;
  final VoidCallback onPressReview;


  ProductHeader( {
    this.height,
    this.productTabPage,
    this.like,
    this.onPressLike,
    this.onLocation,
    this.onMessagesend,
    this.onPressunLike,
    this.onPressReview,
  });


  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    ///Build info
    Widget information() {
      if (productTabPage == null) {

        return Shimmer.fromColors(
          baseColor: Theme.of(context).hoverColor,
          highlightColor: Theme.of(context).highlightColor,
          enabled: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  top: 20,
                ),
                height: 10,
                width: 150,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Container(
                        height: 20,
                        width: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                    width: 100,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        );
      }
      print(" wishfav ${productTabPage.product.favorite}");



      print(" fav ${like}");
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                productTabPage?.product?.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w600),
              ),

              Row(
                children: [
                  IconButton(

                    icon: Icon(like == true ? Icons.favorite :Icons.favorite_border,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    onPressed: like == true ? onPressunLike : onPressLike,
                  ),
                  GestureDetector(
                    onTap: (){
                      onMessagesend();
                    },
                    child: Container(
                      height: height * 0.2,
                      decoration: BoxDecoration(
                        color: Theme.of(context).buttonColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.only(left: 10,right:10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Message",
                              style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // if(like == false)
              //   IconButton(
              //
              //     icon: Icon(
              //       color: Theme.of(context).primaryColorLight,
              //     ),
              //     onPressed:onPressLike,
              //   ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              InkWell(
                onTap: (){
                  onLocation();
                },
                child: Text(
                  productTabPage?.product?.neighbourhoodName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              GestureDetector(
                onTap: (){
                  onPressReview();
                },
                child: Text(
                  "Review",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              productTabPage?.product?.status != null
                  ? AppTag(
                productTabPage?.product?.status,
                type: TagType.status,
              )
                  : Container(),
            ],
          ),
        ],
      );
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 15,
        ),
        child: Column(
          children: <Widget>[
            // AppUserInfo(
            //   user: productTabPage?.product?.author,
            //   onPressed: () {},
            //   type: AppUserType.basic,
            // ),
            information(),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

}


// import 'package:flutter/material.dart';
// import 'package:listar_flutter/configs/config.dart';
// import 'package:listar_flutter/models/screen_models/screen_models.dart';
// import 'package:listar_flutter/widgets/widget.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:listar_flutter/models/model.dart';

// class ProductHeader extends SliverPersistentHeaderDelegate {
//   final double height;
//   final ProductDetailTabPageModel productTabPage;
//   final bool like;
//   final VoidCallback onPressLike;
//   final VoidCallback onPressReview;
//   final ProductModel productModel;
//   final UserModel userModel;

//   ProductHeader(  {
//     this.height,
//     this.productTabPage,
//     this.like,
//     this.onPressLike,
//     this.onPressReview, this.productModel, this.userModel,
//   });

//   @override
//   Widget build(context, shrinkOffset, overlapsContent) {
//     ///Build info
//     Widget information() {
//       if (productModel == null) {
//         return Shimmer.fromColors(
//           baseColor: Theme.of(context).hoverColor,
//           highlightColor: Theme.of(context).highlightColor,
//           enabled: true,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.only(
//                   bottom: 20,
//                   top: 20,
//                 ),
//                 height: 10,
//                 width: 150,
//                 color: Colors.white,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         height: 10,
//                         width: 100,
//                         color: Colors.white,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 5),
//                       ),
//                       Container(
//                         height: 20,
//                         width: 150,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 10,
//                     width: 100,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       }

//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 productModel.title,
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline6
//                     .copyWith(fontWeight: FontWeight.w600),
//               ),
//               IconButton(
//                 icon: Icon(
//                   like ? Icons.favorite : Icons.favorite_border,
//                   color: Theme.of(context).primaryColorLight,
//                 ),
//                 onPressed: onPressLike,
//               )
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               InkWell(
//                 onTap: onPressReview,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       productModel.subtitle,
//                       style: Theme.of(context).textTheme.bodyText1,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(top: 3),
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         AppTag(
//                           "${productModel.rate}",
//                           type: TagType.rateSmall,
//                         ),
//                         Padding(padding: EdgeInsets.only(left: 5)),
//                         StarRating(
//                           rating: productModel.rate,
//                           size: 14,
//                           color: AppTheme.yellowColor,
//                           borderColor: AppTheme.yellowColor,
//                           onRatingChanged: (v) {
//                             onPressReview();
//                           },
//                         ),
//                         Padding(padding: EdgeInsets.only(left: 5)),
//                         // Text(
//                         //   "(${productModel.numRate})",
//                         //   style: Theme.of(context).textTheme.bodyText1,
//                         // ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               productModel.status != null
//                   ? AppTag(
//                       productModel.status,
//                       type: TagType.status,
//                     )
//                   : Container(),
//             ],
//           ),
//         ],
//       );
//     }

//     return SafeArea(
//       top: false,
//       bottom: false,
//       child: Container(
//         padding: EdgeInsets.only(
//           left: 20,
//           right: 20,
//           top: 15,
//         ),
//         child: Column(
//           children: <Widget>[
//             AppUserInfo(
//               user: productModel.author,
//               onPressed: () {},
//               type: AppUserType.basic,
//             ),
//             information(),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   double get maxExtent => height;

//   @override
//   double get minExtent => height;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }
