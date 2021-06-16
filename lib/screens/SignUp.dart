import 'package:flutter/material.dart';
import 'package:glimpse_my_feeds/model/User.dart';
import 'package:glimpse_my_feeds/providers/RegistrationProvider.dart';
import 'package:glimpse_my_feeds/providers/ThemeProvider.dart';
import 'package:glimpse_my_feeds/screens/LoginPage.dart';
import 'package:glimpse_my_feeds/screens/bezierContainer.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final registrationProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    Widget _title() {
      return SizedBox(
        child: Image.asset('images/logo.png'),
        height: height * 0.090,
      );
    }

    Widget _submitButton() {
      return InkWell(
        onTap: () {
          registrationProvider.saveToDbDelivery();
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
            'Register Now',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    }

    Widget _entryField(
      String title, {
      bool isPassword = false,
      bool isEmail = false,
      bool isUsername = false,
      String hint = "",
    }) {
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
                onChanged: (value) =>
                    registrationProvider.changePassword(value),
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

    Widget _emailPasswordWidget() {
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Username',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    onChanged: (value) =>
                        registrationProvider.changeUsername(value),
                    obscureText: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    onChanged: (value) =>
                        registrationProvider.changeEmail(value),
                    obscureText: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    onChanged: (value) =>
                        registrationProvider.changePassword(value),
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true))
              ],
            ),
          ),
        ],
      );
    }

    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => Scaffold(
                body: Container(
              height: height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: -height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer()),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: height * .2),
                          _title(),
                          SizedBox(height: 50),
                          _emailPasswordWidget(),
                          SizedBox(height: 20),
                          _submitButton(),
                          // Container(
                          //   padding: EdgeInsets.symmetric(vertical: 10),
                          //   alignment: Alignment.centerRight,
                          //   child: Text('Forgot Password ?',
                          //       style: TextStyle(
                          //           fontSize: 14, fontWeight: FontWeight.w500)),
                          // ),
                          SizedBox(height: height * .090),
                          _createAccountLabel(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(top: 40, left: 0, child: _backButton()),
                ],
              ),
            )));
  }
}
