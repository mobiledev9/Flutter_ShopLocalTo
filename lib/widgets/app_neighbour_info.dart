import 'package:flutter/material.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/model_shops.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';

// enum ProductViewType { small, gird, list, block, cardLarge, cardSmall }

class AppNeighbourItem extends StatelessWidget {
  AppNeighbourItem({
    Key key,
    this.item,
    this.onPressed,
    this.type,
  }) : super(key: key);

  final ShopModel item;
  final ProductViewType type;
  final Function(ProductModel) onPressed;

  @override
  Widget build(BuildContext context) {

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
                      image: AssetImage(item.image),
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
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              item.favourite
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
                  item.subtitle,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AppTag(
                      "${item.num_rate}",
                      type: TagType.rateSmall,
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    StarRating(
                      rating: item.rate,
                      size: 14,
                      color: AppTheme.yellowColor,
                      borderColor: AppTheme.yellowColor,
                    )
                  ],
                ),
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

    
  }
}
