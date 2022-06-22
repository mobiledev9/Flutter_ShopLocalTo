import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/bloc.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/chat_page_model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/screens/chat/chat_item.dart';
import 'package:shoplocalto/screens/chat/video_call.dart';
import 'package:shoplocalto/screens/chat/voice_call.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:async';
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';



class Chat extends StatefulWidget {
  final int id;
  final String name;
  final ProductModel product;

  Chat({this.id, this.name, this.product});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _controller = RefreshController(initialRefresh: false);
  final _textChatController = TextEditingController();
  bool emojiShowing = false;
  bool _loading = true;
  ChatPageModel _chatPage;
  List<MessageModel> _message;
  List<MessageModel> _selectedlist;
  ChatBloc _chatBloc;


  _onEmojiSelected(Emoji emoji) {
    _textChatController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _textChatController.text.length));
  }

  _onBackspacePressed() {
    _textChatController
      ..text = _textChatController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _textChatController.text.length));
  }

  @override
  void initState() {
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    // _loadData();
    _loadDetail();
    super.initState();

  }

  // bool _isConfigInvalid() {
  //   return config.appId == 'd2d7f660798545a4b136972d6f833386' ||
  //       config.token == '006d2d7f660798545a4b136972d6f833386IABjDKjPJ1MvxhN9tKeNOhLZf0VatWPxGfo3sri0JcH3LtzDPrsAAAAAEADjTvSOxKIxYgEAAQDDojFi' ||
  //       config.channelId == 'firstchannel';
  // }
  ///Fetch API
  // Future<void> _loadData() async {
  //   final ResultApiModel result = await Api.getDetailMessage(id: widget.id);
  //   if (result.success) {
  //     setState(() {
  //       _chatPage = ChatPageModel.fromJson(result.data);
  //       _message = _chatPage.message;
  //       _loading = false;
  //     });
  //   }
  // }

  Future<void> _loadDetail() async {
    setState(() {
      _loading = true;
    });
    final dynamic result = await Api.getVendorMessage(id: widget.id);
    setState(() {
      _chatPage = result;
      _message = _chatPage.message;
      _selectedlist = List();
      _loading = false;
    });
  }

  ///On async get Image file
  // Future _attachImage() async {
  //   final image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     final chat = MessageModel.fromJson({
  //       "id": 10,
  //       "date": DateFormat.jm().format(DateTime.now()),
  //       "file": image.path,
  //       "status": "sent"
  //     });
  //     setState(() {
  //        if( _message == null) {
  //         _message = [];
  //       }
  //       _message.add(chat);
  //       _loading = false;
  //     });
  //     UtilOther.hiddenKeyboard(context);
  //   }
  // }

  ///On load more
  Future<void> _onLoading() async {
    // _loadDetail();
    await Future.delayed(Duration(seconds: 1));
    _controller.loadComplete();
  }

  ///On refresh
  Future<void> _onRefresh() async {
    _loadDetail();
    await Future.delayed(Duration(seconds: 1));
    _controller.refreshCompleted();
  }

  ///On Send message
  Future<void> _onSend() async {
    print(_loading.toString());
    final chat = MessageModel.fromJson({
      "id": widget.id,
      "message": _textChatController.text,
      "date": DateFormat.jm().format(DateTime.now()),
      "status": "sent"
    });

    if (_textChatController.text.isNotEmpty) {
      setState(() {
        if (_message == null) {
          _message = [];
        }
        _message.add(chat);
        print(chat);
        _textChatController.clear();
      });
      await Api.chatWithUs(
        comment: chat.message,
        companyid: chat.id,
      );
      // _textChatController.clear();
    }
    // _textChatController.text = '';
    // UtilOther.hiddenKeyboard(context);
  }

  ///On dlt message
  Future<void> _onDelete() async {
    setState(() {
      for (int i = 0; i < _selectedlist.length; i++) {
        _message.remove(_selectedlist[i]);
        final dynamic result = Api.deletemsg(id: _selectedlist[i].id);
        print("i is: $i");
      }
      _selectedlist = List();
    });

    // await Api.deletemsg(
    //   id:
    // );
    // _textChatController.clear();

    // _textChatController.text = '';
    // UtilOther.hiddenKeyboard(context);
  }

  ///Build info Room
  Widget _buildInfo() {
    if (widget.product != null) {
      return Row(
        children: <Widget>[
          // AppGroupCircleAvatar(
          //   member: _chatPage.member,
          //   size: 48,
          // ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.product.title,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                // _chatPage.online > 0
                //     ? Text(
                //         '${_chatPage.online > 1 ? _chatPage.online : ''} Online',
                //         style: Theme.of(context)
                //             .textTheme
                //             .subtitle2
                //             .apply(color: Theme.of(context).primaryColorLight),
                //       )
                //     : Container()
              ],
            ),
          )
        ],
      );
    }

    if (_chatPage == null) {
      return Container();
    }
    String chat = _chatPage == null ? null : _chatPage.roomName;
    int online = _chatPage == null ? null : _chatPage.online;
    return Row(
      children: <Widget>[
        // AppGroupCircleAvatar(
        //   member: _chatPage.member,
        //   size: 48,
        // ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                chat,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              online > 0
                  ? Text(
                      '${online > 1 ? online : ''} Online',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .apply(color: Theme.of(context).primaryColorLight),
                    )
                  : Container()
            ],
          ),
        )
      ],
    );
  }

  ///Build Content
  Widget _buildContent() {
    List<MessageModel> message = _message == null ? [] : _message;
    if (message.isEmpty && _loading == false) {
      return Column(
        children: <Widget>[
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              controller: _controller,
              header: ClassicHeader(
                idleText: Translate.of(context).translate('pull_down_refresh'),
                refreshingText: Translate.of(context).translate('refreshing'),
                completeText:
                    Translate.of(context).translate('refresh_completed'),
                releaseText:
                    Translate.of(context).translate('release_to_refresh'),
                refreshingIcon: SizedBox(
                  width: 16.0,
                  height: 16.0,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              footer: ClassicFooter(
                loadingText: Translate.of(context).translate('loading'),
                canLoadingText: Translate.of(context).translate(
                  'release_to_load_more',
                ),
                idleText: Translate.of(context).translate('pull_to_load_more'),
                loadStyle: LoadStyle.ShowWhenLoading,
                loadingIcon: SizedBox(
                  width: 16.0,
                  height: 16.0,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              // child: ListView.builder(
              //   padding: EdgeInsets.all(15),
              //   itemCount: _message.length,
              //   itemBuilder: (context, index) {
              //     final item = _message[index];
              //     return ChatItem(item: item);
              //   },
              // ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.sentiment_satisfied),
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    Translate.of(context)
                        .translate('No Messages pull down to refresh'),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8, top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Theme.of(context).dividerColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.face),
                              onPressed: () {
                                setState(() {
                                  if (emojiShowing == false) {
                                    emojiShowing = !emojiShowing;
                                    UtilOther.hiddenKeyboard(context);
                                  } else if (emojiShowing == true) {
                                    emojiShowing = emojiShowing;
                                    UtilOther.hiddenKeyboard(context);
                                  }
                                });
                              },
                            ),
                            Expanded(
                              child: TextField(
                                onTap: () {
                                  setState(() {
                                    if (emojiShowing == false) {
                                      emojiShowing = emojiShowing;
                                    } else if (emojiShowing == true) {
                                      emojiShowing = !emojiShowing;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: Translate.of(context).translate(
                                    'type_something',
                                  ),
                                  border: InputBorder.none,
                                  suffixIcon: InkWell(
                                    onTap: _onSend,
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                controller: _textChatController,
                                onSubmitted: (value) {
                                  // _onSend();
                                },
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(left: 16, right: 16),
                            //   child: InkWell(
                            //     onTap: _onSend,
                            //     child: Container(
                            //       alignment: Alignment.center,
                            //       padding: EdgeInsets.all(16.0),
                            //       decoration: BoxDecoration(
                            //         color: Colors.transparent,
                            //         shape: BoxShape.circle,
                            //       ),
                            //       child: Icon(
                            //         Icons.send,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // )
                            // IconButton(
                            //   icon: Icon(Icons.attach_file),
                            //   onPressed: _attachImage,
                            // )
                          ],
                        ),
                        Offstage(
                          offstage: !emojiShowing,
                          child: SizedBox(
                            height: 300,
                            child: EmojiPicker(
                                onEmojiSelected:
                                    (Category category, Emoji emoji) {
                                  _onEmojiSelected(emoji);
                                },
                                onBackspacePressed: _onBackspacePressed,
                                config: Config(
                                    columns: 7,
                                    // Issue: https://github.com/flutter/flutter/issues/28894
                                    emojiSizeMax:
                                        32 * (Platform.isIOS ? 1.30 : 1.0),
                                    verticalSpacing: 0,
                                    horizontalSpacing: 0,
                                    initCategory: Category.RECENT,
                                    bgColor: const Color(0xFFF2F2F2),
                                    indicatorColor: Colors.blue,
                                    iconColor: Colors.grey,
                                    iconColorSelected: Colors.blue,
                                    progressIndicatorColor: Colors.blue,
                                    backspaceColor: Colors.blue,
                                    skinToneDialogBgColor: Colors.white,
                                    skinToneIndicatorColor: Colors.grey,
                                    enableSkinTones: true,
                                    showRecentsTab: true,
                                    recentsLimit: 28,
                                    // noRecents: 'No Recents',
                                    // noRecentsStyle: const TextStyle(
                                    //     fontSize: 20, color: Colors.black26),
                                    tabIndicatorAnimDuration:
                                        kTabScrollDuration,
                                    categoryIcons: const CategoryIcons(),
                                    buttonMode: ButtonMode.MATERIAL)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }

    // if (_loading) {
    //   return Center(
    //     child: SizedBox(
    //       width: 26,
    //       height: 26,
    //       child: CircularProgressIndicator(
    //         strokeWidth: 2,
    //       ),
    //     ),
    //   );
    // }

    return Column(
      children: <Widget>[
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            controller: _controller,
            header: ClassicHeader(
              idleText: Translate.of(context).translate('pull_down_refresh'),
              refreshingText: Translate.of(context).translate('refreshing'),
              completeText:
                  Translate.of(context).translate('refresh_completed'),
              releaseText:
                  Translate.of(context).translate('release_to_refresh'),
              refreshingIcon: SizedBox(
                width: 16.0,
                height: 16.0,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            footer: ClassicFooter(
              loadingText: Translate.of(context).translate('loading'),
              canLoadingText: Translate.of(context).translate(
                'release_to_load_more',
              ),
              idleText: Translate.of(context).translate('pull_to_load_more'),
              loadStyle: LoadStyle.ShowWhenLoading,
              loadingIcon: SizedBox(
                width: 16.0,
                height: 16.0,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            child: _buildList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8, top: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Theme.of(context).dividerColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.face),
                            onPressed: () {
                              setState(() {
                                if (emojiShowing == false) {
                                  emojiShowing = !emojiShowing;
                                  UtilOther.hiddenKeyboard(context);
                                } else if (emojiShowing == true) {
                                  emojiShowing = emojiShowing;
                                  UtilOther.hiddenKeyboard(context);
                                }
                              });
                            },
                          ),
                          Expanded(
                            child: TextField(
                              onTap: () {
                                setState(() {
                                  if (emojiShowing == false) {
                                    emojiShowing = emojiShowing;
                                  } else if (emojiShowing == true) {
                                    emojiShowing = !emojiShowing;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: Translate.of(context).translate(
                                  'type_something',
                                ),
                                border: InputBorder.none,
                                suffixIcon: InkWell(
                                  onTap: _onSend,
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              controller: _textChatController,
                              onSubmitted: (value) {
                                _onSend();
                                // setState(() {
                                //   _textChatController.clear();
                                // });
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 16, right: 16),
                          //   child: InkWell(
                          //     onTap: _onSend,
                          //     child: Container(
                          //       alignment: Alignment.center,
                          //       padding: EdgeInsets.all(16.0),
                          //       decoration: BoxDecoration(
                          //         color: Colors.transparent,
                          //         shape: BoxShape.circle,
                          //       ),
                          //       child: Icon(
                          //         Icons.send,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // )
                          // IconButton(
                          //   icon: Icon(Icons.attach_file),
                          //   onPressed: _attachImage,
                          // )
                        ],
                      ),
                      Offstage(
                        offstage: !emojiShowing,
                        child: SizedBox(
                          height: 300,
                          child: EmojiPicker(
                              onEmojiSelected:
                                  (Category category, Emoji emoji) {
                                _onEmojiSelected(emoji);
                              },
                              onBackspacePressed: _onBackspacePressed,
                              config: Config(
                                  columns: 7,
                                  // Issue: https://github.com/flutter/flutter/issues/28894
                                  emojiSizeMax:
                                      32 * (Platform.isIOS ? 1.30 : 1.0),
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  initCategory: Category.RECENT,
                                  bgColor: const Color(0xFFF2F2F2),
                                  indicatorColor: Colors.blue,
                                  iconColor: Colors.grey,
                                  iconColorSelected: Colors.blue,
                                  progressIndicatorColor: Colors.blue,
                                  backspaceColor: Colors.blue,
                                  skinToneDialogBgColor: Colors.white,
                                  skinToneIndicatorColor: Colors.grey,
                                  enableSkinTones: true,
                                  showRecentsTab: true,
                                  recentsLimit: 28,
                                  // noRecentsText: 'No Recents',
                                  // noRecentsStyle: const TextStyle(
                                  //     fontSize: 20, color: Colors.black26),
                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                  categoryIcons: const CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildList() {
    List<MessageModel> message = _message == null ? [] : _message;
    if (message.isEmpty && _loading == false) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.sentiment_satisfied),
            Padding(
              padding: EdgeInsets.all(3.0),
              child: Text(
                Translate.of(context)
                    .translate('No Messages pull down to refresh'),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      );
      // return ListView(
      //   padding: EdgeInsets.only(top: 5),
      //   children: List.generate(8, (index) => index).map(
      //     (item) {
      //       return AppMessageItem();
      //     },
      //   ).toList(),
      // );
    }

    return _loading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: _message.length,
            itemBuilder: (context, index) {
              final item = _message[index];

              return ChatItem(
                key: Key(item.id.toString()),
                item: item,
                isSelected: (bool value) {
                  setState(() {
                    if (value) {
                      _selectedlist.add(item);
                      print(_selectedlist);
                    } else {
                      _selectedlist.remove(item);
                      // _selectedlist = List();
                    }
                  });
                  print("$index : $value");
                },
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: _selectedlist.length < 1
                  ? _buildInfo()
                  : Text(_selectedlist.length.toString()),
              actions: <Widget>[
                _selectedlist.length < 1
                    ? Row(
                        children: [
                          // IconButton(
                          //   icon: Icon(Icons.phone),
                          //   onPressed: () {
                          //     // Navigator.push(
                          //     //   context,
                          //     //   MaterialPageRoute(builder: (context) => VoiceCallScreen( id: widget.id,)),
                          //     // );
                          //
                          //   },
                          // ),
                          // IconButton(
                          //   icon: Icon(Icons.videocam),
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(builder: (context) => VideocallScreen( id: widget.id,)),
                          //     );
                          //   },
                          // ),
                          IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {

                            },
                          ),
                        ],
                      )
                    : InkWell(
                        onTap: () {
                          _onDelete();
                          // setState(() {
                          //   for (int i = 0; i < _selectedlist.length; i++) {
                          //     _message.remove(_selectedlist[i]);
                          //
                          //     print("i is: $i");
                          //   }
                          //   _selectedlist = List();
                          // });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.delete),
                        )),
              ],
            ),
            body: SafeArea(child: _buildContent()),
          );
  }
}
