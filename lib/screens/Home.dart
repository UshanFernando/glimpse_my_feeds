import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glimpse_my_feeds/model/FeedItem.dart';
import 'package:glimpse_my_feeds/service/DBService.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final dbservice = DBService();

  final databaseReference = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var feeds = Provider.of<List<FeedItem>>(context);
    // print(feeds);
    // var items = dbservice.getFeeds();
    // items.map((event) => print(event.toString()));
    // dbservice.saveFeed(new FeedItem(
    //     title: "Neth NEWS", url: 'HRR[AFKSALA', imgUrl: 'DFSFSDFSFDS'));

    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Column(children: [databaseReference.map((e) =>  Text(e.title))],)
    // );
  }
}
