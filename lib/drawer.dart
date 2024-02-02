import 'package:easpab/home.dart';
import 'package:easpab/laporanklub.dart';
import 'package:easpab/laporansup.dart';
import 'package:easpab/login.dart';
import 'package:easpab/suporter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Drawerku extends StatefulWidget {
  const Drawerku({super.key});

  @override
  State<Drawerku> createState() => _DrawerkuState();
}

class _DrawerkuState extends State<Drawerku> {
  int selectedIndex = 0;

  // Define the logout function outside of the build method
  Future<void> logout() async {
    final url = Uri.parse('http://192.168.1.10/PhpnyaEas/Library/logout.php');

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        // Clear local data and navigate to the Login screen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        print('Failed to logout: ${response.statusCode}');
        // Handle logout failure
      }
    } catch (e) {
      print('Error during logout: $e');
      // Handle exceptions during logout
    }
  }

  

  void onTabTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 128, 0),
        title: Text(
          'FanField Connect',
          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      drawer:Drawer(
  child: Container(
    width: MediaQuery.of(context).size.width * 0.7, // Adjust the width as needed
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/9/9f/US_Navy_090606-N-5650M-004_Fire_Controlman_2nd_Class_Christopher_Sabens%2C_stationed_on_USS_Forrest_Sherman_%28DDG_98%29%2C_shoots_a_goal.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: 50,),
       Icon(Icons.account_circle_rounded, size: 100,),
        ListTileTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust padding here
          child: ListTile(
            title: Container(
              color: Colors.white.withOpacity(0.7),
              child: Text(
                'Klub',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              onTabTap(0);
            },
          ),
        ),
              ListTileTheme(
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust padding here
                child: ListTile(
                  title: Container(
                    color: Colors.white.withOpacity(0.7),
                    child: Text(
                      'Suporter',
                      style: TextStyle(color: Colors.black, fontSize: 24), 
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onTabTap(1);
                  },
                ),
              ),
              ListTileTheme(
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust padding here
                child: ListTile(
                  title: Container(
                    color: Colors.white.withOpacity(0.7),
                    child: Text(
                      'Laporan Klub',
                      style: TextStyle(color: Colors.black, fontSize: 24), 
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onTabTap(2);
                  },
                ),
              ),
              ListTileTheme(
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust padding here
                child: ListTile(
                  title: Container(
                    color: Colors.white.withOpacity(0.7),
                    child: Text(
                      'Laporan Suporter',
                      style: TextStyle(color: Colors.black, fontSize: 24), 
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onTabTap(3);
                  },
                ),
              ),
               SizedBox(height: 50,),
              ListTileTheme(
  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust padding here
  child: ElevatedButton(
    onPressed: () async {
      Navigator.pop(context);
      await logout();
    },
    style: ElevatedButton.styleFrom(
      primary: Colors.white
    ),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16), // Adjust padding here
      child: Text(
        'Logout',
        style: TextStyle(color: Colors.red),
      ),
    ),
  ),
),

            ],
          ),
        ),
      ),
      body: [
        Home(),
        Suporter(),
        LaporanKlub(),
        LaporanSuporter(),
      ][selectedIndex],
    );
  }
}