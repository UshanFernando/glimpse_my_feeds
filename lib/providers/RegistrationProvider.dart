import 'package:flutter/material.dart';
import 'package:glimpse_my_feeds/model/FeedItem.dart';
import 'package:glimpse_my_feeds/model/User.dart';
import 'package:glimpse_my_feeds/service/DBService.dart';
import 'package:intl/intl.dart';

class RegistrationProvider with ChangeNotifier {
  final firestoreService = DBService();

  String _username;
  String _email;
  String _password;
  bool _isLogged;
  List<FeedItem> _feedItems = [];

  List<FeedItem> get feedItems => _feedItems;
  String get username => _username;
  bool get isLogged => _isLogged;
  String get email => _email;
  String get password => _password;

  changeUsername(String value) {
    _username = value;
    print(value);
  }

  changeEmail(String value) {
    _email = value;
  }

  changePassword(String value) {
    _password = value;
  }

  changeIsLogged(bool value) {
    _isLogged = value;
  }

  saveToDbDelivery() {
    firestoreService.register(
        User(username: _username, email: _email, password: _password));
    print(username);

    _username = null;
    _email = null;
    _password = null;
    _feedItems = [];
  }

  login() async {
    User user = await firestoreService.loginUser(
        User(username: _username, email: _email, password: _password));

    print("regobj $user");
    if (user != null) {
      changeIsLogged(true);
      print("true");
      return true;
      // print()
    } else {
      changeIsLogged(false);
      return false;
    }
  }

  addFeedsToDb() {
    //   firestoreService.saveFeed(feedItems);
    //   print(username);

    //   _username = null;
    //   _email = null;
    //   _password = null;
    //   _feedItems = [];
    // }
  }
}
