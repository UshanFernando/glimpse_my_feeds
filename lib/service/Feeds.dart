import 'dart:io';

import 'package:http/io_client.dart';
import 'package:webfeed/webfeed.dart';

class Feeds {
  Future<RssFeed> getFeed() async {
    final client = IOClient(HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true));

    // RSS feed
    var response =
        await client.get(Uri.parse('https://www.unilever.com/feeds/news.rss'));
    var channel = RssFeed.parse(response.body);

    client.close();

    return channel;
  }
}
