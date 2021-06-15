class FeedItem {
  String id;
  String title;
  String url;
  String imgUrl;

  FeedItem({this.title, this.url, this.imgUrl});

  Map<String, dynamic> toMap() {
    // print(title);
    return {'title': title, 'url': url, 'imgUrl': imgUrl};
  }

  FeedItem.fromFirestore(Map<String, dynamic> firestore, String id) {
    this.id = id;
    title = firestore['title'] ?? 'N/A';
    url = firestore['url'] ?? 'N/A';
    imgUrl = firestore['imgUrl'] ?? 'N/A';
  }
}
