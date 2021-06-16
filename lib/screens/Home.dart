import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glimpse_my_feeds/model/FeedItem.dart';
import 'package:glimpse_my_feeds/providers/ThemeProvider.dart';
import 'package:glimpse_my_feeds/screens/ViewFeed.dart';
import 'package:glimpse_my_feeds/service/DBService.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final dbservice = DBService();

  final databaseReference = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var feeds = Provider.of<List<FeedItem>>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // print(feeds);
    // var items = dbservice.getFeeds();
    // items.map((event) => print(event.toString()));
    // dbservice.saveFeed(new FeedItem(
    //     title: "Neth NEWS", url: 'HRR[AFKSALA', imgUrl: 'DFSFSDFSFDS'));

    void handleClick(String value, ThemeNotifier theme) {
      switch (value) {
        case 'Logout':
          break;
        case 'Toggle Theme':
          theme.toggleTheme();
          break;
      }
    }

    print(feeds);
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => Scaffold(
            backgroundColor: theme.getTheme.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: theme.getTheme.backgroundColor,
              title: Text(
                'Hello Ushan!',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: theme.getTheme.textTheme.bodyText1.color),
              ),
              actions: [
                new IconButton(
                  icon: new Icon(Icons.add,
                      color: theme.getTheme.textTheme.bodyText1.color),
                  tooltip: 'Add New',
                  onPressed: () {},
                ),
                PopupMenuButton<String>(
                  color: theme.getTheme.backgroundColor,
                  icon: Icon(Icons.more_vert,
                      color: theme.getTheme.textTheme.bodyText1.color),
                  onSelected: (value) => {handleClick(value, theme)},
                  itemBuilder: (BuildContext context) {
                    return {'Toggle Theme', 'Logout'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(
                          choice,
                          style: TextStyle(
                              color: theme.getTheme.textTheme.bodyText1.color),
                        ),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(17, 0, 10, 8),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Here Is Your Favourite Feeds, ',
                    style: TextStyle(
                        fontFamily: 'open sans',
                        color: theme.getTheme.textTheme.bodyText1.color,
                        fontSize: 16),
                  ),
                ),
                Expanded(
                  // height: height - 110,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.17, crossAxisCount: 2),
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, index) => Column(children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewFeed(),
                              settings: RouteSettings(
                                arguments: feeds[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 174,
                          child: Card(
                            color: theme.getTheme.secondaryHeaderColor,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 8,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 110,
                                  width: width * 0.45,
                                  child: Image.network(
                                    feeds[index].imgUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  feeds[index].title,
                                  style: TextStyle(
                                      color: theme
                                          .getTheme.textTheme.bodyText1.color),
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ]),
                    itemCount: feeds.length,
                  ),
                ),
              ],
            )));
  }
}
