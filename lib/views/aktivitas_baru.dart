import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_sekolah/helper/helper.dart';

class AktivitasBaru extends StatefulWidget {
  @override
  _AktivitasBaruState createState() => _AktivitasBaruState();
}

class _AktivitasBaruState extends State<AktivitasBaru> {
  Map<String, bool> sholat = {
    "subuh": false,
    "ashar": false,
    "dzuhur": false,
    "maghrib": false,
    "isya": false,
  };
  bool isLoading = false;
  String surat = "";

  void _simpan() async {
    List<String> _tmpSholat = [];
    sholat.keys.forEach((element) {
      if (sholat[element] == true) {
        _tmpSholat.add(element);
      }
    });
    print(_tmpSholat);
    setState(() {
      isLoading = true;
    });
    try {
      String url = "$HostAddress/aktivitas/store";
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString("token") ?? "";
      print(token);
      Map<String, dynamic> data = {"surat": surat, "sholat": _tmpSholat};
      final response = await Dio().post(
        url,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          },
        ),
      );
      Navigator.restorablePopAndPushNamed(context, "/aktivitas");
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   "/dashboard",
      //   ModalRoute.withName("/dashboard"),
      // );
      print(response.data);
    } on DioError catch (e) {
      print(e.response.data);
      Fluttertoast.showToast(
          msg: "Terjadi Kesalahan Pada Server...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Aktivitas Baru",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(2, 2))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text("Hafalan Surat"),
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        surat = text;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Hafalan"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Sholat Hari Ini"),
                      ),
                      Column(
                        children: sholat.keys.map((String key) {
                          return Container(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: sholat[key],
                                  onChanged: (value) {
                                    setState(() {
                                      sholat[key] = value as bool;
                                    });
                                  },
                                ),
                                Container(
                                  child: Text(
                                    key.toString().toUpperCase(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  _simpan();
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 14,
                                width: 14,
                                child: CircularProgressIndicator(
                                  // valueColor: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Sedang Menyimpan Aktivitas..",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          )
                        : Text(
                            "Simpan",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
