import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LaporanKlub extends StatefulWidget {
  const LaporanKlub({Key? key}) : super(key: key);

  @override
  State<LaporanKlub> createState() => _LaporanKlubState();
}

class _LaporanKlubState extends State<LaporanKlub> {
 

  Future<List<DataKlub>> fetchKlubData() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.10/PhpnyaEas/Library/readDataKlub.php'));
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      List<DataKlub> klubList =
          jsonResponse.map((data) => DataKlub.fromJson(data)).toList();
      return klubList;
    } else {
      throw Exception('Failed to load Klub data');
    }
  }


Future<void> deleteDataKlub(String id_klub) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.10/PhpnyaEas/Library/deleteDataKlub.php'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {'id_klub': id_klub},
  );

  if (response.statusCode == 200) {
    print('Klub data deleted successfully');
  } else {
    print('Failed to delete Klub data');
  }
}


Future<void> updateDataKlub(
  String id_klub,
  String nama_klub,
  String tgl_berdiri,
  String kota_klub,
  String kondisi_klub,
  String peringkat,
  String harga_klub,
) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.10/PhpnyaEas/Library/updateDataKlub.php'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {
      'id_klub': id_klub,
      'nama_klub': nama_klub,
      'tgl_berdiri': tgl_berdiri,
      'kota_klub': kota_klub,
      'kondisi_klub': kondisi_klub,
      'peringkat': peringkat,
      'harga_klub': harga_klub,
    },
  );

  if (response.statusCode == 200) {
    print('Klub data updated successfully');
  } else {
    print('Failed to update Klub data');
  }
}



  Future<void> _showUpdateKlubDialog(DataKlub dataKlub) async {
    TextEditingController _nama_klubController = TextEditingController();
    TextEditingController _id_klubController = TextEditingController();
    TextEditingController _tgl_berdiriController = TextEditingController();
    TextEditingController _kota_klubController = TextEditingController();
    TextEditingController _kondisi_klubController = TextEditingController();
    TextEditingController _peringkatController = TextEditingController();
     TextEditingController _harga_klubController = TextEditingController();

    _nama_klubController.text = dataKlub.nama_klub;
    _id_klubController.text = dataKlub.id_klub;
    _tgl_berdiriController.text = dataKlub.tgl_berdiri;
     _kota_klubController.text = dataKlub.kota_klub;
    _kondisi_klubController.text = dataKlub.kondisi_klub;
    _peringkatController.text = dataKlub.peringkat;
     _harga_klubController.text = dataKlub.harga_klub;

    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Klub Data'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nama_klubController,
              decoration: InputDecoration(labelText: 'Nama Klub'),
            ),
            TextField(
              controller: _id_klubController,
              decoration: InputDecoration(labelText: 'ID Klub'),
            ),
            TextField(
              controller: _tgl_berdiriController,
              decoration: InputDecoration(labelText: 'Tanggal Berdiri'),
            ),
           
              TextField(
              controller: _kota_klubController,
              decoration: InputDecoration(labelText: 'Kota Klub'),
            ),
            TextField(
              controller: _kondisi_klubController,
              decoration: InputDecoration(labelText: 'Kondisi Klub'),
            ),
            TextField(
              controller: _peringkatController,
              decoration: InputDecoration(labelText: 'peringkat'),
            ),
             TextField(
              controller: _harga_klubController,
              decoration: InputDecoration(labelText: 'Harga Klub'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await updateDataKlub(
                _id_klubController.text,
                _nama_klubController.text,
                _tgl_berdiriController.text,
                _kota_klubController.text,
                _kondisi_klubController.text,
                _peringkatController.text,
                _harga_klubController.text
              );

              Navigator.of(context).pop(); // Close the update dialog

              // Show a success dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Success'),
                    content: Text('Klub data updated successfully'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the success dialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Update'),
          ),
         TextButton(
      onPressed: () async {
        // Show confirmation dialog before deleting
        bool deleteConfirmed = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmation'),
              content: Text('Are you sure you want to delete this data?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // No, do not delete
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Yes, delete
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );

        if (deleteConfirmed == true) {
          await deleteDataKlub(dataKlub.id_klub);
          Navigator.of(context).pop(); // Close the update dialog

          // Show a success dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Klub data deleted successfully'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the success dialog
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Text('Delete'),
    ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the update dialog
            },
            child: Text('Cancel'),
          ),
        ],
      );
      },
    );
  }

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
                  SizedBox(height: 50),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "LAPORAN KLUB",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                Divider(thickness: 2, color: Color.fromARGB(255, 5, 146, 0),),
                  SizedBox(height: 30),
                 
                  Row(
                    children: [
                      Text(
                        "Data tabel dari Klub",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Divider(thickness: 2, color: Colors.white, endIndent: 50),
                    ],
                  ),
                  SizedBox(height: 30),
                  FutureBuilder<List<DataKlub>>(
                    future: fetchKlubData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor:
                                MaterialStateColor.resolveWith((states) => Colors.white),
                            columns: [
                              DataColumn(label: Text('Nama Klub')),
                              DataColumn(label: Text('ID Klub')),
                              DataColumn(label: Text('Tanggal Berdiri')),
                              DataColumn(label: Text('kota_klub')),
                              DataColumn(label: Text('kondisi_klub')),
                              DataColumn(label: Text('peringkat')),
                              DataColumn(label: Text('Harga Klub')),
                              DataColumn(label: Text('Actions')), // New column for actions
                            ],
                            dataRowColor:
                                MaterialStateColor.resolveWith((states) => Colors.white),
                            rows: snapshot.data!
                                .map(
                                  (klub) => DataRow(
                                    cells: [
                                      DataCell(Text(klub.nama_klub)),
                                      DataCell(Text(klub.id_klub)),
                                      DataCell(Text(klub.tgl_berdiri)),
                                      DataCell(Text(klub.kota_klub)),
                                      DataCell(Text(klub.kondisi_klub)),
                                      DataCell(Text(klub.peringkat)),
                                      DataCell(Text(klub.harga_klub)),
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            _showUpdateKlubDialog(klub);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      }
                    },
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


class DataKlub {
  String nama_klub;
  String id_klub;
  String tgl_berdiri;
  String kota_klub;
  String kondisi_klub;
  String peringkat;
  String harga_klub;

  DataKlub({
    required this.nama_klub,
    required this.id_klub,
    required this.tgl_berdiri,
    required this.kota_klub,
    required this.kondisi_klub,
    required this.peringkat,
     required this.harga_klub,
  });

  factory DataKlub.fromJson(Map<String, dynamic> json) {
  return DataKlub(
    nama_klub: json['nama_klub'] ?? '', // Menambahkan default value atau memeriksa null
    id_klub: json['id_klub'] ?? '',
    tgl_berdiri: json['tgl_berdiri'] ?? '',
    kota_klub: json['kota_klub'] ?? '',
    kondisi_klub: json['kondisi_klub'] ?? '',
    peringkat: json['peringkat'] ?? '',
    harga_klub: json['harga_klub'] ?? '',
  );
}
}

