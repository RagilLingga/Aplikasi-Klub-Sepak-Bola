import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LaporanSuporter extends StatefulWidget {
  const LaporanSuporter({Key? key}) : super(key: key);

  @override
  State<LaporanSuporter> createState() => _LaporanSuporterState();
}

class _LaporanSuporterState extends State<LaporanSuporter> {
  Future<List<DataSuporter>> fetchSuporterData() async {
    final response = await http.get(Uri.parse('http://192.168.1.10/PhpnyaEas/Library/readDataSup.php'));
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      List<DataSuporter> suporterList =
          jsonResponse.map((data) => DataSuporter.fromJson(data)).toList();
      return suporterList;
    } else {
      throw Exception('Failed to load Suporter data');
    }
  }


  Future<void> deleteDataSuporter(String id_suporter) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.10/PhpnyaEas/Library/deleteDataSup.php'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {'id_suporter': id_suporter},
  );

  if (response.statusCode == 200) {
    print('Suporter data deleted successfully');
  } else {
    print('Failed to delete Suporter data');
  }
}


 Future<void> updateDataSuporter(
  String id_suporter,
  String nama,
  String tanggalDaftar,
  String alamat,
  String noTlp,
) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.10/PhpnyaEas/Library/updateDataSup.php'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {
      'id_suporter': id_suporter,
      'nama': nama,
      'tgl_daftar': tanggalDaftar,
      'alamat': alamat,
      'no_tlp' : noTlp,
    },
  );

  if (response.statusCode == 200) {
    print('Suporter data updated successfully');
  } else {
    print('Failed to update Suporter data. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}





  Future<void> _showUpdateSuporterDialog(DataSuporter dataSuporter) async {
    TextEditingController _namaController = TextEditingController();
    TextEditingController _id_suporterController = TextEditingController();
    TextEditingController _tanggalDaftarController = TextEditingController();
    TextEditingController _alamatController = TextEditingController();
    TextEditingController _noTlpController = TextEditingController();


    _namaController.text = dataSuporter.nama;
    _id_suporterController.text = dataSuporter.id_suporter;
    _tanggalDaftarController.text = dataSuporter.tanggalDaftar;
    _alamatController.text = dataSuporter.alamat;
     _noTlpController.text = dataSuporter.noTlp;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Suporter Data'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: _id_suporterController,
                decoration: InputDecoration(labelText: 'Id Suporter'),
              ),
              TextField(
                controller: _tanggalDaftarController,
                decoration: InputDecoration(labelText: 'Tanggal Daftar'),
              ),
  
              TextField(
                controller: _alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
              ),
                TextField(
                controller: _noTlpController,
                decoration: InputDecoration(labelText: 'No Telepon'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                updateDataSuporter(
                  _id_suporterController.text,
                  _namaController.text,
                  _tanggalDaftarController.text,
                  _alamatController.text,
                  _noTlpController.text,
                );
                Navigator.of(context).pop();
                 showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Success'),
                    content: Text('Suporter data updated successfully'),
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
          await deleteDataSuporter(dataSuporter.id_suporter);
          Navigator.of(context).pop(); // Close the update dialog

          // Show a success dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Suporter data deleted successfully'),
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
              Navigator.of(context).pop();
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
                    children: [
                      SizedBox(width: 15),
                      Text(
                        "LAPORAN SUPORTER",
                         style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
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
                        "Data tabel dari Suporter",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Divider(thickness: 2, color: Colors.white, endIndent: 50),
                    ],
                  ),
                  SizedBox(height: 30),
                  FutureBuilder<List<DataSuporter>>(
                    future: fetchSuporterData(),
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
                              DataColumn(label: Text('Nama')),
                              DataColumn(label: Text('id_suporter')),
                              DataColumn(label: Text('Tanggal Daftar')),
                              DataColumn(label: Text('Alamat')),
                              DataColumn(label: Text('No Telepon')),
                              DataColumn(label: Text('Actions')), // New column for actions
                            ],
                            dataRowColor:
                                MaterialStateColor.resolveWith((states) => Colors.white),
                            rows: snapshot.data!
                                .map(
                                  (suporter) => DataRow(
                                    cells: [
                                      DataCell(Text(suporter.nama)),
                                      DataCell(Text(suporter.id_suporter)),
                                      DataCell(Text(suporter.tanggalDaftar)),
                                      DataCell(Text(suporter.alamat)),
                                      DataCell(Text(suporter.noTlp)),
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            _showUpdateSuporterDialog(suporter);
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


class DataSuporter{
  String nama;
  String id_suporter;
  String tanggalDaftar;
  String alamat;
  String noTlp;

  DataSuporter({
    required this.nama,
    required this.id_suporter,
    required this.tanggalDaftar,
    required this.alamat,
       required this.noTlp,
  });

 factory DataSuporter.fromJson(Map<String, dynamic> json) {
  return DataSuporter(
    nama: json['nama'] ?? '', // Provide a default value if 'nama' is null
    id_suporter: json['id_suporter'] ?? '',
    tanggalDaftar: json['tgl_daftar'] ?? '',
    alamat: json['alamat'] ?? '',
    noTlp: json['no_tlp'] ?? '',
  );
}

}