import 'dart:io';
import 'package:flutter_html/flutter_html.dart';
import 'package:glimpse_my_feeds/screens/FeedDetails.dart';
import 'package:glimpse_my_feeds/service/Feeds.dart';
import 'package:http/io_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart';

class ViewFeed extends StatelessWidget {
  const ViewFeed() : super();
  // rssRetrieve();
  @override
  Widget build(BuildContext context) {
    // print(feed);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Neth News',
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.playlist_play),
              tooltip: 'Air it',
              onPressed: () {},
            ),
          ],
          leading: IconButton(
            icon: new Icon(Icons.playlist_play),
            tooltip: 'Air it',
            onPressed: () => {},
          ),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: height * 0.20,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXajHXhi_4rg6XYR1-y88bhW9YIJV4ZYmuzQ&usqp=CAU',
                  height: 200,
                  width: width - 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: (height * 0.8) - (kToolbarHeight + 24),
              child: FutureBuilder<RssFeed>(
                future: Feeds().getFeed(),
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

                                  subtitle: snapshot
                                              .data.items[index].pubDate !=
                                          null
                                      ? Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 4, 0, 0),
                                          child: Row(
                                            children: <Widget>[
                                              Icon(Icons.access_time,
                                                  size: 17,
                                                  color: Colors.blueAccent),
                                              Text(
                                                  DateFormat(
                                                          ' yyyy-MM-dd – kk:mm')
                                                      .format(snapshot
                                                          .data
                                                          .items[index]
                                                          .pubDate),
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
                    return Text('awaiting the future');
                  }
                },
              ),
            ),
          ],
        ));
  }

//   rssRetrieve()  {

//   }
// }
}
