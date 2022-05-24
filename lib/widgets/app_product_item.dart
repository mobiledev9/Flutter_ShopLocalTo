import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:readmore/readmore.dart';
import 'package:shoplocalto/configs/theme.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/screens/product_detail_tab/product_tab_controller.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';

import '../models/model_marketplace.dart';

enum ProductViewType {
  small,
  gird,
  list,
  block,
  cardLarge,
  cardSmall,
  listSmall,
  blocksmall,
  imagelist,
  test
}

class AppProductItem extends StatefulWidget {
  final TabModel item1;
  final ProductModel item;
  final ListModel wishListitem;
  final ShopModel shopModel; //ProductViewType.cardSmall
  final MyLocation mylocation; //productViewType:cardLarge
  final NearlyModel nearlyModel; //productViewType:list
  final Marketplace marketplacemodel; //productViewType:test
  final FeatureModel featureModel; //productViewType:grid
  final RelatedModel relatedModel; //productViewType:small
  final ShopModel wishlistModel; //productViewType:block
  final ProductViewType type;
  final ImageModel photomodel;
  final LocationViewType locationtype;
  final Function(NearlyModel) onPress;
  final Function(Marketplace) onPressmarketplace;
  final Function(ProductModel) onPressed;
  final Function(FeatureModel) onPressFeature;
  final Function(RelatedModel) onPressRelated;
  final Function(MyLocation) onPressLocation;
  final Function(ShopModel) onPressshop;
  const AppProductItem({
    Key key,
    this.item,
    this.item1,
    this.type,
    this.onPressed,
    this.nearlyModel,
    this.marketplacemodel,
    this.onPress,
    this.featureModel,
    this.relatedModel,
    this.onPressFeature,
    this.onPressRelated,
    this.mylocation,
    this.locationtype,
    this.onPressLocation,
    this.onPressshop,
    this.shopModel,
    this.wishlistModel,
    this.wishListitem,
    this.photomodel,
    this.onPressmarketplace,
  }) : super(key: key);

  @override
  State<AppProductItem> createState() => _AppProductItemState();
}

class _AppProductItemState extends State<AppProductItem> {
  final ProducttabController _producttabController =
      Get.put(ProducttabController());
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('++++++Appproductmodel+++++++++++++++${item.address}+++++++++++');
    // print('++++++Appfeature+++++++++++++++${item.feature.length}+++++++++++');
    // print('++++Apprelated+++++++++++++++++${nearlyModel.address}+++++++++++');
    switch (widget.type) {

      // Mode Market Place

      case ProductViewType.test:
        if (widget.marketplacemodel == null) {
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
            // onPressed(item);
            // onPress(marketplacemodel);
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                    image: NetworkImage(widget.marketplacemodel.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.marketplacemodel.name,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      ReadMoreText(
                        widget.marketplacemodel.description,
                        trimLines: 2,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        colorClickableText: Theme.of(context).accentColor,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      // Text(
                      //
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 3,
                      //   style: Theme.of(context).textTheme.caption.copyWith(
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),

                      // Padding(padding: EdgeInsets.only(top: 5)),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: <Widget>[
                      //     AppTag(
                      //       "${nearlyModel.rate}",
                      //       type: TagType.rateSmall,
                      //     ),
                      //     Padding(padding: EdgeInsets.only(left: 5)),
                      //     StarRating(
                      //       rating: nearlyModel.rate,
                      //       size: 14,
                      //       color: AppTheme.yellowColor,
                      //       borderColor: AppTheme.yellowColor,
                      //     )
                      //   ],
                      // ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        children: <Widget>[
                          Text("Price:",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontWeight: FontWeight.w600,
                                      )),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 3, right: 3),
                              child: Text(
                                  widget.marketplacemodel.price.toString(),
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.caption),
                            ),
                          )
                        ],
                      ),
                      // Padding(padding: EdgeInsets.only(top: 5)),
                      // Row(
                      //   children: <Widget>[
                      //     Text("link:",
                      //         maxLines: 1,
                      //         style: Theme.of(context).textTheme.caption.copyWith(
                      //           fontWeight: FontWeight.w600,)),
                      //     Padding(
                      //       padding: EdgeInsets.only(left: 3, right: 3),
                      //       child: Text(marketplacemodel.link,
                      //           maxLines: 1,
                      //           style: Theme.of(context).textTheme.caption),
                      //     )
                      //   ],
                      // ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        children: <Widget>[
                          Text("Type:",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontWeight: FontWeight.w600,
                                      )),
                          Padding(
                            padding: EdgeInsets.only(left: 3, right: 3),
                            child: Text(widget.marketplacemodel.type,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.caption),
                          )
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        children: <Widget>[
                          Text("Category:",
                              maxLines: 1,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontWeight: FontWeight.w600,
                                      )),
                          Padding(
                            padding: EdgeInsets.only(left: 3, right: 3),
                            child: Text(widget.marketplacemodel.category,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.caption),
                          )
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: <Widget>[
                      //     Icon(
                      //       nearlyModel.favorite
                      //           ? Icons.favorite
                      //           : Icons.favorite_border,
                      //       color: Theme.of(context).primaryColor,
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
//Mode Photo

      case ProductViewType.imagelist:
        if (widget.photomodel == null) {
          return Shimmer.fromColors(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
          );
        }

        return Container(
          width: 70,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
              image: NetworkImage(widget.photomodel.image),
              fit: BoxFit.cover,
            ),
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(8),
            //   bottomLeft: Radius.circular(8),
            //   topRight: Radius.circular(8),
            //   bottomRight: Radius.circular(8),
            // ),
          ),
        );

// /Mode View List Nearby
      case ProductViewType.list:
        if (widget.nearlyModel == null) {
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
            // onPressed(item);
            widget.onPress(widget.nearlyModel);
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
                    image: NetworkImage(widget.nearlyModel.image),
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
                    widget.nearlyModel.status != null
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: AppTag(
                              widget.nearlyModel.status,
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
                        widget.nearlyModel.title,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Text(
                        widget.nearlyModel.subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),

                      // Padding(padding: EdgeInsets.only(top: 5)),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: <Widget>[
                      //     AppTag(
                      //       "${nearlyModel.rate}",
                      //       type: TagType.rateSmall,
                      //     ),
                      //     Padding(padding: EdgeInsets.only(left: 5)),
                      //     StarRating(
                      //       rating: nearlyModel.rate,
                      //       size: 14,
                      //       color: AppTheme.yellowColor,
                      //       borderColor: AppTheme.yellowColor,
                      //     )
                      //   ],
                      // ),
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
                              child: Text(widget.nearlyModel.address,
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
                              child: Text(widget.nearlyModel.phone,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.caption),
                            ),
                          )
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: <Widget>[
                      //     Icon(
                      //       nearlyModel.favorite
                      //           ? Icons.favorite
                      //           : Icons.favorite_border,
                      //       color: Theme.of(context).primaryColor,
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        );

      // ///Mode View Small
      case ProductViewType.small:
        if (widget.relatedModel == null) {
          return Shimmer.fromColors(
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 10,
                        width: 180,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
          );
        }

        return FlatButton(
          onPressed: () {
            widget.onPressRelated(widget.relatedModel);
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.relatedModel.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                  bottom: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.relatedModel.title,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      widget.relatedModel.subtitle,
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
                    //       "${relatedModel.rate}",
                    //       type: TagType.rateSmall,
                    //     ),
                    //     Padding(padding: EdgeInsets.only(left: 5)),
                    //     StarRating(
                    //       rating: relatedModel.rate,
                    //       size: 14,
                    //       color: AppTheme.yellowColor,
                    //       borderColor: AppTheme.yellowColor,
                    //     )
                    //   ],
                    // )
                  ],
                ),
              )
            ],
          ),
        );

      // /Mode View Gird
      case ProductViewType.gird:
        if (widget.featureModel == null) {
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
        print(widget.featureModel);
        return FlatButton(
          onPressed: () {
            widget.onPressFeature(widget.featureModel);
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
                      image: NetworkImage(widget.featureModel.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          widget.featureModel.status != null
                              ? Padding(
                                  padding: EdgeInsets.all(5),
                                  child: AppTag(
                                    widget.featureModel.status,
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
                          //   child: Icon(
                          //     nearlyModel.favorite
                          //         ? Icons.favorite
                          //         : Icons.favorite_border,
                          //     color: Colors.white,
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 3)),
                Text(
                  widget.featureModel.subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text(
                  widget.featureModel.title,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                // Padding(padding: EdgeInsets.only(top: 10)),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: <Widget>[
                //     AppTag(
                //       "${featureModel.rate}",
                //       type: TagType.rateSmall,
                //     ),
                //     Padding(padding: EdgeInsets.only(left: 5)),
                //     StarRating(
                //       rating: featureModel.rate,
                //       size: 14,
                //       color: AppTheme.yellowColor,
                //       borderColor: AppTheme.yellowColor,
                //     )
                //   ],
                // ),
                // Padding(padding: EdgeInsets.only(top: 10)),
                // Text(
                //   featureModel.address,
                //   maxLines: 1,
                //   style: Theme.of(context).textTheme.caption,
                // ),
              ],
            ),
          ),
        );

// 888888888****************************Wishliststart***************************************
      // ///Mode View Block
      case ProductViewType.block:
        if (widget.item == null) {
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
            widget.onPressed(widget.item);
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
                    image: NetworkImage(widget.item.image),
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
                          widget.item.status != null
                              ? AppTag(
                                  widget.item.status,
                                  type: TagType.status,
                                )
                              : Container(),
                          // Icon(
                          //   nearlyModel.favorite
                          //       ? Icons.favorite
                          //       : Icons.favorite_border,
                          //   color: Colors.white,
                          // )
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
                    //                     //     wishlistModel.rateText,
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
                    //           // Padding(
                    //           //   padding: EdgeInsets.only(top: 3),
                    //           //   child: Text(
                    //           //     "${wishlistModel.numRate} reviews",
                    //           //     style: Theme.of(context)
                    //           //         .textTheme
                    //           //         .caption
                    //           //         .copyWith(
                    //           //           color: Colors.white,
                    //           //           fontWeight: FontWeight.w600,
                    //           //         ),
                    //           //   ),
                    //           // )
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
                      widget.item.subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      widget.item.title,
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
                        // Expanded(
                        //   child: Padding(
                        //     padding: EdgeInsets.only(left: 3, right: 3),
                        //     child: Text(
                        //       nearlyModel.address,
                        //       maxLines: 1,
                        //       style: Theme.of(context).textTheme.caption,
                        //     ),
                        //   ),
                        // )
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
                              widget.item.phone,
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
      // ***************************************WishListEnd*********************************************
      ///Case View Card large
      case ProductViewType.cardLarge:
        if (widget.mylocation == null) {
          return SizedBox(
            width: 135,
            height: 160,
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).hoverColor,
              highlightColor: Theme.of(context).highlightColor,
              enabled: true,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        }

        return SizedBox(
          width: 135,
          height: 160,
          child: GestureDetector(
            onTap: () {
              // **************************
              widget.onPressLocation(
                  widget.mylocation); //from here go to home.dart
              // *************************
            },
            child: Card(
              elevation: 2,
              margin: EdgeInsets.all(0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.35), BlendMode.darken),
                    image: NetworkImage(widget.mylocation.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        widget.mylocation.title,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );

      ///Case View Card small
      case ProductViewType.cardSmall:
        if (widget.shopModel == null) {
          return Shimmer.fromColors(
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 10,
                        width: 180,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            baseColor: Theme.of(context).hoverColor,
            highlightColor: Theme.of(context).highlightColor,
          );
        }

        return FlatButton(
          onPressed: () {
            widget.onPressshop(widget.shopModel);
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.shopModel.image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                  bottom: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.shopModel.title,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        widget.shopModel.subtitle,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontWeight: FontWeight.w600),
                        maxLines: 2,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      widget.shopModel.type,
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
                    //       "${shopModel.id}",
                    //       type: TagType.rateSmall,
                    //     ),
                    //     Padding(padding: EdgeInsets.only(left: 5)),
                    //     StarRating(
                    //       rating: shopModel.rate,
                    //       size: 14,
                    //       color: AppTheme.yellowColor,
                    //       borderColor: AppTheme.yellowColor,
                    //     )
                    //   ],
                    // )
                  ],
                ),
              )
            ],
          ),
        );
      // if (shopModel == null) {
      //   return SizedBox(
      //     width: 100,
      //     height: 100,
      //     child: Shimmer.fromColors(
      //       baseColor: Theme.of(context).hoverColor,
      //       highlightColor: Theme.of(context).highlightColor,
      //       enabled: true,
      //       child: Container(
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(8),
      //         ),
      //       ),
      //     ),
      //   );
      // }

      // return SizedBox(
      //   width: 100,
      //   height: 100,
      //   child: GestureDetector(
      //     onTap: () {
      //       onPressshop(shopModel);
      //     },
      //     child: Card(
      //       elevation: 2,
      //       margin: EdgeInsets.all(0),
      //       clipBehavior: Clip.antiAliasWithSaveLayer,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(8),
      //       ),
      //       child: Container(
      //           decoration: BoxDecoration(
      //             image: DecorationImage(
      //               colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.darken),
      //               image: AssetImage(shopModel.image),
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
      //                   shopModel.title,
      //                   style: Theme.of(context).textTheme.subtitle2.copyWith(
      //         color: Colors.white,
      //         fontWeight: FontWeight.w600,
      //       ),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //     ),
      //   ),
      // );
      case ProductViewType.blocksmall:
        if (widget.item == null) {
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
            widget.onPressed(widget.item);
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
                      image: NetworkImage(widget.item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          widget.item.status != null
                              ? Padding(
                                  padding: EdgeInsets.all(5),
                                  child: AppTag(
                                    widget.item.status,
                                    type: TagType.status,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: <Widget>[
                      //     Padding(
                      //       padding: EdgeInsets.all(5),
                      //       child: Icon(
                      //         item.favourite
                      //             ? Icons.favorite
                      //             : Icons.favorite_border,
                      //         color: Colors.white,
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 3)),
                Text(
                  widget.item.subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text(
                  widget.item.title,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
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
                  widget.item.address,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        );
      case ProductViewType.test:
        if (widget.item == null) {
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
            // onPressed(item);
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
                      image: AssetImage("assets/images/ae.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          'cdjc bjd' != null
                              ? Padding(
                                  padding: EdgeInsets.all(5),
                                  child: AppTag(
                                    'jdcndn',
                                    type: TagType.status,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: <Widget>[
                      //     Padding(
                      //       padding: EdgeInsets.all(5),
                      //       child: Icon(
                      //         item.favourite
                      //             ? Icons.favorite
                      //             : Icons.favorite_border,
                      //         color: Colors.white,
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 3)),
                Text(
                  ' item.subtitle,',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text(
                  'item.title',
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
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
                  ' item.address',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        );

      default:
        return Container(width: 160.0);
    }
  }
}
