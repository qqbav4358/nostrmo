import 'package:flutter/material.dart';
import 'package:nostrmo/component/cust_state.dart';
import 'package:nostrmo/main.dart';
import 'package:provider/provider.dart';

import '../../consts/router_path.dart';
import '../../provider/notice_provider.dart';
import '../../util/router_util.dart';
import '../edit/editor_router.dart';
import 'notice_list_item_component.dart';

class NoticeRouter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoticeRouter();
  }
}

class _NoticeRouter extends State<NoticeRouter> {
  @override
  Widget build(BuildContext context) {
    var _noticeProvider = Provider.of<NoticeProvider>(context);
    var notices = _noticeProvider.notices;
    var length = notices.length;

    Widget? main;
    if (length == 0) {
      main = Container(
        child: Center(
          child: GestureDetector(
            onTap: () {
              EditorRouter.open(context);
            },
            child: Text("NOTICE"),
          ),
        ),
      );
    } else {
      main = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var notice = notices[length - 1 - index];
          return NoticeListItemComponent(
            notice: notice,
          );
        },
        itemCount: length,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Notices"),
      ),
      body: main,
    );
  }
}
