import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nostr_dart/nostr_dart.dart';
import 'package:nostrmo/client/cust_nostr.dart';

import '../../client/event_kind.dart' as kind;
import '../client/cust_contact_list.dart';
import '../client/filter.dart';
import '../main.dart';
import '../util/string_util.dart';
import 'data_util.dart';

class ContactListProvider extends ChangeNotifier {
  static ContactListProvider? _contactListProvider;

  Event? _event;

  CustContactList? _contactList;

  static ContactListProvider getInstance() {
    if (_contactListProvider == null) {
      _contactListProvider = ContactListProvider();

      var str = sharedPreferences.getString(DataKey.CONTACT_LIST);
      if (StringUtil.isNotBlank(str)) {
        var jsonMap = jsonDecode(str!);
        _contactListProvider!._event = Event.fromJson(jsonMap);
        _contactListProvider!._contactList =
            CustContactList.fromJson(_contactListProvider!._event!.tags);
      } else {
        _contactListProvider!._contactList = CustContactList();
      }
    }
    return _contactListProvider!;
  }

  var subScriptId = StringUtil.rndNameStr(16);

  ///  pull to local where nostr init complete.
  // void pullToLocal() {
  void subscribe({CustNostr? targetNostr}) {
    targetNostr ??= nostr;
    subScriptId = StringUtil.rndNameStr(16);
    var filter = Filter(
        kinds: [kind.EventKind.CONTACT_LIST],
        limit: 1,
        authors: [targetNostr!.publicKey]);
    targetNostr.pool.subscribe([filter.toJson()], _onEvent, subScriptId);
  }

  void _onEvent(Event e) {
    if (e.kind == kind.EventKind.CONTACT_LIST) {
      if (_event == null || e.createdAt > _event!.createdAt) {
        _event = e;

        // adapt to package nostr_dart
        var length = e.tags.length;
        List<dynamic> tags = List.filled(length, null, growable: false);
        for (var i = 0; i < length; i++) {
          var tag = e.tags[i];
          List<String> targetTag = [];
          for (var tagValue in tag) {
            targetTag.add(tagValue);
          }
          tags[i] = targetTag;
        }
        _contactList = CustContactList.fromJson(tags);

        _saveAndNotify();
      }
    }
  }

  void _saveAndNotify() {
    var jsonMap = _event!.toJson();
    var jsonStr = jsonEncode(jsonMap);
    sharedPreferences.setString(DataKey.CONTACT_LIST, jsonStr);
    notifyListeners();
  }

  void addContact(Contact contact) {
    _contactList!.add(contact);
    _event = nostr!.sendContactList(_contactList!);

    _saveAndNotify();
  }

  void removeContact(String pubKey) {
    _contactList!.remove(pubKey);
    _event = nostr!.sendContactList(_contactList!);

    _saveAndNotify();
  }

  Iterable<Contact> list() {
    return _contactList!.list();
  }

  Contact? getContact(String pubKey) {
    return _contactList!.get(pubKey);
  }
}
