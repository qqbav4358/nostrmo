import 'package:flutter/material.dart';
import 'package:nostrmo/util/router_util.dart';

import '../generated/l10n.dart';

class ComfirmDialog {
  static Future<bool> show(BuildContext context, String content) async {
    var s = S.of(context);
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(s.Notice),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                child: Text(s.Cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(s.Comfirm),
                onPressed: () async {
                  RouterUtil.back(context, true);
                },
              ),
            ],
          );
        });
  }
}
