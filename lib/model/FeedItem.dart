class FeedItem {
  String title;
  String url;
  String imgUrl;

  FeedItem({this.title, this.url, this.imgUrl});

  Map<String, dynamic> toMap() {
    // print(title);
    return {'title': title, 'url': url, 'imgUrl': imgUrl};
  }

  FeedItem.fromFirestore(Map<String, dynamic> firestore) {
    print(firestore);
    title = firestore['title'] ?? 'N/A';
    url = firestore['url'] ?? 'N/A';
    imgUrl = firestore['imgUrl'] ?? 'N/A';
  }
}
