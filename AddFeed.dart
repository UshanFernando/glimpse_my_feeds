import 'package:flutter/material.dart';

class AddFeed extends StatefulWidget {
  @override
  _AddFeedState createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Favorite Feed'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
                height: 45,
                margin: EdgeInsets.only(
                    top: 10.0, left: 20.0, bottom: 10.0, right: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter your First name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                )),
            Container(
                height: 45,
                margin: EdgeInsets.only(
                    top: 10.0, left: 20.0, bottom: 10.0, right: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Second Name',
                      hintText: 'Enter your second name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                )),
            Container(
                height: 45,
                margin: EdgeInsets.only(
                    top: 10.0, left: 20.0, bottom: 10.0, right: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Enter your Last name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                )),
            getImageAsset(),
          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {
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
          SizedBox(
            child: img,
          ),
          Positioned(
            bottom: -10,
            right: -50,
            child: RawMaterialButton(
              onPressed: () {},
              elevation: 2.0,
              fillColor: Colors.white,
              child: Icon(
                Icons.edit,
                size: 25.0,
              ),
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
            ),
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}
