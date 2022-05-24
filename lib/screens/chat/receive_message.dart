import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/widgets/widget.dart';
class ReceiveMessage extends StatefulWidget {
  final MessageModel item;
  final ValueChanged<bool> isSelected;
  const ReceiveMessage({Key key, this.item, this.isSelected}) : super(key: key);

  @override
  _ReceiveMessageState createState() => _ReceiveMessageState();
}

class _ReceiveMessageState extends State<ReceiveMessage> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // AppCircleAvatar(
            //   imgUrl: item.from.image,
            // ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: 8),
                  //   child: Text(
                  //     item.from.name,
                  //     style: Theme.of(context).textTheme.caption,
                  //   ),
                  // ),
                  isSelected
                      ? Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.check_box,
                        color: Colors.blue,
                      ),
                    ),
                  )
                      : Container(),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .5,
                      maxHeight: MediaQuery.of(context).size.height * .3,
                    ),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor.withOpacity(isSelected ? 0.4 : 1),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      image:  widget.item.type == Type.photo
                          ? DecorationImage(
                        image: AssetImage(
                          widget.item.file.path,
                        ),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child:  widget.item.type == Type.textMessage
                        ? Text(
                      widget.item.message,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                        : null,
                  ),
                ],
              ),
            ),
            Text(
              DateFormat(
                'EEE MMM d yyyy',
                AppLanguage.defaultLanguage.languageCode,
              ).format( widget.item.date),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}




