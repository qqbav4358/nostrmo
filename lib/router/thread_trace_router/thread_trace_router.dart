import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nostrmo/client/filter.dart';
import 'package:nostrmo/component/event/event_main_component.dart';
import 'package:nostrmo/consts/router_path.dart';
import 'package:nostrmo/main.dart';
import 'package:nostrmo/router/thread_trace_router/event_trace_info.dart';
import 'package:nostrmo/util/string_util.dart';
import 'package:screenshot/screenshot.dart';

import '../../client/aid.dart';
import '../../client/event.dart';
import '../../client/event_kind.dart';
import '../../client/event_relation.dart';
import '../../component/appbar_back_btn_component.dart';
import '../../component/event_reply_callback.dart';
import '../../consts/base.dart';
import '../../util/peddingevents_later_function.dart';
import '../../util/platform_util.dart';
import '../../util/router_util.dart';
import '../../util/when_stop_function.dart';
import '../thread/thread_detail_event_main_component.dart';
import '../thread/thread_detail_item_component.dart';
import '../thread/thread_router_helper.dart';

class ThreadTraceRouter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ThreadTraceRouter();
  }
}

class _ThreadTraceRouter extends State<ThreadTraceRouter>
    with PenddingEventsLaterFunction, WhenStopFunction, ThreadRouterHelper {
  // used to filter parent events
  Map<String, int> parentIds = {};
  List<EventTraceInfo> parentEventTraces = [];

  Event? sourceEvent;

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var arg = RouterUtil.routerArgs(context);
    if (arg == null || arg is! Event) {
      RouterUtil.back(context);
      return Container();
    }
    if (sourceEvent == null) {
      // first load
      sourceEvent = arg;
      fetchDatas();
    } else {
      if (sourceEvent!.id != arg.id) {
        // find update
        sourceEvent = arg;
        fetchDatas();
      }
    }

    var themeData = Theme.of(context);
    var cardColor = themeData.cardColor;

    Widget? appBarTitle = Container();

    List<Widget> mainList = [];

    List<Widget> traceList = [];
    if (parentEventTraces.isNotEmpty) {
      var length = parentEventTraces.length;
      for (var i = 0; i < length; i++) {
        var pet = parentEventTraces[length - 1 - i];
        var screenshotController = ScreenshotController();

        traceList.add(GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            RouterUtil.router(
                context, RouterPath.getThreadDetailPath(), pet.event);
          },
          child: Screenshot(
            controller: screenshotController,
            child: EventMainComponent(
              screenshotController: screenshotController,
              event: pet.event,
              showReplying: false,
              showVideo: true,
              imageListMode: false,
              showSubject: false,
              showLinkedLongForm: false,
              traceMode: true,
              textOnTap: () {
                RouterUtil.router(
                    context, RouterPath.getThreadDetailPath(), pet.event);
              },
            ),
          ),
        ));
      }
    }
    var screenshotController = ScreenshotController();
    mainList.add(Container(
      color: cardColor,
      margin: EdgeInsets.only(bottom: Base.BASE_PADDING_HALF),
      padding: EdgeInsets.only(top: Base.BASE_PADDING_HALF),
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  width: 2,
                  color: themeData.hintColor.withOpacity(0.25),
                ),
                top: 38,
                bottom: 0,
                left: 28,
              ),
              Column(
                children: traceList,
              ),
            ],
          ),
          Screenshot(
            controller: screenshotController,
            child: EventMainComponent(
              key: sourceEventKey,
              screenshotController: ScreenshotController(),
              event: sourceEvent!,
              showReplying: false,
              showVideo: true,
              imageListMode: false,
              showSubject: false,
              showLinkedLongForm: false,
            ),
          )
        ],
      ),
    ));

    for (var item in rootSubList) {
      // if (item.event.kind == kind.EventKind.ZAP &&
      //     StringUtil.isBlank(item.event.content)) {
      //   continue;
      // }

      var totalLevelNum = item.totalLevelNum;
      var needWidth = (totalLevelNum - 1) *
              (Base.BASE_PADDING +
                  ThreadDetailItemMainComponent.BORDER_LEFT_WIDTH) +
          ThreadDetailItemMainComponent.EVENT_MAIN_MIN_WIDTH;
      if (needWidth > mediaDataCache.size.width) {
        mainList.add(SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: needWidth,
            child: ThreadDetailItemComponent(
              item: item,
              totalMaxWidth: needWidth,
              sourceEventId: sourceEvent!.id,
              sourceEventKey: sourceEventKey,
            ),
          ),
        ));
      } else {
        mainList.add(ThreadDetailItemComponent(
          item: item,
          totalMaxWidth: needWidth,
          sourceEventId: sourceEvent!.id,
          sourceEventKey: sourceEventKey,
        ));
      }
    }

    Widget main = ListView(
      controller: _controller,
      children: mainList,
    );

    if (PlatformUtil.isTableMode()) {
      main = GestureDetector(
        onVerticalDragUpdate: (detail) {
          _controller.jumpTo(_controller.offset - detail.delta.dy);
        },
        behavior: HitTestBehavior.translucent,
        child: main,
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: AppbarBackBtnComponent(),
        title: appBarTitle,
      ),
      body: EventReplyCallback(
        onReplyCallback: onReplyCallback,
        child: main,
      ),
    );
  }

  void fetchDatas() {
    box.clear();
    parentEventTraces.clear();
    rootSubList.clear();

    // find parent data
    var eventRelation = EventRelation.fromEvent(sourceEvent!);
    var replyId = eventRelation.replyOrRootId;
    if (StringUtil.isNotBlank(replyId)) {
      findParentEvent(replyId!);
    }

    // find reply data
    AId? aId;
    if (eventRelation.aId != null &&
        eventRelation.aId!.kind == EventKind.LONG_FORM) {
      aId = eventRelation.aId;
    }

    List<int> replyKinds = [...EventKind.SUPPORTED_EVENTS]
      ..remove(EventKind.REPOST);

    // query sub events
    var filter = Filter(e: [sourceEvent!.id], kinds: replyKinds);

    var filters = [filter.toJson()];
    if (aId != null) {
      var f = Filter(kinds: replyKinds);
      var m = f.toJson();
      m["#a"] = [aId.toAString()];
      filters.add(m);
    }

    // print(filters);

    nostr!.query(filters, onEvent);
  }

  String parentEventId(String eventId) {
    return "eventTrace${eventId.substring(0, 8)}";
  }

  void findParentEvent(String eventId) {
    // log("findParentEvent $eventId");
    var pe = singleEventProvider.getEvent(eventId, queryData: false);
    if (pe == null) {
      var filter = Filter(ids: [eventId]);
      nostr!
          .query([filter.toJson()], onParentEvent, id: parentEventId(eventId));
    } else {
      onParentEvent(pe);
    }
  }

  void onParentEvent(Event e) {
    // log(jsonEncode(e.toJson()));
    singleEventProvider.onEvent(e);

    EventTraceInfo? addedEti;
    if (parentEventTraces.isEmpty) {
      addedEti = EventTraceInfo(e);
      parentEventTraces.add(addedEti);
    } else {
      if (parentEventTraces.last.eventRelation.replyOrRootId == e.id) {
        addedEti = EventTraceInfo(e);
        parentEventTraces.add(addedEti);
      }
    }

    if (addedEti != null) {
      // a new event find, try to find a new parent event
      var replyId = addedEti.eventRelation.replyOrRootId;
      if (StringUtil.isNotBlank(replyId)) {
        findParentEvent(replyId!);
      }

      setState(() {});
    }
  }
}
