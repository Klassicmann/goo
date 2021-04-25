import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goo/screens/list.dart';
import 'package:goo/screens/introduction.dart';

import 'package:goo/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FlashPage extends StatefulWidget {
  @override
  _FlashPageState createState() => _FlashPageState();
}

class _FlashPageState extends State<FlashPage> {

  User _user = FirebaseAuth.instance.currentUser;
  int initScreen;

  @override
  void initState() {

    Timer(Duration(seconds: 4), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      initScreen = prefs.getInt("initScreen");
      await prefs.setInt("initScreen", 1);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return initScreen == 0 || initScreen == null
            ? OnBoardingPage()
            : _user != null
                ? Lists()
                : Login();
      }));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),

        body: Stack(
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.red
                  //   ),
                  // ),
                  Center(
                    child: Image(
                      image: AssetImage('assets/images/Artboard 1xhdpi.png'),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                 
                ],
        )
            
    );
  
  }
}
