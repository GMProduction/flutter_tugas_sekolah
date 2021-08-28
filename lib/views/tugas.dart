import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_sekolah/component/bottom_navbar.dart';
import 'package:tugas_sekolah/component/card_pencarian_materi.dart';
import 'package:tugas_sekolah/helper/helper.dart';

class Tugas extends StatefulWidget {
  @override
  _TugasState createState() => _TugasState();
}

class _TugasState extends State<Tugas> {
  bool isLoading = true;
  List<dynamic> _listTugas = [];
  String param = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTugas(param);
  }

  void fetchTugas(String param) async {
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString("token") ?? "";
      final response = await Dio().get(
        '$HostAddress/tugas?nama=$param',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          },
        ),
      );
      print(response.data);
      setState(() {
        _listTugas = response.data;
      });
    } on DioError catch (e) {
      print(e.response!.data);
      Fluttertoast.showToast(
          msg: "Gagal Mengambil Data...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
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
                  "Tugas",
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.only(top: 10, bottom: 20),
              child: TextField(
                onSubmitted: (text) {
                  print(text);
                  fetchTugas(text);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Cari Tugas",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Hasil Pencarian"),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  fetchTugas(param);
                },
                child: isLoading
                    ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text("Sedang Mengunduh Data...")
                          ],
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: LayoutBuilder(
                          builder: (context, constraints) =>
                              SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: _listTugas.map((e) {
                                DateTime tanggal =
                                    DateTime.parse(e["created_at"].toString());
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/detail-tugas',
                                          arguments: e["id"].toString());
                                    },
                                    child: CardPencarianMateri(
                                      nama: e["nama"].toString(),
                                      deskripsi: e["deskripsi"].toString(),
                                      buttonText: "Kerjakan Tugas",
                                      tanggal:
                                          "${tanggal.day.toString().padLeft(2, "0")}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.year.toString()}",
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            BottomNavbar(
              selected: 2,
            )
          ],
        ),
      ),
    );
  }
}
