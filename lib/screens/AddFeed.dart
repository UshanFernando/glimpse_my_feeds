import 'dart:io';
import 'package:flutter/material.dart';
import 'package:glimpse_my_feeds/providers/FeedProvider.dart';
import 'package:glimpse_my_feeds/screens/Home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddFeed extends StatefulWidget {
  @override
  _AddFeedState createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
  Widget _entryField(String title,
      {bool isPassword = false, String hint = ""}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  File _image;
  final picker = ImagePicker();

  Future chooseFile() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    final feed = Provider.of<FeedProvider>(context, listen: false);
    String fileName = basename(_image.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    TaskSnapshot taskSnapshot = await uploadTask;

    taskSnapshot.ref.getDownloadURL().then((value) => {
          feed.changeimgUrl(value),

          // delProvider.changeButtonDisable(false),
          // Navigator.of(context).pop(),
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final feedProvider = Provider.of<FeedProvider>(context, listen: true);

    Widget _submitButton() {
      return InkWell(
        onTap: () async {
          await uploadImageToFirebase(context)
              .then((value) => feedProvider.saveToDbFeed())
              .then((value) => Navigator.push(
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
                    color: Colors.grey.shade200,
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Favorite Feed'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .005),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                              onChanged: (value) =>
                                  feedProvider.changeTitle(value),
                              obscureText: false,
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
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                              onChanged: (value) =>
                                  feedProvider.changeUrl(value),
                              obscureText: false,
                              decoration: InputDecoration(
                                  hintText: "Enter your RSS Feed's URL",
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true))
                        ],
                      ),
                    ),
                    SizedBox(height: height * .005),
                    getImageAsset(height),
                    _submitButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImageAsset(height) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
      child: Stack(
        children: <Widget>[
          Container(
            child: Text(
              'Selected Image',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
            child: SizedBox(
              height: height * 0.3,
              child: Center(
                child: ElevatedButton(
                    onPressed: () => chooseFile(), child: Text('Upload')),
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

          // _image != null
          //     ? RaisedButton(
          //         child: Text('Upload File'),
          //         onPressed: uploadFile,
          //         color: Colors.cyan,
          //       )
          //     : Container(),
          // _image != null
          //     ? RaisedButton(
          //         child: Text('Clear Selection'),
          //         onPressed: clearSelection,
          //       )
          //     : Container(),
          // Text('Uploaded Image'),
          // _uploadedFileURL != null
          //     ? Image.network(
          //         _uploadedFileURL,
          //         height: 150,
          //       )
          //     : Container(),
          // SizedBox(
          //   child: img,
          // ),
        ],
      ),
    );
  }
}
