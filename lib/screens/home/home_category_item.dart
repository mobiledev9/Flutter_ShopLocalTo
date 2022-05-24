import 'package:flutter/material.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class HomeCategoryItem extends StatelessWidget {
  final CategoryModel2 item;
  final ValueChanged<CategoryModel2> onPressed;

  HomeCategoryItem({
    Key key,
    this.item,
    this.onPressed,
  }) : super(key: key);

  Color colorConvert(String color) {
  print('color666666666666666666666///////:$color');
  color = color.replaceFirst("#", "");
  var converted;
  if (color.length == 6) {
    converted = Color(int.parse("0xFF" + color));
  } else if (color.length == 8) {
    converted = Color(int.parse("0x" + color));
  }
  return converted;
}

  @override
  Widget build(BuildContext context) {
     print("..............................................................${item.color}");
    if (item == null) {
      return Shimmer.fromColors(
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
        enabled: true,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.21,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  Translate.of(context).translate('loading'),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
        
      child: Container(
    width: MediaQuery.of(context).size.width * 0.21,
    child: GestureDetector(
      onTap: () => onPressed(item),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 45,
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // ............................
              color: colorConvert(item.color),
            ),
            child: Image.network(item.icon,width: 25,height: 25,),
          ),
          Padding(
            padding: EdgeInsets.only(top: 3, left: 2, right: 2),
            child: Text(
              item.title,
              maxLines: 4,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    ),
        ),
      );
  }
}
