import 'dart:convert';
import 'package:easpab/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class InputKlub extends StatefulWidget {
  const InputKlub({Key? key}) : super(key: key);

  @override
  State<InputKlub> createState() => _InputKlubState();
}

class _InputKlubState extends State<InputKlub> {
  // Controllers for text fields
  var namaKlub = TextEditingController();
  var idKlub = TextEditingController();
  var kotaKlub = TextEditingController();
  var hargaKlub = TextEditingController();
  // Date picker variables
  DateTime? selectedDate;

  

  // Radio button variable
  String? selectedKondisi;

  // Checkbox variable
  String? selectedJenis;

  // Date picker method
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
      });
    }
  }

  // Insert data method
  InsertData() async {
    if (namaKlub.text.isNotEmpty &&
        idKlub.text.isNotEmpty &&
        kotaKlub.text.isNotEmpty &&
       hargaKlub.text.isNotEmpty &&
        selectedDate != null &&
        selectedKondisi != null &&
        selectedJenis != null) {
      try {
        String uri = "http://192.168.1.10/PhpnyaEas/Library/insertDataKlub.php";
        var res = await http.post(Uri.parse(uri), headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        }, body: {
          "nama_klub": namaKlub.text,
          "id_klub": idKlub.text,
          "tgl_berdiri": selectedDate!.toLocal().toString().split(' ')[0],
          "kota_klub": kotaKlub.text,
          "kondisi_klub": selectedKondisi!,
          "peringkat": selectedJenis!,
          "harga_klub": hargaKlub.text,
        });

        var response = jsonDecode(res.body);

        if (response["success"] == "true") {
          print("Success");
        } else {
          print("Some Issues");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('Mohon ISI');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0xfff2B2D3D),
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
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            Center(
              child: Text(
                "Input Data Klub",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
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
                      TextFormField(
                        controller: namaKlub,
                        decoration: InputDecoration(
                          hintText: "Nama Klub",
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: idKlub,
                        decoration: InputDecoration(
                          hintText: "ID Klub",
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tanggal Berdiri :",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 12,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.blueGrey.shade500,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                  onPressed: () => _selectDate(context),
                                  child: Text("Pilih Tanggal"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        selectedDate == null
                            ? "No Date Selected"
                            : "${selectedDate!.toLocal()}"
                                .split(' ')[0],
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black38,
                      ),
                       TextFormField(
                        controller: kotaKlub,
                        decoration: InputDecoration(
                          hintText: "Kota Klub",
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                          ),
                        ),
                      ),
                     
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Kondisi Klub",
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                "Baik",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              leading: Radio(
                                value: "Baik",
                                groupValue: selectedKondisi,
                                onChanged: (value) {
                                  setState(() {
                                    selectedKondisi = value as String?;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                "Tidak Baik",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              leading: Radio(
                                value: "Tidak Baik",
                                groupValue: selectedKondisi,
                                onChanged: (value) {
                                  setState(() {
                                    selectedKondisi = value as String?;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                "Bangkrut",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              leading: Radio(
                                value: "Bangkrut",
                                groupValue: selectedKondisi,
                                onChanged: (value) {
                                  setState(() {
                                    selectedKondisi = value as String?;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "Peringkat:",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                              ),
                            ),
                            CheckboxListTile(
                              title: const Text(
                                "1-3",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              value: selectedJenis == "1-3",
                              onChanged: (value) {
                                setState(() {
                                  selectedJenis = value! ? "1-3" : null;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: const Text(
                                "4-6",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              value: selectedJenis == "4-6",
                              onChanged: (value) {
                                setState(() {
                                  selectedJenis = value! ? "4-6" : null;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: const Text(
                                "7-15",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              value: selectedJenis == "7-15",
                              onChanged: (value) {
                                setState(() {
                                  selectedJenis = value! ? "7-15" : null;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: const Text(
                                "16-18",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              value: selectedJenis == "16-18",
                              onChanged: (value) {
                                setState(() {
                                  selectedJenis = value! ? "16-18" : null;
                                });
                              },
                            ),
                            
                             TextFormField(
                        controller: hargaKlub,
                        decoration: InputDecoration(
                          hintText: "Harga Klub :",
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                          ),
                        ),
                      ),
                          ],
                        ),
                      ),
                      Row(
                       
                        children: [
                          
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Drawerku()));
                              InsertData();
                            },
                            child: Text(
                              'Kirim Data!',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 4, 128, 0),
                              minimumSize: Size(150, 45),
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
