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
  String avatar = BaseAvatar;
  String nama = "Nama Siswa";
  String kelas = "Kelas";
  Map<String, dynamic> _absen;
  String _tglAbsen = "";
  bool isAbsen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMateri();
    fetchTugas();
    getProfile();
    getAbsen();
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

  void getProfile() async {
    String url = "$HostAddress/profile";
    String _token = await GetToken();
    try {
      final response = await Dio().get(url,
          options: Options(headers: {
            "Authorization": "Bearer $_token",
            "Accept": "application/json"
          }));

      setState(() {
        avatar = response.data["image"] == null
            ? BaseAvatar
            : "$HostImage${response.data["image"].toString()}";
        nama = response.data["nama"].toString();
      });
      print(response.data);
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Gagal Mengganti Gambar Profil...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.response);
    }
  }

  void getAbsen() async {
    String url = "$HostAddress/absensi";
    String _token = await GetToken();
    try {
      final response = await Dio().get(url,
          options: Options(headers: {
            "Authorization": "Bearer $_token",
            "Accept": "application/json"
          }));
      print(response.data);
      if (response.data["data"] != null) {
        bool _tmpAbsen =
            response.data["data"]["absenku"] == null ? false : true;
        setState(() {
          _absen = response.data["data"];
          _tglAbsen = response.data["data"]["tanggal"];
          isAbsen = _tmpAbsen;
        });
      } else {
        setState(() {
          _absen = null;
        });
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Gagal Mendapatkan Absen...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.response);
    }
  }

  void absen(int id) async {
    String url = "$HostAddress/absensi/$id";
    String _token = await GetToken();
    try {
      final response = await Dio().post(url,
          options: Options(headers: {
            "Authorization": "Bearer $_token",
            "Accept": "application/json"
          }));

      setState(() {
        isAbsen = true;
      });
      Fluttertoast.showToast(
          msg: "Berhasil Absen...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      print(response.data);
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Gagal Mendapatkan Absen...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.response);
    }
  }

  refresh() async {
    fetchMateri();
    fetchTugas();
    getProfile();
    getAbsen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ProfileNavbar(
              nama: nama,
              kelas: "",
              avatar: avatar,
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
                          Visibility(
                            visible: _absen == null ? false : true,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  if (!isAbsen) {
                                    absen(_absen["id"] as int);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Absensi Hari Ini",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("20-09-2021"),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.lightBlue,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              isAbsen
                                                  ? "Sudah Absen"
                                                  : "Klik Untuk Absen",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                                : _listMateri.length > 0
                                    ? Column(
                                        children: _listMateri.map((e) {
                                          return Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/detail-materi',
                                                    arguments:
                                                        e["id"].toString());
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
                                      )
                                    : Container(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                              "Tidak Ada Materi Untuk Hari Ini..."),
                                        ),
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
                                : _listTugas.length > 0
                                    ? Column(
                                        children: _listTugas.map((e) {
                                          return Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/detail-tugas',
                                                    arguments:
                                                        e["id"].toString());
                                              },
                                              child: CardTugas(
                                                nama: e["nama"].toString(),
                                                deskripsi:
                                                    e["deskripsi"].toString(),
                                                buttonText: "Kerjakan Tugas",
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      )
                                    : Container(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                              "Tidak Ada Tugas Untuk Hari Ini..."),
                                        ),
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
