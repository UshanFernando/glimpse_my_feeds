import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:glimpse_my_feeds/model/FeedItem.dart';
import 'package:glimpse_my_feeds/providers/FeedProvider.dart';
import 'package:glimpse_my_feeds/providers/RegistrationProvider.dart';
import 'package:glimpse_my_feeds/screens/Home.dart';
import 'package:glimpse_my_feeds/providers/ThemeProvider.dart';
import 'package:glimpse_my_feeds/service/DBService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddFeed extends StatefulWidget {
  @override
  _AddFeedState createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
  File _image;
  final picker = ImagePicker();

  Future chooseFile() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  Widget getImageAsset(height, ThemeData theme) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
      child: Stack(
        children: <Widget>[
          Container(
            child: Text(
              'Selected Image',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: theme.textTheme.bodyText1.color),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
            child: SizedBox(
              height: height * 0.3,
              child: Center(
                child: ElevatedButton(
                  onPressed: () => chooseFile(),
                  child: Text('Upload'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(theme.accentColor)),
                ),
              ),
            ),
          ),
          SizedBox(height: height * .005),
          Container(
            margin: EdgeInsets.only(top: 35.0, bottom: 5.0),
            child: Stack(children: <Widget>[
              Flexible(
                  child: _image != null
                      ? Image.file(
                          _image,
                          height: height * 0.3,
                        )
                      : Text("")),
              _image != null
                  ? Positioned(
                      bottom: 15,
                      right: 0,
                      child: RawMaterialButton(
                        onPressed: () => chooseFile(),
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.edit,
                          size: 25.0,
                        ),
                        padding: EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      ),
                    )
                  : Container(height: 150),
            ]),
          ),
        ],
      ),
    );
  }

  var nameText = TextEditingController();
  var urlText = TextEditingController();
  String title = '';
  String url = '';
  bool first = true;
  @override
  Widget build(BuildContext context) {
    var feedItem = ModalRoute.of(context).settings.arguments as FeedItem;
    final height = MediaQuery.of(context).size.height;

    final feedProvider = Provider.of<FeedProvider>(context, listen: true);
    final registrationProvider =
        Provider.of<RegistrationProvider>(context, listen: true);
    if (feedItem != null && first) {
      nameText.text = feedItem.title;
      urlText.text = feedItem.url;
      first = false;
    }

    Future uploadImageToFirebase() async {
      String fileName = basename(_image.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_image);
      TaskSnapshot taskSnapshot = await uploadTask;

      taskSnapshot.ref.getDownloadURL().then((value) async {
        await feedProvider.changeimgUrl(value);
      });
    }

    Widget _submitButton(ThemeData theme) {
      return InkWell(
        onTap: () async {
          await uploadImageToFirebase()
              .then((value) => feedProvider.saveToDbFeed())
              .then((value) => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home())));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: theme.dividerColor,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: Text(
            'Save',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    }

    Widget _updateButton(ThemeData theme, FeedItem feed, String email) {
      return InkWell(
        onTap: () async {
          feed.title = title;
          feed.url = url;
          print(feed);
          DBService().updateFeed(feed, email).then((value) =>
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home())));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: theme.dividerColor,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: Text(
            'Update',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    }

    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => Scaffold(
            backgroundColor: theme.getTheme.backgroundColor,
            appBar: AppBar(
              title: Text(
                feedItem == null ? 'Add Your Favorite Feed' : 'Update Feed',
              ),
              backgroundColor: theme.getTheme.accentColor,
            ),
            body: FutureBuilder<String>(
                future: registrationProvider.getUserEmail(),
                builder: (context, snapshot) {
                  return Container(
                    child: ListView(children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: theme.getTheme.textTheme
                                              .bodyText1.color),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                        onChanged: (value) => {
                                              title = value,
                                              feedProvider.changeTitle(value)
                                            },
                                        obscureText: false,
                                        controller: nameText,
                                        decoration: InputDecoration(
                                            hintText: "Enter your Feed's Name",
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true))
                                  ],
                                ),
                              ),
                              SizedBox(height: height * .005),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "URL",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: theme.getTheme.textTheme
                                              .bodyText1.color),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                        controller: urlText,
                                        onChanged: (value) => {
                                              url = value,
                                              feedProvider.changeUrl(value),
                                            },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                            hintText:
                                                "Enter your RSS Feed's URL",
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true))
                                  ],
                                ),
                              ),
                              SizedBox(height: height * .005),
                              getImageAsset(height, theme.getTheme),
                              feedItem == null
                                  ? _submitButton(theme.getTheme)
                                  : _updateButton(
                                      theme.getTheme, feedItem, snapshot.data),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  );
                })));
  }
}
