import 'package:flutter/material.dart';
import 'package:glimpse_my_feeds/model/FeedItem.dart';
import 'package:glimpse_my_feeds/model/User.dart';
import 'package:glimpse_my_feeds/service/DBService.dart';
import 'package:glimpse_my_feeds/service/StorageController.dart';
import 'package:intl/intl.dart';

class FeedProvider with ChangeNotifier {
  final firestoreService = DBService();

  String _title;
  String _url;
  // String _password;
  // bool _isLogged;
  // List<FeedItem> _feedItems = [];

  // List<FeedItem> get feedItems => _feedItems;
  // String get username => _username;
  String get title => _title;
  String get url => _url;

  changeTitle(String value) {
    _title = value;
  }

  changeUrl(String value) {
    _url = value;
  }

  // changePassword(String value) {
  //   _password = value;
  // }

  // changeIsLogged(bool value) {
  //   _isLogged = value;
  // }

  saveToDbFeed() {
    StorageManager.readData('user').then((value) =>
        {firestoreService.saveFeed(FeedItem(title: _title, url: _url), value)});
  }
}
