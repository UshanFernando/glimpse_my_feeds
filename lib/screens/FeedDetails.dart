import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:glimpse_my_feeds/providers/ThemeProvider.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:intl/intl.dart';

class FeedDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var feedItem = ModalRoute.of(context).settings.arguments as RssItem;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => Scaffold(
              backgroundColor: theme.getTheme.backgroundColor,
              appBar: AppBar(
                backgroundColor: theme.getTheme.accentColor,
                title: Text(
                  feedItem.title,
                  textAlign: TextAlign.start,
                ),
              ),
              body: Container(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        feedItem.title,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: theme.getTheme.textTheme.bodyText1.color),
                      ),
                    ),
                    feedItem.itunes.image != null
                        ? Container(
                            margin: EdgeInsets.all(12),
                            child: Image.network(feedItem.itunes.image.href),
                            height: 300,
                          )
                        : SizedBox(),
                    Html(
                      data: (feedItem.description != null
                              ? feedItem.description
                              : '') +
                          (feedItem.content != null
                              ? feedItem.content.value
                              : ''),
                      style: {
                        "p": Style(
                          color: theme.getTheme.textTheme.bodyText1.color,
                        ),
                        "table": Style(
                          backgroundColor:
                              Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                        ),
                        "tr": Style(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey)),
                        ),
                        "th": Style(
                          padding: EdgeInsets.all(6),
                          backgroundColor: Colors.grey,
                        ),
                        "td": Style(
                          padding: EdgeInsets.all(6),
                          alignment: Alignment.topLeft,
                        ),
                        'h5': Style(
                            maxLines: 2, textOverflow: TextOverflow.ellipsis),
                      },
                      customRender: {
                        "table": (context, child) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: (context.tree as TableLayoutElement)
                                .toWidget(context),
                          );
                        },
                      },
                      customImageRenders: {
                        networkSourceMatcher(domains: ["flutter.dev"]):
                            (context, attributes, element) {
                          return FlutterLogo(size: 36);
                        },
                        networkSourceMatcher(domains: ["mydomain.com"]):
                            networkImageRender(
                          headers: {"Custom-Header": "some-value"},
                          altWidget: (alt) => Text(alt ?? ""),
                          loadingWidget: () => Text("Loading..."),
                        ),
                        // On relative paths starting with /wiki, prefix with a base url
                        (attr, _) =>
                                attr["src"] != null &&
                                attr["src"].startsWith("/wiki"):
                            networkImageRender(
                                mapUrl: (url) =>
                                    "https://upload.wikimedia.org" + url),
                        // Custom placeholder image for broken links
                        networkSourceMatcher():
                            networkImageRender(altWidget: (_) => FlutterLogo()),
                      },
                    ),
                  ],
                ),
              )),
            ));
  }
}
