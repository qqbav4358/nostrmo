import 'dart:convert';
import 'dart:isolate';

import 'package:flutter_socks_proxy/socks_proxy.dart';
import 'package:nostrmo/client/event.dart';
import 'package:nostrmo/util/string_util.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'relay_isolate.dart';

class RelayIsolateWorker {
  RelayIsolateConfig config;

  WebSocketChannel? wsChannel;

  RelayIsolateWorker({
    required this.config,
  });

  Future<void> run() async {
    if (StringUtil.isNotBlank(config.network)) {
      // handle isolate network
      var network = config.network;
      network = network!.trim();
      SocksProxy.initProxy(proxy: network);
    }

    ReceivePort mainToSubReceivePort = ReceivePort();
    var mainToSubSendPort = mainToSubReceivePort.sendPort;
    config.subToMainSendPort.send(mainToSubSendPort);

    mainToSubReceivePort.listen((message) async {
      if (message is String) {
        // this is the msg need to sended.
        if (wsChannel != null) {
          wsChannel!.sink.add(message);
        }
      } else if (message is int) {
        // this is const msg.
        // print("msg is $message ${config.url}");
        if (message == RelayIsolateMsgs.CONNECT) {
          // print("${config.url} worker receive connect command");
          // receive the connect command!
          if (wsChannel == null || wsChannel!.closeCode != null) {
            // the websocket is close, close again and try to connect.
            _closeWS(wsChannel);
            // print("${config.url} worker connect again");
            wsChannel = await handleWS();
          } else {
            // print("${config.url} worker send ping");
            // wsChannel!.sink.add("ping");
            // TODO the websocket is connected, try to check or reconnect.
          }
        } else if (message == RelayIsolateMsgs.DIS_CONNECT) {
          _closeWS(wsChannel);
          config.subToMainSendPort.send(RelayIsolateMsgs.DIS_CONNECTED);
        }
      }
    });

    wsChannel = await handleWS();
  }

  static void runRelayIsolate(RelayIsolateConfig config) {
    var worker = RelayIsolateWorker(config: config);
    worker.run();
  }

  Future<WebSocketChannel?> handleWS() async {
    String url = config.url;
    SendPort subToMainSendPort = config.subToMainSendPort;

    final wsUrl = Uri.parse(url);
    try {
      print("Begin to connect ${config.url}");
      wsChannel = WebSocketChannel.connect(wsUrl);
      wsChannel!.stream.listen((message) {
        List<dynamic> json = jsonDecode(message);
        if (json.length > 2) {
          final messageType = json[0];
          if (messageType == 'EVENT') {
            final event = Event.fromJson(json[2]);
            if (config.eventCheck) {
              // event need to check
              if (!event.isValid || !event.isSigned) {
                // check false
                return;
              }
            }
          }
        }
        subToMainSendPort.send(json);
      }, onError: (error) async {
        print("Websocket stream error:  $url");
        _closeWS(wsChannel);
        subToMainSendPort.send(RelayIsolateMsgs.DIS_CONNECTED);
      }, onDone: () {
        print("Websocket stream closed by remote:  $url");
        _closeWS(wsChannel);
        subToMainSendPort.send(RelayIsolateMsgs.DIS_CONNECTED);
      });
      await wsChannel!.ready;
      print("Connect complete! ${config.url}");
      subToMainSendPort.send(RelayIsolateMsgs.CONNECTED);

      return wsChannel;
    } catch (e) {
      _closeWS(wsChannel);
      subToMainSendPort.send(RelayIsolateMsgs.DIS_CONNECTED);
    }

    return null;
  }

  bool _closeWS(WebSocketChannel? wsChannel) {
    if (wsChannel == null) {
      return false;
    }

    try {
      wsChannel.sink.close();
    } catch (e) {
      print("ws close error ${e.toString()}");
    }

    wsChannel = null;
    return true;
  }
}
