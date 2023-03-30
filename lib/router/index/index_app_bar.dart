import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:nostrmo/provider/relay_provider.dart';
import 'package:nostrmo/util/router_util.dart';
import 'package:provider/provider.dart';

import '../../component/user_pic_component.dart';
import '../../consts/base.dart';
import '../../main.dart';

class IndexAppBar extends StatefulWidget {
  static const double height = 56;

  Widget? center;

  IndexAppBar({this.center});

  @override
  State<StatefulWidget> createState() {
    return _IndexAppBar();
  }
}

class _IndexAppBar extends State<IndexAppBar> {
  double picHeight = 30;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var paddingTop = mediaDataCache.padding.top;
    var mainColor = themeData.primaryColor;
    var textColor = themeData.appBarTheme.titleTextStyle!.color;

    var userPicWidget = GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: UserPicComponent(
        pubkey: nostr!.publicKey,
        width: picHeight,
      ),
    );

    var center = widget.center;
    center ??= Container();

    var rightWidget =
        Selector<RelayProvider, String>(builder: (context, relayNum, child) {
      return Text(
        relayNum,
        style: TextStyle(color: textColor),
      );
    }, selector: (context, _provider) {
      return _provider.relayNumStr();
    });

    return Container(
      padding: EdgeInsets.only(
        top: paddingTop,
        left: Base.BASE_PADDING,
        right: Base.BASE_PADDING,
      ),
      height: paddingTop + IndexAppBar.height,
      color: mainColor,
      child: Row(children: [
        Container(
          child: userPicWidget,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              left: Base.BASE_PADDING,
              right: Base.BASE_PADDING,
            ),
            child: center,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: rightWidget,
        ),
      ]),
    );
  }
}
