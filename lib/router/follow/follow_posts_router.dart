import 'package:flutter/material.dart';
import 'package:nostr_dart/nostr_dart.dart';
import 'package:nostrmo/component/keep_alive_cust_state.dart';
import 'package:nostrmo/component/new_notes_updated_component.dart';
import 'package:nostrmo/consts/base.dart';
import 'package:nostrmo/consts/base_consts.dart';
import 'package:nostrmo/consts/router_path.dart';
import 'package:nostrmo/data/event_mem_box.dart';
import 'package:nostrmo/main.dart';
import 'package:nostrmo/provider/follow_event_provider.dart';
import 'package:nostrmo/provider/follow_new_event_provider.dart';
import 'package:nostrmo/util/router_util.dart';
import 'package:provider/provider.dart';

import '../../component/event/event_list_component.dart';
import '../../component/placeholder/event_list_placeholder.dart';
import '../../component/placeholder/event_placeholder.dart';
import '../../provider/setting_provider.dart';
import '../../util/load_more_event.dart';

class FollowPostsRouter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FollowPostsRouter();
  }
}

class _FollowPostsRouter extends KeepAliveCustState<FollowPostsRouter>
    with LoadMoreEvent {
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    bindLoadMoreScroll(_controller);
  }

  @override
  Widget doBuild(BuildContext context) {
    var _settingProvider = Provider.of<SettingProvider>(context);
    var _followEventProvider = Provider.of<FollowEventProvider>(context);
    var _followNewEventProvider = Provider.of<FollowNewEventProvider>(context);

    var eventBox = _followEventProvider.postsBox;
    var events = eventBox.all();
    if (events.isEmpty) {
      return EventListPlaceholder(
        onRefresh: () {
          followEventProvider.refresh();
        },
      );
    }
    indexProvider.setFollowPostsScrollController(_controller);
    preBuild();

    var main = ListView.builder(
      controller: _controller,
      itemBuilder: (BuildContext context, int index) {
        var event = events[index];
        return EventListComponent(
          event: event,
          showVideo: _settingProvider.videoPreviewInList == OpenStatus.OPEN,
        );
      },
      itemCount: events.length,
    );

    var ri = RefreshIndicator(
      onRefresh: () async {
        followEventProvider.refresh();
      },
      child: main,
    );

    if (_followNewEventProvider.eventPostMemBox.isEmpty()) {
      return ri;
    } else {
      var newEventNum = _followNewEventProvider.eventPostMemBox.length();
      List<Widget> stackList = [ri];
      stackList.add(Positioned(
        top: Base.BASE_PADDING,
        child: NewNotesUpdatedComponent(
          num: newEventNum,
          onTap: () {
            followEventProvider.mergeNewEvent();
          },
        ),
      ));
      return Stack(
        alignment: Alignment.center,
        children: stackList,
      );
    }
  }

  @override
  void doQuery() {
    preQuery();
    followEventProvider.doQuery(until: until);
  }

  @override
  EventMemBox getEventBox() {
    return followEventProvider.postsBox;
  }

  @override
  Future<void> onReady(BuildContext context) async {}
}
