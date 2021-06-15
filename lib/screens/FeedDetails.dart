import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:intl/intl.dart';

class FeedDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var feedItem = ModalRoute.of(context).settings.arguments as RssItem;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("View Feeds"),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // Image.network(feedItem.media.),
            Html(
              data: feedItem.description != null ? feedItem.description : '',
            ),
            Html(
              data: feedItem.content != null ? feedItem.content.value : '',
            ),
          ],
        ),
      )),
    );
  }
}
