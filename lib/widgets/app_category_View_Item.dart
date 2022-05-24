import 'package:flutter/material.dart';
import 'package:shoplocalto/configs/theme.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';


enum CategoryViewType {  gird, list, block, gridpopular }

class AppCategoryViewItem extends StatelessWidget {

  final ListModel item;
  final ShopModel shopModel;//ProductViewType.cardSmall
  final MyLocation mylocation;//productViewType:cardLarge
  final NearlyModel nearlyModel;//productViewType:list
  final FeatureModel featureModel;//productViewType:grid
  final RelatedModel relatedModel;//productViewType:small
  final CategoryViewType type;
  final LocationViewType locationtype;
  final Function(NearlyModel) onPress;
  final Function(ListModel) onPressed;
  final Function(FeatureModel) onPressFeature;
  final Function(RelatedModel) onPressRelated;
  final Function(MyLocation) onPressLocation;
final Function(ShopModel) onPressshop;
  const AppCategoryViewItem({Key key, this.item, this.type, this.onPressed, this.nearlyModel, this.onPress, this.featureModel, this.relatedModel, this.onPressFeature, this.onPressRelated, this.mylocation, this.locationtype, this.onPressLocation, this.onPressshop, this.shopModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {

      // ///Mode View Small
    
    
      // /Mode View Gird
      case CategoryViewType.gird:
        if (item == null) {
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
            onPressed(item);
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
                      image: NetworkImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          item.status != null
                              ? Padding(
                                  padding: EdgeInsets.all(5),
                                  child: AppTag(
                                    item.status,
                                    type: TagType.status,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          // Padding(
                          //   padding: EdgeInsets.all(5),
                          //   child: IconButton(
                          //                                 icon: Icon(
                          //       item.favourite
                          //           ? Icons.favorite
                          //           : Icons.favorite_border,
                          //       color: Colors.white,
                          //     ),
                          //     onPressed: (){
                          //       item.favourite = true;
                          //     },
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 3)),
                Text(
                  item.title,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                
                Text(
                  item.subtitle,
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
                  item.address,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        );

          case CategoryViewType.gridpopular:
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
            onPressshop(shopModel);
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
                        ],
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 3)),
                Text(
                  shopModel.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
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
    
      // /Mode View List
      case CategoryViewType.list:
        if (item == null) {
          return Shimmer.fromColors(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 120,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 80,
                          color: Colors.white,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          height: 20,
                          width: 80,
                          color: Colors.white,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          height: 10,
                          width: 80,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                width: 18,
                                height: 18,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
            
          );
        }

        return FlatButton(
          onPressed: () {
            onPressed(item);
            // onPress(nearlyModel);
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 120,
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                    image: NetworkImage(item.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  item.status != null
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: AppTag(
                              item.status,
                              type: TagType.status,
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.subtitle,
                        maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Text(
                        item.title,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      // Padding(padding: EdgeInsets.only(top: 5)),
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
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 12,
                            color: Theme.of(context).primaryColor,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 3, right: 3),
                              child: Text(item.address,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.caption),
                            ),
                          )
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            size: 12,
                            color: Theme.of(context).primaryColor,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 3, right: 3),
                              child: Text(item.phone,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.caption),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            item.favourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );

      // ///Mode View Block
      case CategoryViewType.block:
        if (item == null) {
          return Shimmer.fromColors(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.white,
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Container(
                        height: 10,
                        width: 200,
                        color: Colors.white,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.white,
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
          );
        }

        return FlatButton(
          onPressed: () {
            onPressed(item);
            // onPress(nearlyModel);
          },
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                    image: NetworkImage(item.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          item.status != null
                              ? AppTag(
                                  item.status,
                                  type: TagType.status,
                                )
                              : Container(),
                          Icon(
                            item.favourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: <Widget>[
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: <Widget>[
                    //           Row(
                    //             children: <Widget>[
                    //               AppTag(
                    //                 "${item.rate}",
                    //                 type: TagType.rateSmall,
                    //               ),
                    //               Padding(
                    //                 padding: EdgeInsets.only(left: 5),
                    //                 child: Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: <Widget>[
                    //                     // Padding(
                    //                     //   padding: EdgeInsets.only(left: 3),
                    //                     //   child: Text(
                    //                     //     item.rate,
                    //                     //     style: Theme.of(context)
                    //                     //         .textTheme
                    //                     //         .caption
                    //                     //         .copyWith(
                    //                     //           color: Colors.white,
                    //                     //           fontWeight: FontWeight.w600,
                    //                     //         ),
                    //                     //   ),
                    //                     // ),
                    //                     StarRating(
                    //                       rating: item.rate,
                    //                       size: 14,
                    //                       color: AppTheme.yellowColor,
                    //                       borderColor: AppTheme.yellowColor,
                    //                     )
                    //                   ],
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.only(top: 3),
                    //             child: Text(
                    //               "${item.rate} reviews",
                    //               style: Theme.of(context)
                    //                   .textTheme
                    //                   .caption
                    //                   .copyWith(
                    //                     color: Colors.white,
                    //                     fontWeight: FontWeight.w600,
                    //                   ),
                    //             ),
                    //           )
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.subtitle,
                          maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      item.title,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: Theme.of(context).primaryColor,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 3, right: 3),
                            child: Text(
                              item.address,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          size: 12,
                          color: Theme.of(context).primaryColor,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 3, right: 3),
                            child: Text(
                              item.phone,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
    
      ///Case View Card large

      default:
        return Container(width: 160.0);
    
  }
}
}