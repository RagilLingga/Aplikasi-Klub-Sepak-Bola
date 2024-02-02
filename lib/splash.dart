import 'dart:async';
import 'package:easpab/drawer.dart';
import 'package:easpab/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
 @override
  void initState() {
    super.initState();
    bool isLoggedIn = checkIfUserIsLoggedIn();
    print('isLoggedIn: $isLoggedIn');

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn ?  Drawerku() : Login(),
        ),
      );
    });
  }

  bool checkIfUserIsLoggedIn() {
    return true; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 128, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logoapk.png', // Replace with your actual image asset
              width: 400,
              height: 400,
            ),
          ],
        ),
      ),
    );
  }
}