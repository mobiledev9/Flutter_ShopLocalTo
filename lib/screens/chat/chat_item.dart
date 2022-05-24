import 'package:flutter/material.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/screens/chat/receive_message.dart';
import 'package:shoplocalto/screens/chat/send_message.dart';

class ChatItem extends StatefulWidget {
  final MessageModel item;
  final ValueChanged<bool> isSelected;
  const ChatItem({Key key, this.item,this.isSelected}) : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.item.from == null) {
      return SendMessage(item: widget.item,isSelected: widget.isSelected,);
    }

    return ReceiveMessage(item: widget.item,isSelected: widget.isSelected,);
  }
}

