import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/models/model.dart';
import 'package:shoplocalto/models/screen_models/screen_models.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../home/home_controller.dart';

class NotificationList extends StatefulWidget {
  NotificationList({Key key}) : super(key: key);

  @override
  _NotificationListState createState() {
    return _NotificationListState();
  }
}

class _NotificationListState extends State<NotificationList> {
  final HomeController _homeController =
  Get.put(HomeController());
  final _controller = RefreshController(initialRefresh: false);
  var loading = false;
  NotificationPageModel _notificationPage;

  @override
  void initState() {
    // _loadData();
    _loadDetail();
    super.initState();
  }

  ///Fetch API
  // Future<void> _loadData() async {
  //   final ResultApiModel result = await Api.getNotification();
  //   if (result.success) {
  //     setState(() {
  //       _notificationPage = NotificationPageModel.fromJson(result.data);
  //     });
  //   }
  // }

    Future<void> _loadDetail() async {
      setState(() {

        loading = true;
      });
    final dynamic result = await Api.getUserNotification();
      setState(() {
        _notificationPage = result;
      });
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
    await Future.delayed(Duration(seconds: 1));
    _controller.refreshCompleted();
    _loadDetail();
  }


  ///Build list
  Widget _buildList() {
    List<NotificationModel> notification = _notificationPage == null?[]:_notificationPage.notifications;
    if (notification.isEmpty && loading == false) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.sentiment_satisfied),
            Padding(
              padding: EdgeInsets.all(3.0),
              child: Text(
                Translate.of(context).translate('No Notifications pull down to refresh'),
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
      //       return AppNotificationItem();
      //     },
      //   ).toList(),
      // );
    }

    return loading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
      padding: EdgeInsets.only(top: 5),
      itemCount: notification.length,
      itemBuilder: (context, index) {
        final item = notification[index];
        return Dismissible(
          key: Key(item.id.toString()),
          direction: DismissDirection.endToStart,
          child: AppNotificationItem(
            item: item,
            onPressed: () {},
            border: notification.length - 1 != index,
          ),
          background: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 20, right: 20),
            color: Theme.of(context).accentColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.delete,
                  color: Colors.white,
                )
              ],
            ),
          ),
          onDismissed: (direction) {
            notification.removeAt(index);
          },
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
        title: Text(
          Translate.of(context).translate('notification'),
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
