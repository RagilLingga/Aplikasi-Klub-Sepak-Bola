import 'dart:ui';

import 'package:easpab/SepakBola/inputdataklub.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InputKlub()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Color.fromARGB(255, 16, 190, 0),
                            padding: EdgeInsets.all(20),
                            elevation: 10,
                          ),
                          child: Text("Input Data Klub"),
                        ),
                        SizedBox(height: 30,),
                        Row(
children: [
  Text("Klub Liga 1 Indonesia", style: TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold
  ),
  ),
  Divider(thickness: 2,color: Colors.white,endIndent: 50,)
],
),

                        SizedBox(height: 40),
                        // First Card Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Image.network(
                                    'https://upload.wikimedia.org/wikipedia/id/thumb/a/a1/Persebaya_logo.svg/800px-Persebaya_logo.svg.png', // Replace with your image URL
                                    width: 130,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  
                                  
                                ],
                              ),
                            ),
                           Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Image.network(
                                    'https://upload.wikimedia.org/wikipedia/id/0/06/Logo_Arema_Malang.png', // Replace with your image URL
                                    width: 130,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Second Card Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                           Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Image.network(
                                    'https://upload.wikimedia.org/wikipedia/id/thumb/5/5e/Bali_United_logo.svg/1200px-Bali_United_logo.svg.png', // Replace with your image URL
                                    width: 130,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  
                                  
                                ],
                              ),
                            ),
                            Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Image.network(
                                    'https://upload.wikimedia.org/wikipedia/id/1/12/Logo_Persib.png', // Replace with your image URL
                                    width: 130,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                        // ... Add more card rows as needed
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}