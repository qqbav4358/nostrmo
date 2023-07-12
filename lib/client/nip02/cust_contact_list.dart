import 'contact.dart';

class CustContactList {
  final Map<String, Contact> _contacts;

  final Map<String, int> _followedTags;

  final Map<String, int> _followedCommunitys;

  CustContactList()
      : _contacts = {},
        _followedTags = {},
        _followedCommunitys = {};

  factory CustContactList.fromJson(List<dynamic> tags) {
    Map<String, Contact> _contacts = {};
    Map<String, int> _followedTags = {};
    Map<String, int> _followedCommunitys = {};
    for (List<dynamic> tag in tags) {
      var length = tag.length;
      if (length == 0) {
        continue;
      }

      var t = tag[0];
      if (t == "p") {
        String url = "";
        String petname = "";
        if (length > 2) {
          url = tag[2];
        }
        if (length > 3) {
          petname = tag[3];
        }
        final contact = Contact(publicKey: tag[1], url: url, petname: petname);
        _contacts[contact.publicKey] = contact;
      } else if (t == "t" && length > 1) {
        var tagName = tag[1];
        _followedTags[tagName] = 1;
      } else if (t == "a" && length > 1) {
        var id = tag[1];
        _followedCommunitys[id] = 1;
      }
    }
    return CustContactList._(_contacts, _followedTags, _followedCommunitys);
  }

  CustContactList._(
      this._contacts, this._followedTags, this._followedCommunitys);

  List<dynamic> toJson() {
    List<dynamic> result = [];
    for (Contact contact in _contacts.values) {
      result.add(["p", contact.publicKey, contact.url, contact.petname]);
    }
    for (var followedTag in _followedTags.keys) {
      result.add(["t", followedTag]);
    }
    for (var id in _followedCommunitys.keys) {
      result.add(["a", id]);
    }
    return result;
  }

  void add(Contact contact) {
    _contacts[contact.publicKey] = contact;
  }

  Contact? get(String publicKey) {
    return _contacts[publicKey];
  }

  Contact? remove(String publicKey) {
    return _contacts.remove(publicKey);
  }

  Iterable<Contact> list() {
    return _contacts.values;
  }

  bool isEmpty() {
    return _contacts.isEmpty;
  }

  int total() {
    return _contacts.length;
  }

  void clear() {
    _contacts.clear();
  }

  bool containsTag(String tagName) {
    return _followedTags.containsKey(tagName);
  }

  void addTag(String tagName) {
    _followedTags[tagName] = 1;
  }

  void removeTag(String tagName) {
    _followedTags.remove(tagName);
  }

  int totalFollowedTags() {
    return _followedTags.length;
  }

  Iterable<String> tagList() {
    return _followedTags.keys;
  }

  bool containsCommunity(String id) {
    return _followedCommunitys.containsKey(id);
  }

  void addCommunity(String id) {
    _followedCommunitys[id] = 1;
  }

  void removeCommunity(String id) {
    _followedCommunitys.remove(id);
  }

  int totalFollowedCommunities() {
    return _followedCommunitys.length;
  }

  Iterable<String> followedCommunitiesList() {
    return _followedCommunitys.keys;
  }
}
