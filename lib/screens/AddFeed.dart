import 'dart:io';
import 'package:flutter/material.dart';
import 'package:glimpse_my_feeds/providers/FeedProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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

//  Future uploadFile() async {
//    StorageReference storageReference = FirebaseStorage.instance
//        .ref()
//        .child('chats/${Path.basename(_image.path)}}');
//    StorageUploadTask uploadTask = storageReference.putFile(_image);
//    await uploadTask.onComplete;
//    print('File Uploaded');
//    storageReference.getDownloadURL().then((fileURL) {
//      setState(() {
//        _uploadedFileURL = fileURL;
//      });
//    });
//  }

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final feedProvider = Provider.of<FeedProvider>(context, listen: true);

    Widget _submitButton() {
      return InkWell(
        onTap: () => feedProvider.saveToDbFeed(),
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
    AssetImage assImg = AssetImage('images/qr.png');
    Image img = Image(
      image: assImg,
      width: 150.0,
      height: 150.0,
    );
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

          // _image == null
          //     ? RaisedButton(
          //         child: Text('Choose File'),
          //         onPressed: chooseFile,
          //         color: Colors.cyan,
          //       )
          //     : Container(),
          Container(
            margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
            child: SizedBox(
              height: height * 0.3,
              child: Center(
                child: ElevatedButton(
                    onPressed: () => chooseFile(), child: Text('Press me')),
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
