import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';

class SendMessage extends StatefulWidget {
  final MessageModel item;
  final ValueChanged<bool> isSelected;
  const SendMessage({Key key, this.item, this.isSelected}) : super(key: key);

  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
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
            // Text(
            //   DateFormat(
            //     'EEE MMM d yyyy',
            //     AppLanguage.defaultLanguage.languageCode,
            //   ).format(item.date),
            //   style: Theme.of(context).textTheme.bodyText1,
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
            SizedBox(width: 8),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .5,
                maxHeight: MediaQuery.of(context).size.width * .3,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(isSelected ? 0.4 : 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
              child: widget.item.type == Type.photo
                  ? ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
                child: Image.file(
                  widget.item.file,
                  fit: BoxFit.contain,
                ),
              )
                  : Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  widget.item.message,
                  style: Theme.of(context).textTheme.bodyText1.apply(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


