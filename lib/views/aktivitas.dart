import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_sekolah/component/bottom_navbar.dart';
import 'package:tugas_sekolah/component/card_aktivitas.dart';
import 'package:tugas_sekolah/helper/helper.dart';

class Aktivitas extends StatefulWidget {
  @override
  _AktivitasState createState() => _AktivitasState();
}

class _AktivitasState extends State<Aktivitas> {
  bool isLoading = true;
  List<dynamic> _listAktivitas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAktivitas();
  }

  void fetchAktivitas() async {
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString("token") ?? "";
      final response = await Dio().get(
        '$HostAddress/aktivitas',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          },
        ),
      );
      print(response.data);
      setState(() {
        _listAktivitas = response.data;
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
      floatingActionButton: Align(
        alignment: Alignment(1, 0.8),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/aktivitas-baru");
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  "Aktivitas",
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
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  fetchAktivitas();
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
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: LayoutBuilder(
                          builder: (context, constraints) =>
                              SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: _listAktivitas.map((e) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: CardAktivitas(
                                    tanggal: e["tanggal"].toString(),
                                    surat: e["surat"].toString(),
                                    sholat: e["sholat"],
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
              selected: 3,
            )
          ],
        ),
      ),
    );
  }
}
