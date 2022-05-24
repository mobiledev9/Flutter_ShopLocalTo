import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:readmore/readmore.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/screens/chat/chat.dart';
import 'package:shoplocalto/screens/product_detail_tab/product_tab_controller.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/model_marketplace.dart';

class TabContent extends StatefulWidget {
  final TabModel item;
  final ProductDetailTabPageModel page;
  final Function(ProductModel) onProductDetail;
  final Function(NearlyModel) onNearlyModelDetail;
  final Function(Marketplace) onMarketplace;
  TabContent({
    Key key,
    this.item,
    this.page,
    this.onProductDetail,
    this.onNearlyModelDetail,
    this.onMarketplace
  }) : super(key: key);

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  final ProducttabController _producttabController = Get.put(ProducttabController());

  Widget _buildSocial(BuildContext context) {
    List<SocialIcon> social = widget.page.product == null ? [] : widget.page?.product?.social;
    if (social == null) {
      return Container(
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('not available'),
          ],
        ),
      );
    }
    if (social.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: social.map((item) {
            return IntrinsicWidth(
                child: SizedBox(
              height: 35,
              width: 35,
              child: Material(
                  type: MaterialType.transparency,
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).buttonColor,
                    ),
                    child: InkWell(
                        onTap: () {
                          launch('${item.link}');
                        },
                        child: Icon(
                          iconMapping[item.icon],
                          color: Colors.white,
                        )),
                  )),
            ));
          }).toList(),
        ),
      );
    }
    return Container();
  }

  Map<String, IconData> iconMapping = {
    'facebook': FontAwesomeIcons.facebookF,
    'twitter': FontAwesomeIcons.twitter,
    'instagram': FontAwesomeIcons.instagram,
    'linkedin-in': FontAwesomeIcons.linkedin,
    'youtube': FontAwesomeIcons.youtube,
  };

  Widget _buildFacility(BuildContext context) {
    List<IconModel> facility =
        widget.page.product == null ? [] : widget.page?.product?.service;
    if (facility == null) {
      return Text('not available');
    }
    if (facility.isEmpty) {
      return Text('not available');
    }
    if (facility.isNotEmpty) {
      print(facility.length);
      log(facility.length.toString());
      return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: facility.map((item) {
            log(item.title);
            return IntrinsicWidth(
              child: AppTag(
                item.title,
                type: TagType.chip,
                icon: Icon(
                  UtilIcon.getIconData(item.icon),
                  size: 12,
                  color: Theme.of(context).selectedRowColor,
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
    return Container();
  }

  Widget _buildPhotos(BuildContext context) {
    if (widget.page.product.photo.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text('not available'),
      );
    }
    if (widget.page.product.photo.isNotEmpty) {
      return Container(
        height: 400,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(0),
          itemBuilder: (context, index) {
            final item = widget.page.product.photo[index];
            return Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: EdgeInsets.only(bottom: 15),
              child: AppProductItem(
                item1: widget.item,
                photomodel: item,
                type: ProductViewType.imagelist,
              ),
            );
          },
          semanticChildCount: 2,
          itemCount: widget.page.product.photo.length,
        ),
      );
    }
    return Container();
  }

  Widget _buildMarketplace(BuildContext context) {
    if (widget.page.product.marketplace.isEmpty) {
      return Container(
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('not available'),
          ],
        ),
      );
    }
    if (widget.page.product.marketplace.isNotEmpty) {
      return Container(
        height: 570,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(left: 20),
          itemBuilder: (context, index) {
            final item = widget.page.product.marketplace[index];
            return Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.only(right: 15, bottom: 10),
              child: AppProductItem( item1: widget.item,
                marketplacemodel: item,
                type: ProductViewType.test,
              ),
            );
          },
          itemCount: widget.page.product.marketplace.length,
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    print('today ${now.weekday}');

    switch (widget.item.key) {

      case 'marketplace':
        return  _producttabController.producttab.value == 0 ? Container(
          key: widget.item.keyContentItem,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 5),
                child: Text(
                  Translate.of(context).translate('Marketplace'),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 10,
                margin: EdgeInsets.only( bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
              ),
              _buildMarketplace(context),
              // Container(
              //   height: 15,
              //   margin: EdgeInsets.only(left: 20, right: 20),
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Theme.of(context).dividerColor,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ) : Container();
      case 'information':
        return _producttabController.producttab.value == 1 ?  Container(
          key: widget.item.keyContentItem,
          padding: EdgeInsets.only(left: 20, right: 20),
          // child: Container(
          //   decoration: BoxDecoration(
          //     border: Border(
          //       bottom: BorderSide(
          //         color: Theme.of(context).dividerColor,
          //       ),
          //     ),
          //   ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 5),
                  child: Text(
                    Translate.of(context).translate(widget.item.title),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  height: 10,
                  margin: EdgeInsets.only( bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).buttonColor,
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Translate.of(context).translate('address'),
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.page?.product?.address,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                InkWell(
                  onTap: () {
                    launch("tel:${widget.page.product.phone}");
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).buttonColor),
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Translate.of(context).translate('phone'),
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(
                              widget.page?.product?.phone,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                InkWell(
                  onTap: () {
                    launch("mailto:${widget.page.product.email}");
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).buttonColor),
                        child: Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Translate.of(context).translate('email'),
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(
                              widget.page?.product?.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                InkWell(
                  onTap: () {
                    launch('${widget.page.product.website}');
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).buttonColor),
                        child: Icon(
                          Icons.language,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Translate.of(context).translate('website'),
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(
                              widget.page?.product?.website,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).buttonColor,
                            ),
                            child: Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  Translate.of(context).translate('open_time'),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Text(
                                  widget.page?.product?.hour,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Chat(id: widget.page.product.id, product: widget.page.product)),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).buttonColor),
                        child: Icon(
                          Icons.message,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Translate.of(context).translate('message'),
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(
                              widget.page.product.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).dividerColor,
                          width: 1,
                        ),
                      ),
                    ),
                    margin: EdgeInsets.only(
                      top: 8,
                    ),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          Translate.of(context).translate(widget.page.product.hourDetail.elementAt(now.weekday - 1).title),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          widget.page.product.hourDetail.elementAt(now.weekday - 1).time == 'day_off'
                              ? Translate.of(context).translate('day_off')
                              : widget.page.product.hourDetail.elementAt(now.weekday - 1).time,
                          style: Theme.of(context).textTheme.caption.copyWith(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ]),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Text(
                  Translate.of(context).translate("description"),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
          ReadMoreText(
            widget.page?.product?.description,
            trimLines: 4,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(height: 1.3),
            colorClickableText: Theme.of(context).accentColor,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            moreStyle: TextStyle(fontSize: 14, color: Theme.of(context).accentColor,),
          ),
                // Text(
                //   page?.product?.description,
                //   style: Theme.of(context)
                //       .textTheme
                //       .bodyText1
                //       .copyWith(height: 1.3),
                // ),
                Container(
                  height: 15,
                  // margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Translate.of(context).translate('date_established'),
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              widget.page?.product?.date,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            Translate.of(context).translate('price_range'),
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              widget.page?.product?.priceRange,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          // ),
        ) : Container();
      case 'socialmedia':
        return _producttabController.producttab.value == 2 ?Container(
          key: widget.item.keyContentItem,
          padding: EdgeInsets.only(left: 20, right: 20),
          // child: Container(
          //   decoration: BoxDecoration(
          //     border: Border(
          //       bottom: BorderSide(
          //         color: Theme.of(context).dividerColor,
          //       ),
          //     ),
          //   ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 5),
                  child: Text(
                    Translate.of(context).translate('Social Media'),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),  Container(
                  height: 10,
                  margin: EdgeInsets.only( bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                ),
                _buildSocial(context),
              ],
            ),
          // ),
        ): Container();
      case 'facilities':
        return _producttabController.producttab.value == 3 ?Container(
          key: widget.item.keyContentItem,
          padding: EdgeInsets.only(left: 20, right: 20),
          // child:
          // Container(
          //   decoration: BoxDecoration(
          //     border: Border(
          //       bottom: BorderSide(
          //         color: Theme.of(context).dividerColor,
          //       ),
          //     ),
          //   ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 5),
                  child: Text(
                    Translate.of(context).translate('facilities'),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  height: 10,
                  margin: EdgeInsets.only( bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                ),
                _buildFacility(context),
              ],
            ),
          // ),
        ): Container();
      case 'nearby':
        return _producttabController.producttab.value == 4  ?Container(

          key: widget.item.keyContentItem,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 5),
                child: Text(
                  Translate.of(context).translate('nearly'),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 10,
                margin: EdgeInsets.only( bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
              ),
              Container(
                height: 570,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    final item = widget.page.product.nearly[index];
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.only(right: 15, bottom: 10),
                      child: AppProductItem(
                        item1: widget.item,
                        onPress: widget.onNearlyModelDetail,
                        nearlyModel: item,
                        type: ProductViewType.list,
                      ),
                    );
                  },
                  itemCount: widget.page.product.nearly.length,
                ),
              ),
              // Container(
              //   height: 15,
              //   margin: EdgeInsets.only(left: 20, right: 20),
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Theme.of(context).dividerColor,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ): Container();

      case 'photos':
        return _producttabController.producttab.value == 5  ?Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          key: widget.item.keyContentItem,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 5),
                child: Text(
                  Translate.of(context).translate('photos'),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 10,
                margin: EdgeInsets.only( bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
              ),
              _buildPhotos(context),
              // Container(
              //   height: 15,
              //   margin: EdgeInsets.only(left: 20, right: 20),
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Theme.of(context).dividerColor,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ): Container();

      default:
        return Container(
          key: widget.item.keyContentItem,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 20),
                child: Text(
                  Translate.of(context).translate(widget.item.title),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 200,
                child: Placeholder(),
              )
            ],
          ),
        );
    }
  }
}
