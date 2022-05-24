import 'package:flutter/material.dart';
import 'package:shoplocalto/configs/theme.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';


enum PopularViewType { small, gird, list, block, cardLarge, cardSmall }

class AppPopularItem extends StatelessWidget {

  final PopularModel item;
  final NearbyModel nearbyModel;
  final ShopModel shopModel;//productViewType:grid
  final PopularViewType type;
  final Function(NearbyModel) onPressNearby;
  final Function(ShopModel)onPressShops;
final Function(ShopModel) onPressshop;
  const AppPopularItem({Key key, this.item, this.type,this.onPressshop,this.onPressNearby, this.nearbyModel, this.shopModel, this.onPressShops}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('++++++Appproductmodel+++++++++++++++${item.address}+++++++++++');
      // print('++++++Appfeature+++++++++++++++${item.feature.length}+++++++++++');
      // print('++++Apprelated+++++++++++++++++${nearlyModel.address}+++++++++++');
    switch (type) {

      // ///Mode View Small
      // case PopularViewType.small:
      //   if (nearbyModel == null) {
      //     return Shimmer.fromColors(
      //       child: Row( 
      //         children: <Widget>[
      //           ClipRRect(
      //             borderRadius: BorderRadius.circular(8),
      //             child: Container(
      //               width: 80,
      //               height: 80,
      //               color: Colors.white,
      //             ),
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(
      //               left: 10,
      //               right: 10,
      //               top: 5,
      //               bottom: 5,
      //             ),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 Container(
      //                   height: 10,
      //                   width: 180,
      //                   color: Colors.white,
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.only(top: 5),
      //                 ),
      //                 Container(
      //                   height: 10,
      //                   width: 150,
      //                   color: Colors.white,
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.only(top: 10),
      //                 ),
      //                 Container(
      //                   height: 10,
      //                   width: 100,
      //                   color: Colors.white,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //       baseColor: Theme.of(context).hoverColor,
      //       highlightColor: Theme.of(context).highlightColor,
      //     );
      //   }

      //   return FlatButton(
      //     onPressed: () {
      //       // onPressNearby(nearbyModel);
      //     },
      //     padding: EdgeInsets.all(0),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(8),
      //     ),
      //     child: Row(
      //       children: <Widget>[
      //         ClipRRect(
      //           borderRadius: BorderRadius.circular(8),
      //           child: Image.network(
      //             nearbyModel.picture,
      //             width: 80,
      //             height: 80,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //         Padding(
      //           padding: EdgeInsets.only(
      //             left: 10,
      //             right: 10,
      //             top: 5,
      //             bottom: 5,
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: <Widget>[
      //               Text(
      //                 nearbyModel.name,
      //                 maxLines: 1,
      //                 style: Theme.of(context)
      //                     .textTheme
      //                     .subtitle2
      //                     .copyWith(fontWeight: FontWeight.w600),
      //               ),
      //               Padding(padding: EdgeInsets.only(top: 5)),
      //               // Text(
      //               //   nearbyModel.name,
      //               //   style: Theme.of(context)
      //               //       .textTheme
      //               //       .caption
      //               //       .copyWith(fontWeight: FontWeight.w600),
      //               // ),
      //               Padding(padding: EdgeInsets.only(top: 10)),
      //               // Row(
      //               //   crossAxisAlignment: CrossAxisAlignment.center,
      //               //   children: <Widget>[
      //               //     AppTag(
      //               //       "${nearbyModel.rate}",
      //               //       type: TagType.rateSmall,
      //               //     ),
      //               //     Padding(padding: EdgeInsets.only(left: 5)),
      //               //     StarRating(
      //               //       rating: nearbyModel.rate,
      //               //       size: 14,
      //               //       color: AppTheme.yellowColor,
      //               //       borderColor: AppTheme.yellowColor,
      //               //     )
      //               //   ],
      //               // )
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   );
    
      // /Mode View Gird
      // case PopularViewType.gird:
      //   if (shopModel == null) {
      //     return Shimmer.fromColors(
      //       child: Container(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: <Widget>[
      //             Container(
      //               height: 120,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.all(
      //                   Radius.circular(8),
      //                 ),
      //                 color: Colors.white,
      //               ),
      //             ),
      //             Padding(padding: EdgeInsets.only(top: 5)),
      //             Container(
      //               height: 10,
      //               width: 80,
      //               color: Colors.white,
      //             ),
      //             Padding(padding: EdgeInsets.only(top: 5)),
      //             Container(
      //               height: 10,
      //               width: 100,
      //               color: Colors.white,
      //             ),
      //             Padding(padding: EdgeInsets.only(top: 10)),
      //             Container(
      //               height: 20,
      //               width: 100,
      //               color: Colors.white,
      //             ),
      //             Padding(padding: EdgeInsets.only(top: 10)),
      //             Container(
      //               height: 10,
      //               width: 80,
      //               color: Colors.white,
      //             ),
      //           ],
      //         ),
      //       ),
      //       baseColor: Theme.of(context).hoverColor,
      //       highlightColor: Theme.of(context).highlightColor,
      //     );
      //   }

      //   return FlatButton(
         
      //     onPressed: () {
      //       onPressShops(shopModel);
      //     },
      //     padding: EdgeInsets.all(0),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(8),
      //     ),
      //     child: Container(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Container(
      //             height: 120,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.all(
      //                 Radius.circular(8),
      //               ),
      //               image: DecorationImage(
      //                 // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
      //                 image: NetworkImage(shopModel.image),
      //                 fit: BoxFit.cover,
      //               ),
      //             ),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: <Widget>[
      //                 Row(
      //                   children: <Widget>[
      //                     shopModel.status != null
      //                         ? Padding(
      //                             padding: EdgeInsets.all(5),
      //                             child: AppTag(
      //                               shopModel.status,
      //                               type: TagType.status,
      //                             ),
      //                           )
      //                         : Container()
      //                   ],
      //                 ),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.end,
      //                   children: <Widget>[
      //                     Padding(
      //                       padding: EdgeInsets.all(5),
      //                       child: Icon(
      //                         shopModel.favourite
      //                             ? Icons.favorite
      //                             : Icons.favorite_border,
      //                         color: Colors.white,
      //                       ),
      //                     )
      //                   ],
      //                 )
      //               ],
      //             ),
      //           ),
      //           Padding(padding: EdgeInsets.only(top: 3)),
      //           Text(
      //             shopModel.address,
      //             style: Theme.of(context)
      //                 .textTheme
      //                 .caption
      //                 .copyWith(fontWeight: FontWeight.w600),
      //           ),
      //           Padding(padding: EdgeInsets.only(top: 5)),
      //           Text(
      //             shopModel.title,
      //             maxLines: 1,
      //             style: Theme.of(context)
      //                 .textTheme
      //                 .subtitle2
      //                 .copyWith(fontWeight: FontWeight.w600),
      //           ),
      //           // Padding(padding: EdgeInsets.only(top: 10)),
      //           // Row(
      //           //   crossAxisAlignment: CrossAxisAlignment.center,
      //           //   children: <Widget>[
      //           //     AppTag(
      //           //       "${shopModel.rate}",
      //           //       type: TagType.rateSmall,
      //           //     ),
      //           //     Padding(padding: EdgeInsets.only(left: 5)),
      //           //     StarRating(
      //           //       rating: shopModel.rate,
      //           //       size: 14,
      //           //       color: AppTheme.yellowColor,
      //           //       borderColor: AppTheme.yellowColor,
      //           //     )
      //           //   ],
      //           // ),
      //           Padding(padding: EdgeInsets.only(top: 10)),
      //           Text(
      //             shopModel.address,
      //             maxLines: 1,
      //             style: Theme.of(context).textTheme.caption,
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
     case PopularViewType.gird:
        if (shopModel == null) {
          return Shimmer.fromColors(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Container(
                    height: 10,
                    width: 80,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Container(
                    height: 10,
                    width: 100,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    height: 20,
                    width: 100,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    height: 10,
                    width: 80,
                    color: Colors.white,
                  ),
                  
                ],
              ),
            ),
            
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
          );
        } 
//  print(item);
        return FlatButton(
         
          onPressed: () {
           onPressShops(shopModel);
            // onPressFeature(featureModel);
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    image: DecorationImage(
                      // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                      image: NetworkImage(shopModel.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          shopModel.status != null
                              ? Padding(
                                  padding: EdgeInsets.all(5),
                                  child: AppTag(
                                    shopModel.status,
                                    type: TagType.status,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              shopModel.favourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 3)),
                Text(
                  shopModel.title,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text(
                  shopModel.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                
                
                // Padding(padding: EdgeInsets.only(top: 10)),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: <Widget>[
                //     AppTag(
                //       "${item.rate}",
                //       type: TagType.rateSmall,
                //     ),
                //     Padding(padding: EdgeInsets.only(left: 5)),
                //     StarRating(
                //       rating: item.rate,
                //       size: 14,
                //       color: AppTheme.yellowColor,
                //       borderColor: AppTheme.yellowColor,
                //     )
                //   ],
                // ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  shopModel.address,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        );
    
      // // /Mode View List
      // case PopularViewType.list:
      //   if (nearbyModel == null) {
      //     return Shimmer.fromColors(
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Container(
      //             width: 120,
      //             height: 140,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(8),
      //                 bottomLeft: Radius.circular(8),
      //               ),
      //               color: Colors.white,
      //             ),
      //           ),
      //           Expanded(
      //             child: Padding(
      //               padding: EdgeInsets.only(
      //                 top: 5,
      //                 bottom: 5,
      //                 left: 10,
      //                 right: 10,
      //               ),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: <Widget>[
      //                   Container(
      //                     height: 10,
      //                     width: 80,
      //                     color: Colors.white,
      //                   ),
      //                   Padding(padding: EdgeInsets.only(top: 10)),
      //                   Container(
      //                     height: 10,
      //                     width: 100,
      //                     color: Colors.white,
      //                   ),
      //                   Padding(padding: EdgeInsets.only(top: 10)),
      //                   Container(
      //                     height: 20,
      //                     width: 80,
      //                     color: Colors.white,
      //                   ),
      //                   Padding(padding: EdgeInsets.only(top: 10)),
      //                   Container(
      //                     height: 10,
      //                     width: 100,
      //                     color: Colors.white,
      //                   ),
      //                   Padding(padding: EdgeInsets.only(top: 10)),
      //                   Container(
      //                     height: 10,
      //                     width: 80,
      //                     color: Colors.white,
      //                   ),
      //                   Padding(
      //                     padding: EdgeInsets.only(top: 10),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.end,
      //                       crossAxisAlignment: CrossAxisAlignment.end,
      //                       children: <Widget>[
      //                         Container(
      //                           width: 18,
      //                           height: 18,
      //                           color: Colors.white,
      //                         )
      //                       ],
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //       baseColor: Theme.of(context).hoverColor,
      //       highlightColor: Theme.of(context).highlightColor,
      //     );
      //   }

      //   return FlatButton(
      //     onPressed: () {
      //       // onPressed(item);
      //       // onPress(nearlyModel);
      //     },
      //     padding: EdgeInsets.all(0),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(8),
      //     ),
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      //         // Container(
      //         //   width: 120,
      //         //   height: 140,
      //         //   decoration: BoxDecoration(
      //         //     // image: DecorationImage(
      //         //     //   // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
      //         //     //   image: NetworkImage(nearlyModel.image),
      //         //     //   fit: BoxFit.cover,
      //         //     // ),
      //         //     borderRadius: BorderRadius.only(
      //         //       topLeft: Radius.circular(8),
      //         //       bottomLeft: Radius.circular(8),
      //         //     ),
      //         //   ),
      //         //   child: Column(
      //         //     crossAxisAlignment: CrossAxisAlignment.start,
      //         //     children: <Widget>[
      //         //     nearbyModel.status != null
      //         //           ? Padding(
      //         //               padding: EdgeInsets.all(5),
      //         //               child: AppTag(
      //         //                 nearbyModel.status,
      //         //                 type: TagType.status,
      //         //               ),
      //         //             )
      //         //           : Container()
      //         //     ],
      //         //   ),
      //         // ),
      //         Expanded(
      //           child: Padding(
      //             padding: EdgeInsets.only(
      //               top: 5,
      //               bottom: 5,
      //               left: 10,
      //               right: 10,
      //             ),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 Text(
      //                   nearbyModel.description,
      //                   style: Theme.of(context).textTheme.caption.copyWith(
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                 ),
      //                 Padding(padding: EdgeInsets.only(top: 5)),
      //                 Text(
      //                   nearbyModel.name,
      //                   maxLines: 1,
      //                   style: Theme.of(context)
      //                       .textTheme
      //                       .subtitle2
      //                       .copyWith(fontWeight: FontWeight.w600),
      //                 ),
      //                 Padding(padding: EdgeInsets.only(top: 5)),
      //                 // Row(
      //                 //   crossAxisAlignment: CrossAxisAlignment.center,
      //                 //   children: <Widget>[
      //                 //     AppTag(
      //                 //       "${nearbyModel.rate}",
      //                 //       type: TagType.rateSmall,
      //                 //     ),
      //                 //     Padding(padding: EdgeInsets.only(left: 5)),
      //                 //     StarRating(
      //                 //       rating: nearbyModel.rate,
      //                 //       size: 14,
      //                 //       color: AppTheme.yellowColor,
      //                 //       borderColor: AppTheme.yellowColor,
      //                 //     )
      //                 //   ],
      //                 // ),
      //                 Padding(padding: EdgeInsets.only(top: 5)),
      //                 Row(
      //                   children: <Widget>[
      //                     Icon(
      //                       Icons.location_on,
      //                       size: 12,
      //                       color: Theme.of(context).primaryColor,
      //                     ),
      //                     // Expanded(
      //                     //   child: Padding(
      //                     //     padding: EdgeInsets.only(left: 3, right: 3),
      //                     //     child: Text(nearlyModel.address,
      //                     //         maxLines: 1,
      //                     //         style: Theme.of(context).textTheme.caption),
      //                     //   ),
      //                     // )
      //                   ],
      //                 ),
      //                 Padding(padding: EdgeInsets.only(top: 5)),
      //                 // Row(
      //                 //   children: <Widget>[
      //                 //     Icon(
      //                 //       Icons.phone,
      //                 //       size: 12,
      //                 //       color: Theme.of(context).primaryColor,
      //                 //     ),
      //                 //     Expanded(
      //                 //       child: Padding(
      //                 //         padding: EdgeInsets.only(left: 3, right: 3),
      //                 //         child: Text(nearbyModel.phone,
      //                 //             maxLines: 1,
      //                 //             style: Theme.of(context).textTheme.caption),
      //                 //       ),
      //                 //     )
      //                 //   ],
      //                 // ),
      //                 // Row(
      //                 //   mainAxisAlignment: MainAxisAlignment.end,
      //                 //   children: <Widget>[
      //                 //     Icon(
      //                 //       nearlyModel.favorite
      //                 //           ? Icons.favorite
      //                 //           : Icons.favorite_border,
      //                 //       color: Theme.of(context).primaryColor,
      //                 //     )
      //                 //   ],
      //                 // )
      //               ],
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   );

      // // ///Mode View Block
      // case PopularViewType.block:
      //   if (nearbyModel == null) {
      //     return Shimmer.fromColors(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Container(
      //             height: 200,
      //             color: Colors.white,
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(
      //               left: 20,
      //               right: 20,
      //               top: 10,
      //             ),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 Container(
      //                   height: 10,
      //                   width: 150,
      //                   color: Colors.white,
      //                 ),
      //                 Padding(padding: EdgeInsets.only(top: 5)),
      //                 Container(
      //                   height: 10,
      //                   width: 200,
      //                   color: Colors.white,
      //                 ),
      //                 Padding(padding: EdgeInsets.only(top: 10)),
      //                 Container(
      //                   height: 10,
      //                   width: 150,
      //                   color: Colors.white,
      //                 ),
      //                 Padding(padding: EdgeInsets.only(top: 5)),
      //                 Container(
      //                   height: 10,
      //                   width: 150,
      //                   color: Colors.white,
      //                 ),
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //       baseColor: Theme.of(context).hoverColor,
      //       highlightColor: Theme.of(context).highlightColor,
      //     );
      //   }

      //   return FlatButton(
      //     onPressed: () {
      //       // onPress(nearlyModel);
      //     },
      //     padding: EdgeInsets.all(0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      //         Container(
      //           height: 200,
      //           decoration: BoxDecoration(
      //             // image: DecorationImage(
      //             //   // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
      //             //   image: NetworkImage(nearlyModel.image),
      //             //   fit: BoxFit.cover,
      //             // ),
      //           ),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: <Widget>[
      //               // Padding(
      //               //   padding: EdgeInsets.all(5),
      //               //   child: Row(
      //               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               //     children: <Widget>[
      //               //       nearbyModel.status != null
      //               //           ? AppTag(
      //               //               nearbyModel.status,
      //               //               type: TagType.status,
      //               //             )
      //               //           : Container(),
      //               //       // Icon(
      //               //       //   nearlyModel.favorite
      //               //       //       ? Icons.favorite
      //               //       //       : Icons.favorite_border,
      //               //       //   color: Colors.white,
      //               //       // )
      //               //     ],
      //               //   ),
      //               // ),
      //               Padding(
      //                 padding: EdgeInsets.all(5),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.end,
      //                   children: <Widget>[
      //                     Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: <Widget>[
      //                         // Row(
      //                         //   children: <Widget>[
      //                         //     AppTag(
      //                         //       "${nearbyModel.rate}",
      //                         //       type: TagType.rateSmall,
      //                         //     ),
      //                         //     Padding(
      //                         //       padding: EdgeInsets.only(left: 5),
      //                         //       child: Column(
      //                         //         crossAxisAlignment:
      //                         //             CrossAxisAlignment.start,
      //                         //         children: <Widget>[
      //                         //           Padding(
      //                         //             padding: EdgeInsets.only(left: 3),
      //                         //             child: Text(
      //                         //               nearbyModel.rateText,
      //                         //               style: Theme.of(context)
      //                         //                   .textTheme
      //                         //                   .caption
      //                         //                   .copyWith(
      //                         //                     color: Colors.white,
      //                         //                     fontWeight: FontWeight.w600,
      //                         //                   ),
      //                         //             ),
      //                         //           ),
      //                         //           StarRating(
      //                         //             rating: nearbyModel.rate,
      //                         //             size: 14,
      //                         //             color: AppTheme.yellowColor,
      //                         //             borderColor: AppTheme.yellowColor,
      //                         //           )
      //                         //         ],
      //                         //       ),
      //                         //     )
      //                         //   ],
      //                         // ),
      //                         // Padding(
      //                         //   padding: EdgeInsets.only(top: 3),
      //                         //   child: Text(
      //                         //     "${nearbyModel.numRate} reviews",
      //                         //     style: Theme.of(context)
      //                         //         .textTheme
      //                         //         .caption
      //                         //         .copyWith(
      //                         //           color: Colors.white,
      //                         //           fontWeight: FontWeight.w600,
      //                         //         ),
      //                         //   ),
      //                         // )
      //                       ],
      //                     )
      //                   ],
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //         Padding(
      //           padding: EdgeInsets.only(
      //             left: 20,
      //             right: 20,
      //             top: 10,
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               Text(
      //                 nearbyModel.description,
      //                 style: Theme.of(context)
      //                     .textTheme
      //                     .caption
      //                     .copyWith(fontWeight: FontWeight.w600),
      //               ),
      //               Padding(padding: EdgeInsets.only(top: 5)),
      //               Text(
      //                 nearbyModel.name,
      //                 maxLines: 1,
      //                 style: Theme.of(context)
      //                     .textTheme
      //                     .subtitle2
      //                     .copyWith(fontWeight: FontWeight.w600),
      //               ),
      //               Padding(padding: EdgeInsets.only(top: 10)),
      //               Row(
      //                 children: <Widget>[
      //                   Icon(
      //                     Icons.location_on,
      //                     size: 12,
      //                     color: Theme.of(context).primaryColor,
      //                   ),
      //                   // Expanded(
      //                   //   child: Padding(
      //                   //     padding: EdgeInsets.only(left: 3, right: 3),
      //                   //     child: Text(
      //                   //       nearlyModel.address,
      //                   //       maxLines: 1,
      //                   //       style: Theme.of(context).textTheme.caption,
      //                   //     ),
      //                   //   ),
      //                   // )
      //                 ],
      //               ),
      //               Padding(padding: EdgeInsets.only(top: 5)),
      //               Row(
      //                 children: <Widget>[
      //                   Icon(
      //                     Icons.phone,
      //                     size: 12,
      //                     color: Theme.of(context).primaryColor,
      //                   ),
      //                   // Expanded(
      //                   //   child: Padding(
      //                   //     padding: EdgeInsets.only(left: 3, right: 3),
      //                   //     child: Text(
      //                   //       nearbyModel.phone,
      //                   //       maxLines: 1,
      //                   //       style: Theme.of(context).textTheme.caption,
      //                   //     ),
      //                   //   ),
      //                   // )
      //                 ],
      //               ),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   );
    
      // ///Case View Card large
      // case PopularViewType.cardLarge:
      //   if (nearbyModel == null) {
      //     return SizedBox(
      //       width: 135,
      //       height: 160,
      //       child: Shimmer.fromColors(
      //         baseColor: Theme.of(context).hoverColor,
      //         highlightColor: Theme.of(context).highlightColor,
      //         enabled: true,
      //         child: Container(
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //         ),
      //       ),
      //     );
      //   }

      //   return SizedBox(
      //     width: 135,
      //     height: 160,
      //     child: GestureDetector(
      //       onTap: () {
      //         // **************************
      //         // onPressLocation(mylocation);//from here go to home.dart
      //         // *************************
      //       },
      //       child: Card(
      //         elevation: 2,
      //         margin: EdgeInsets.all(0),
      //         clipBehavior: Clip.antiAliasWithSaveLayer,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(8),
      //         ),
      //         child: Container(
      //           decoration: BoxDecoration(
      //             image: DecorationImage(
      //               colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.darken),
      //               image: NetworkImage(nearbyModel.picture),
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               Padding(
      //                 padding: EdgeInsets.all(10),
      //                 child: Text(
      //                   nearbyModel.name,
      //                   style: Theme.of(context).textTheme.subtitle2.copyWith(
      //                         color: Colors.white,
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   );

      // ///Case View Card small
      // case PopularViewType.cardSmall:
      // if (nearbyModel == null) {
      //     return Shimmer.fromColors(
      //       child: Row(
      //         children: <Widget>[
      //           ClipRRect(
      //             borderRadius: BorderRadius.circular(8),
      //             child: Container(
      //               width: 80,
      //               height: 80,
      //               color: Colors.white,
      //             ),
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(
      //               left: 10,
      //               right: 10,
      //               top: 5,
      //               bottom: 5,
      //             ),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 Container(
      //                   height: 10,
      //                   width: 180,
      //                   color: Colors.white,
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.only(top: 5),
      //                 ),
      //                 Container(
      //                   height: 10,
      //                   width: 150,
      //                   color: Colors.white,
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.only(top: 10),
      //                 ),
      //                 Container(
      //                   height: 10,
      //                   width: 100,
      //                   color: Colors.white,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //       baseColor: Theme.of(context).hoverColor,
      //       highlightColor: Theme.of(context).highlightColor,
      //     );
      //   }

      //   return FlatButton(
      //     onPressed: () {
      //       // onPressshop(shopModel);
      //     },
      //     padding: EdgeInsets.all(0),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(8),
      //     ),
      //     child: Row(
      //       children: <Widget>[
      //         ClipRRect(
      //           borderRadius: BorderRadius.circular(8),
      //           child: Image.network(
      //             nearbyModel.picture,
      //             width: 80,
      //             height: 80,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //         Padding(
      //           padding: EdgeInsets.only(
      //             left: 10,
      //             right: 10,
      //             top: 5,
      //             bottom: 5, 
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: <Widget>[
      //               Text(
      //                 nearbyModel.name,
      //                 maxLines: 1,
      //                 style: Theme.of(context)
      //                     .textTheme
      //                     .subtitle2
      //                     .copyWith(fontWeight: FontWeight.w600),
      //               ),
      //               Padding(padding: EdgeInsets.only(top: 5)),
      //               Text(
      //                 nearbyModel.description,
      //                 style: Theme.of(context)
      //                     .textTheme
      //                     .caption
      //                     .copyWith(fontWeight: FontWeight.w600),
      //               ),
      //               Padding(padding: EdgeInsets.only(top: 10)),
      //               // Row(
      //               //   crossAxisAlignment: CrossAxisAlignment.center,
      //               //   children: <Widget>[
      //               //     AppTag(
      //               //       "${nearbyModel.id}",
      //               //       type: TagType.rateSmall,
      //               //     ),
      //               //     Padding(padding: EdgeInsets.only(left: 5)),
      //               //     StarRating(
      //               //       rating: nearbyModel.rate,
      //               //       size: 14,
      //               //       color: AppTheme.yellowColor,
      //               //       borderColor: AppTheme.yellowColor,
      //               //     )
      //               //   ],
      //               // )
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   );
      //   // if (shopModel == null) {
      //   //   return SizedBox(
      //   //     width: 100,
      //   //     height: 100,
      //   //     child: Shimmer.fromColors(
      //   //       baseColor: Theme.of(context).hoverColor,
      //   //       highlightColor: Theme.of(context).highlightColor,
      //   //       enabled: true,
      //   //       child: Container(
      //   //         decoration: BoxDecoration(
      //   //           color: Colors.white,
      //   //           borderRadius: BorderRadius.circular(8),
      //   //         ),
      //   //       ),
      //   //     ),
      //   //   );
      //   // }

      //   // return SizedBox(
      //   //   width: 100,
      //   //   height: 100,
      //   //   child: GestureDetector(
      //   //     onTap: () {
      //   //       onPressshop(shopModel);
      //   //     },
      //   //     child: Card(
      //   //       elevation: 2,
      //   //       margin: EdgeInsets.all(0),
      //   //       clipBehavior: Clip.antiAliasWithSaveLayer,
      //   //       shape: RoundedRectangleBorder(
      //   //         borderRadius: BorderRadius.circular(8),
      //   //       ),
      //   //       child: Container(
      //   //           decoration: BoxDecoration(
      //   //             image: DecorationImage(
      //   //               colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.darken),
      //   //               image: AssetImage(shopModel.image),
      //   //               fit: BoxFit.cover,
      //   //             ),
      //   //           ),
      //   //           child: Column(
      //   //             mainAxisAlignment: MainAxisAlignment.end,
      //   //             crossAxisAlignment: CrossAxisAlignment.start,
      //   //             children: <Widget>[
      //   //               Padding(
      //   //                 padding: EdgeInsets.all(10),
      //   //                 child: Text(
      //   //                   shopModel.title,
      //   //                   style: Theme.of(context).textTheme.subtitle2.copyWith(
      //   //         color: Colors.white,
      //   //         fontWeight: FontWeight.w600,
      //   //       ),
      //   //                 ),
      //   //               )
      //   //             ],
      //   //           ),
      //   //         ),
      //   //     ),
      //   //   ),
      //   // );

      default:
        return Container(width: 160.0);
    
  }
}
}