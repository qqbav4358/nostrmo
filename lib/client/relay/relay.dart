import '../../consts/client_connected.dart';
import '../../data/relay_status.dart';
import '../subscription.dart';
import 'relay_info.dart';
import 'relay_info_util.dart';

enum WriteAccess { readOnly, writeOnly, readWrite, nothing }

abstract class Relay {
  final String url;

  RelayStatus relayStatus;

  RelayInfo? info;

  // to hold the message when the ws havn't connected and should be send after connected.
  List<List<dynamic>> pendingMessages = [];

  Function(Relay, List<dynamic>)? onMessage;

  // quries
  final Map<String, Subscription> _queries = {};

  Relay(this.url, this.relayStatus) {}

  /// The method to call connect function by framework.
  Future<bool> connect() async {
    try {
      var result = await doConnect();
      if (result) {
        try {
          onConnected();
        } catch (e) {
          print("onConnected exception.");
          print(e);
        }
      }
      return result;
    } catch (e) {
      print("connect fail");
      disconnect();
      return false;
    }
  }

  /// The method implement by different relays to do some real when it connecting.
  Future<bool> doConnect();

  /// The medhod called after relay connect success.
  Future onConnected() async {
    for (var message in pendingMessages) {
      // TODO To check result? and how to handle if send fail?
      var result = send(message);
      if (result) {
        print("message send fail onConnected");
      }
    }

    pendingMessages.clear();
  }

  Future<void> getRelayInfo(url) async {
    info ??= await RelayInfoUtil.get(url);
  }

  bool send(List<dynamic> message, {bool? forceSend});

  Future<void> disconnect();

  bool _waitingReconnect = false;

  void onError(String errMsg, {bool reconnect = false}) {
    print("relay error $errMsg");
    relayStatus.onError();
    relayStatus.connected = ClientConneccted.UN_CONNECT;
    if (relayStatusCallback != null) {
      relayStatusCallback!();
    }
    disconnect();

    if (reconnect && !_waitingReconnect) {
      _waitingReconnect = true;
      Future.delayed(const Duration(seconds: 30), () {
        _waitingReconnect = false;
        connect();
      });
    }
  }

  void saveQuery(Subscription subscription) {
    _queries[subscription.id] = subscription;
  }

  bool checkAndCompleteQuery(String id) {
    // all subscription should be close
    var sub = _queries.remove(id);
    if (sub != null) {
      send(["CLOSE", id]);
      return true;
    }
    return false;
  }

  bool checkQuery(String id) {
    return _queries[id] != null;
  }

  Subscription? getRequestSubscription(String id) {
    return _queries[id];
  }

  Function? relayStatusCallback;

  void dispose() {}
}
