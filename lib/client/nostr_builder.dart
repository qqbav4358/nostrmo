import 'dart:developer';

import 'package:nostr_dart/nostr_dart.dart';
import 'package:nostrmo/client/cust_nostr.dart';
import 'package:nostrmo/main.dart';

import '../data/relay_status.dart';
import 'cust_relay.dart';

CustNostr genNostr(String pk) {
  // init nostr
  var _nostr = CustNostr(privateKey: pk);
  log("nostr init over");

  // add subscript
  contactListProvider.subscribe(targetNostr: _nostr);

  // load relay addr and init
  _loadRelayAndInit(_nostr);
  return _nostr;
}

Future<void> _loadRelayAndInit(CustNostr _nostr) async {
  List<String> relayAddrs = ["wss://nos.lol", "wss://nostr.wine"];
  // TODO load relay addr

  // List<Future> futureList = [];
  for (var relayAddr in relayAddrs) {
    var relayStatus = RelayStatus(relayAddr);
    var relay = Relay(
      relayStatus.addr,
      access: WriteAccess.readWrite,
    );
    var custRelay = CustRelay(relay, relayStatus);

    var future = _nostr.pool.add(custRelay, autoSubscribe: true);
    // futureList.add(future);
  }
  // await Future.wait(futureList);
}
