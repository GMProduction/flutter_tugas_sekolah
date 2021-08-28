import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tugas_sekolah/component/bottom_navbar.dart';
import 'package:tugas_sekolah/component/card_materi.dart';
import 'package:tugas_sekolah/component/profile_navbar.dart';
import 'package:tugas_sekolah/helper/helper.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoadingMateri = true;
  bool isLoadingTugas = true;
  List<dynamic> _listMateri = [];
  List<dynamic> _listTugas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMateri();
    fetchTugas();
  }

  void fetchMateri() async {
    try {
      setState(() {
        isLoadingMateri = true;
      });
      String url = "$HostAddress/materi-now";
      String _token = await GetToken();
      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $_token",
            "Accept": "application/json"
          },
        ),
      );
      final data = response.data as List;
      print(response.data);
      setState(() {
        _listMateri = data;
      });
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Gagal Mengambil Data Materi...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {
      isLoadingMateri = false;
    });
  }

  void fetchTugas() async {
    try {
      setState(() {
        isLoadingTugas = true;
      });
      String url = "$HostAddress/tugas-now";
      String _token = await GetToken();
      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $_token",
            "Accept": "application/json"
          },
        ),
      );
      final data = response.data as List;
      print(response.data);
      setState(() {
        _listTugas = data;
      });
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Gagal Mengambil Data Materi...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {
      isLoadingTugas = false;
    });
  }

  refresh() async {
    fetchMateri();
    fetchTugas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ProfileNavbar(
              nama: "Bagus Yanuar",
              kelas: "2 SD",
              avatar: BaseAvatar,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return refresh();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Materi Hari Ini",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.only(right: 10),
                            child: isLoadingMateri
                                ? Container(
                                    height: 120,
                                    child: Center(
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: _listMateri.map((e) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/detail-materi',
                                                arguments: e["id"].toString());
                                          },
                                          child: CardMateri(
                                            nama: e["nama"].toString(),
                                            deskripsi:
                                                e["deskripsi"].toString(),
                                            buttonText: "Lihat Materi",
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Tugas Hari Ini",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.only(right: 10),
                            child: isLoadingTugas
                                ? Container(
                                    height: 120,
                                    child: Center(
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: _listTugas.map((e) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/detail-tugas',
                                                arguments: e["id"].toString());
                                          },
                                          child: CardMateri(
                                            nama: e["nama"].toString(),
                                            deskripsi:
                                                e["deskripsi"].toString(),
                                            buttonText: "Kerjakan Tugas",
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BottomNavbar()
          ],
        ),
      ),
    );
  }
}
