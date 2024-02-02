
import 'dart:ui';

import 'package:easpab/SepakBola/inputdatasup.dart';
import 'package:flutter/material.dart';


class Suporter extends StatefulWidget {
  const Suporter({super.key});

  @override
  State<Suporter> createState() => _SuporterState();
}

class _SuporterState extends State<Suporter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.network(
            'https://images-cdn.ubuy.co.id/633b4eac1b8b61463b1e17da-aofoto-7x5ft-soccer-field-background.jpg', // Replace with your background image URL
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          // Blurred overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust the sigma values for the desired blur intensity
            child: Container(
              color: Colors.black.withOpacity(0.5), // Adjust the opacity as needed
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Container(
              child: Column(
                children: [
                   SizedBox(height: 20,),
                  Row(
                    children: [
                      SizedBox(width: 20,),
                      Text(
                        "Hello Admin,",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 100,),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: 20,),
                      Text(
                        "Apa Kabar Hari Ini?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Divider(thickness: 2, color: Color.fromARGB(255, 5, 146, 0),),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 100,),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InputSuporter()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                           onPrimary: Color.fromARGB(255, 16, 190, 0),
                            padding: EdgeInsets.all(20),
                            elevation: 10,
                          ),
                          child: Text("Input Data Suporter"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
