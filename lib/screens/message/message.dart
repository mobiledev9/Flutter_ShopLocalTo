import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/message_page_model.dart';
import 'package:shoplocalto/screens/chat/chat.dart';
import 'package:shoplocalto/screens/message/create_new_message.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/app_message_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../home/home_controller.dart';

class MessageList extends StatefulWidget {
  MessageList({Key key}) : super(key: key);

  @override
  _MessageListState createState() {
    return _MessageListState();
  }
}

class _MessageListState extends State<MessageList> {
  final HomeController _homeController =
  Get.put(HomeController());
  final _controller = RefreshController(initialRefresh: false);
  final SlidableController _slideController = SlidableController();
  var loading = false;
  MessagePageModel _messagePage;

  @override
  void initState() {
    // _loadData();
    _loadDetails();
    // _onRefresh();
    super.initState();
  }

  ///Fetch API
  // Future<void> _loadData() async {
  //   final ResultApiModel result = await Api.getMessage();
  //   if (result.success) {
  //     setState(() {
  //       _messagePage = MessagePageModel.fromJson(result.data);
  //     });
  //   }
  // }

  Future<void> _loadDetails() async {
    setState(() {
      loading = true;
    });
    final dynamic result = await Api.getMessagesList();
    setState(() {
      _messagePage = result;
    });
    print(
        '-----------------length------------------${_messagePage.messages.length}');
    setState(() {
      loading = false;
    });
  }

  ///On load more
  Future<void> _onLoading() async {
    await Future.delayed(Duration(seconds: 1));
    _controller.loadComplete();
  }

  ///On refresh
  Future<void> _onRefresh() async {
    _loadDetails();
    await Future.delayed(Duration(seconds: 1));
    _controller.refreshCompleted();
  }

  ///On navigate chat screen
  void _onChat(MessageModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Chat(
            id: item.id,)),
    );
    // Navigator.pushNamed(context, Routes.chat, arguments: item.id);
  }

  ///Build list
  Widget _buildList() {
    List<MessageModel> message =
    _messagePage == null ? [] : _messagePage.messages;
    if (message.isEmpty && loading == false) {
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

    return loading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
      padding: EdgeInsets.only(top: 5),
      itemCount: message.length,
      itemBuilder: (context, index) {
        final item = message[index];
        return Slidable(
          controller: _slideController,
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: AppMessageItem(
            item: item,
            onPressed: () {
              _onChat(item);
            },
            border: message.length - 1 != index,
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: Translate.of(context).translate('more'),
              color: Theme.of(context).dividerColor,
              icon: Icons.more_horiz,
              onTap: () => {},
            ),
            IconSlideAction(
              caption: Translate.of(context).translate('delete'),
              color: Theme.of(context).accentColor,
              icon: Icons.delete,
              onTap: () => {},
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: _homeController.fromnav == true.obs ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _homeController.fromnav = false.obs;
            Navigator.pop(context);
          },
        ) : Container(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Text(
              Translate.of(context).translate('message'),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateNewMessage()),
                  );
                },
                child: Icon(Icons.add)),
          ],
        ),
      ),
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: _controller,
          header: ClassicHeader(
            idleText: Translate.of(context).translate('pull_down_refresh'),
            refreshingText: Translate.of(context).translate('refreshing'),
            completeText: Translate.of(context).translate('refresh_completed'),
            releaseText: Translate.of(context).translate('release_to_refresh'),
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
    );
  }
}
