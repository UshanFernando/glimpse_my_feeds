import 'dart:io';
import 'package:flutter_html/flutter_html.dart';
import 'package:glimpse_my_feeds/model/FeedItem.dart';
import 'package:glimpse_my_feeds/providers/ThemeProvider.dart';
import 'package:glimpse_my_feeds/screens/FeedDetails.dart';
import 'package:glimpse_my_feeds/screens/Home.dart';
import 'package:glimpse_my_feeds/service/DBService.dart';
import 'package:glimpse_my_feeds/service/Feeds.dart';
import 'package:http/io_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart';

class ViewFeed extends StatelessWidget {
  const ViewFeed() : super();
  // rssRetrieve();
  @override
  Widget build(BuildContext context) {
    var feedItem = ModalRoute.of(context).settings.arguments as FeedItem;
    // print(feeds);
    // print(feed);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  expandedHeight: 250.0,
                  backgroundColor: theme.getTheme.accentColor,
                  floating: false,
                  pinned: true,
                  // title: Text("BBC News"),
                  actions: <Widget>[
                    IconButton(
                      icon: new Icon(Icons.edit),
                      tooltip: 'Edit',
                      onPressed: () => {},
                    ),
                    new IconButton(
                      icon: new Icon(Icons.delete),
                      tooltip: 'Delete',
                      onPressed: () {
                        DBService()
                            .deleteFeed(feedItem.id)
                            .then((value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                ));
                      },
                    ),
                  ],
                  leading: IconButton(
                    icon: new Icon(Icons.arrow_back),
                    tooltip: 'Go Back',
                    onPressed: () => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      )
                    },
                  ),
                  // title: Text("Coporate News"),
                  elevation: 8,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(feedItem.title),
                    background: Container(
                      height: 400,
                      child: Image.network(
                        feedItem.imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ))
            ];
          },
          body: FutureBuilder<RssFeed>(
            future: Feeds().getFeed(feedItem.url),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Card(
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              // leading: Container(
                              //   padding: EdgeInsets.only(right: 12.0),
                              //   decoration: new BoxDecoration(
                              //       border: new Border(
                              //           right: new BorderSide(
                              //               width: 1.0, color: Colors.white24))),
                              //   child:
                              //       Icon(Icons.autorenew, color: Colors.black87),
                              // ),
                              title: Text(
                                snapshot.data.items[index].title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                              subtitle: snapshot.data.items[index].pubDate !=
                                      null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 4, 0, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.access_time,
                                              size: 17,
                                              color: Colors.blueAccent),
                                          Text(
                                              DateFormat(' yyyy-MM-dd – kk:mm')
                                                  .format(snapshot.data
                                                      .items[index].pubDate),
                                              style: TextStyle(
                                                  color: Colors.black87))
                                        ],
                                      ),
                                    )
                                  : null,
                              trailing: Icon(Icons.keyboard_arrow_right,
                                  color: Colors.grey, size: 30.0)),
                        ),
                        onTap: () {
                          print(snapshot.data.items[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FeedDetails(),
                              settings: RouteSettings(
                                arguments: snapshot.data.items[index],
                              ),
                            ),
                          );
                        },
                      );
                    });
              } else {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Loading Data...',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.getTheme.textTheme.bodyText1.color),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'If This Take Longer than 1 minute,\n Please Check Your Feed URL!',
                      style: TextStyle(
                          fontSize: 18,
                          color: theme.getTheme.textTheme.bodyText1.color),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ));
              }
            },
          ),
        ),
      ),
    );
  }

//   rssRetrieve()  {

//   }
// }
}
