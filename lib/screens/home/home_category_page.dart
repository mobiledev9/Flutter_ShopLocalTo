import 'package:flutter/material.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class HomeCategoryPage extends StatelessWidget {
  final CategoryModel2 categoryModel2;
  final ValueChanged<CategoryModel2> onPressed;

  HomeCategoryPage({
    Key key,
    this.onPressed,
    this.categoryModel2,
  }) : super(key: key);

  Color colorConvert(String color) {
    // print('color666666666666666666666///////:$color');
    color = color.replaceAll("#", "");
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
    // print('this is the color you are looking for:${categoryModel2.color}');
    if (categoryModel2 == null) {
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

    return Container(
      width: MediaQuery.of(context).size.width * 0.21,
      child: GestureDetector(
        onTap: () {
          onPressed(categoryModel2);
        },
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
                color: colorConvert(categoryModel2.color),
              ),
              child:Image.network(categoryModel2.icon,width: 25,height: 25,),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                categoryModel2.title,
                maxLines: 3,
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
    );
  }
}
