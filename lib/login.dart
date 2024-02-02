import 'dart:convert';
import 'dart:ui';

import 'package:easpab/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String apiUrl = "http://192.168.1.10/PhpnyaEas/Library/login.php";

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "username": _usernameController.text,
        "password": _passwordController.text,
      },
    );

    final result = jsonDecode(response.body);

    if (result["status"] == "success") {
      // Login berhasil, tampilkan pop-up dan navigasi ke MainScreen
      _showSuccessDialog(context);
    } else {
      // Login gagal, tampilkan pesan kesalahan
      _showErrorDialog(context);
      // Tambahkan kode lain sesuai kebutuhan
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Berhasil"),
          content: Text("Selamat, login Anda berhasil!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Drawerku(),
                  ),
                );
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Gagal"),
          content: Text("Username atau password yang Anda masukkan salah."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Dulu Yuk!"),
        backgroundColor: Color.fromARGB(255, 4, 128, 0),
      ),
      body: Stack(
        children: [
          // Background image
          Image.network(
            'https://awsimages.detik.net.id/community/media/visual/2021/09/08/ilustrasi-bola_169.jpeg?w=1200', // Replace with your background image URL
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          // Blurred overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust the sigma values for the desired blur intensity
            child: Container(
              color: Colors.white.withOpacity(0.5), // Adjust the opacity as needed
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(labelText: "Username", labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Password",  labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                      ),
                      SizedBox(height: 40),
                     ElevatedButton(
  onPressed: () => _login(context),
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
    textStyle: TextStyle(fontSize: 20),
    backgroundColor: Color.fromARGB(255, 4, 128, 0), // Ganti dengan warna yang diinginkan
  ),
  child: Text("Gas!"),
),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
