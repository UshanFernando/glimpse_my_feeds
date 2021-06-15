import 'dart:io';

import 'package:http/io_client.dart';
import 'package:webfeed/webfeed.dart';

class Feeds {
  Future<RssFeed> getFeed(String url) async {
    final client = IOClient(HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true));

    // RSS feed
    var response = await client.get(Uri.parse(url));
    var channel = RssFeed.parse(response.body);

    client.close();

    return channel;
  }
}
