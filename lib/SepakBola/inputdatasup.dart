import 'dart:convert';
import 'dart:io';
import 'package:easpab/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class InputSuporter extends StatefulWidget {
  const InputSuporter({Key? key}) : super(key: key);

  @override
  State<InputSuporter> createState() => _InputSuporterState();
}

class _InputSuporterState extends State<InputSuporter> {
  var namaController = TextEditingController();
  var idSuporterController = TextEditingController();
  var tglDaftarController = TextEditingController();
  var alamatController = TextEditingController();
  var noTlpController = TextEditingController();
  DateTime? selectedDate;
  final picker = ImagePicker();
  File? _image;

  Future<void> insertData() async {
    if (namaController.text.isNotEmpty &&
        idSuporterController.text.isNotEmpty &&
        tglDaftarController.text.isNotEmpty &&
        alamatController.text.isNotEmpty &&
        noTlpController.text.isNotEmpty &&
        _image != null) {
      try {
        String uri = "http://192.168.1.10/PhpnyaEas/Library/insertDataSup.php";
        var request = http.MultipartRequest('POST', Uri.parse(uri));
        request.fields.addAll({
          "nama": namaController.text,
          "id_suporter": idSuporterController.text,
          "tgl_daftar": tglDaftarController.text,
          "alamat": alamatController.text,
          "no_tlp": noTlpController.text,
        });

        var stream = http.ByteStream(_image!.openRead());
        var length = await _image!.length();
        var multipartFile = http.MultipartFile('foto', stream, length,
            filename: 'suporter_image.jpg');
        request.files.add(multipartFile);

        var response = await request.send();
        var responseData = await response.stream.toBytes();
        var responseString = utf8.decode(responseData);

        var parsedResponse = jsonDecode(responseString);

        if (parsedResponse["success"] == true) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("Data inserted successfully!"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Failed to insert data."),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill in all fields."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        tglDaftarController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 50,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
            Center(
              child: Text(
                "Input Data Suporter",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.shade200,
                      spreadRadius: 3,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: namaController,
                        decoration: InputDecoration(labelText: 'Nama'),
                      ),
                      TextField(
                        controller: idSuporterController,
                        decoration: InputDecoration(labelText: 'ID Suporter'),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: tglDaftarController,
                            decoration:
                                InputDecoration(labelText: 'Tanggal Daftar'),
                          ),
                        ),
                      ),
                      TextField(
                        controller: alamatController,
                        decoration: InputDecoration(labelText: 'Alamat'),
                      ),
                      TextField(
                        controller: noTlpController,
                        decoration: InputDecoration(labelText: 'No. Telepon'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _image != null
                          ? Image.file(
                              _image!,
                              height: 100,
                              width: 100,
                            )
                          : Container(),
                     ElevatedButton(
                            onPressed: () {
                              _getImage();
                            },
                            child: Text(
                              'Ambil Gambar!',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 255, 0, 0),
                              minimumSize: Size(100, 45),
                            ),
                          ),
                                                SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Drawerku(),
                                ),
                              );
                              insertData();
                            },
                            child: Text(
                              'Kirim Data!',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 4, 128, 0),
                              minimumSize: Size(100, 45),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
