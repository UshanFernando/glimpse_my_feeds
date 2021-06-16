import 'package:flutter/material.dart';
import 'package:glimpse_my_feeds/model/FeedItem.dart';
import 'package:glimpse_my_feeds/model/User.dart';
import 'package:glimpse_my_feeds/service/DBService.dart';
import 'package:glimpse_my_feeds/service/StorageController.dart';
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

  Future<bool> getLoggedStatus() async {
    var value = await StorageManager.readData('email');

    print('value read from storage: ' + value.toString());
    var email = value ?? null;
    if (email != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getUserName() async {
    return await StorageManager.readData('name');
  }

  Future<String> getUserEmail() async {
    return await StorageManager.readData('user');
  }

  login() async {
    User user = await firestoreService.loginUser(
        User(username: _username, email: _email, password: _password));

    print("regobj $user");
    if (user != null) {
      print("true");
      StorageManager.saveData('user', user.email);
      StorageManager.saveData('name', user.username);
      return true;
      // print()
    } else {
      return false;
    }
  }

  logout() {
    StorageManager.deleteData('user');
    StorageManager.deleteData('name');
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
