import 'package:glimpse_my_feeds/model/FeedItem.dart';
import 'package:glimpse_my_feeds/model/FeedItem.dart';

class User {
  String id;
  String username;
  String email;
  // FeedItem[] feedItems;
  String password;

  User({this.username, this.email, this.password});

  Map<String, dynamic> toMap() {
    // print(title);
    return {'username': username, 'email': email, 'password': password};
  }

  User.fromFirestore(Map<String, dynamic> firestore) {
    username = firestore['userame'] ?? 'N/A';
    email = firestore['email'] ?? 'N/A';
    password = firestore['password'] ?? 'N/A';
  }
}
