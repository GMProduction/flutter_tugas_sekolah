import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_sekolah/component/line_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tugas_sekolah/helper/helper.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String avatar = BaseAvatar;
  Map<String, dynamic> _dataSiswa = {};
  List<dynamic> _nilai = [];
  List<dynamic> _rapor = [];
  bool isLoadingNilai = false;
  int _avgNilai = 0;
  int _avgAbsensi = 0;

  List<charts.Series<Rapor, DateTime>> _createSampleData() {
    // final data = [
    //   new Rapor(80, new DateTime(2020, 8, 20)),
    //   new Rapor(75, new DateTime(2020, 8, 21)),
    //   new Rapor(100, new DateTime(2020, 8, 22)),
    //   new Rapor(80, new DateTime(2020, 8, 23)),
    //   new Rapor(65, new DateTime(2020, 8, 24)),
    //   new Rapor(90, new DateTime(2020, 8, 25)),
    // ];

    List<Rapor> data = [];
    _rapor.forEach((element) {
      DateTime _tmpTanggal = element["tanggal"] as DateTime;
      data.add(new Rapor(
        element["nilai"],
        new DateTime(_tmpTanggal.year, _tmpTanggal.month, _tmpTanggal.day,
            _tmpTanggal.hour, _tmpTanggal.minute),
      ));
    });
    return [
      new charts.Series<Rapor, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Rapor rapor, _) => rapor.tanggal,
        measureFn: (Rapor rapor, _) => rapor.nilai,
        data: data,
      )
    ];
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("token");
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/login",
      ModalRoute.withName("/login"),
    );
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
            : "$HostImage${response.data["image"]}";
        _dataSiswa = response.data;
      });
      print(response);
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Gagal Mengambil Data Profil...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.response);
    }
  }

  void getNilai() async {
    String url = "$HostAddress/nilai";
    setState(() {
      isLoadingNilai = true;
    });
    String _token = await GetToken();
    try {
      final response = await Dio().get(url,
          options: Options(headers: {
            "Authorization": "Bearer $_token",
            "Accept": "application/json"
          }));
      var data = response.data as List;
      List<Map<String, dynamic>> _tmpRapor = [];
      data.forEach((element) {
        Map<String, dynamic> _tmpData = {
          "nilai": element["nilai"] as int,
          "tanggal": DateTime.parse(element["created_at"].toString())
        };
        _tmpRapor.add(_tmpData);
      });
      setState(() {
        _nilai = response.data;
        _rapor = _tmpRapor;
      });
      print(response);
      print(_tmpRapor);
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Gagal Mengambil Nilai...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.response);
    }
    setState(() {
      isLoadingNilai = false;
    });
  }

  void getAvgNilai() async {
    String url = "$HostAddress/nilai-avg";

    String _token = await GetToken();
    try {
      final response = await Dio().get(url,
          options: Options(headers: {
            "Authorization": "Bearer $_token",
            "Accept": "application/json"
          }));
      setState(() {
        _avgNilai = response.data["avg"] as int;
      });
      print(response.data);
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Gagal Mengambil Nilai...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.response);
    }
  }

  void getAvgAbsensi() async {
    String url = "$HostAddress/absensi-avg";

    String _token = await GetToken();
    try {
      final response = await Dio().get(url,
          options: Options(headers: {
            "Authorization": "Bearer $_token",
            "Accept": "application/json"
          }));
      setState(() {
        _avgAbsensi = response.data["avg"] as int;
      });
      print(response.data);
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Gagal Mengambil Rata Rata Absensi...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.response);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
    getNilai();
    getAvgNilai();
    getAvgAbsensi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profil Siswa",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      logout();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.close),
                        Text("Logout"),
                      ],
                    ),
                  )
                ],
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
                  getProfile();
                  getNilai();
                  getAvgNilai();
                  getAvgAbsensi();
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
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: NetworkImage(avatar),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              child: Text("Nama Siswa :"),
                                            ),
                                            Expanded(
                                              child: Text(
                                                _dataSiswa["nama"].toString(),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              child: Text("Alamat :"),
                                            ),
                                            Expanded(
                                              child: Text(
                                                _dataSiswa["alamat"].toString(),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              child: Text("No. Hp :"),
                                            ),
                                            Expanded(
                                              child: Text(
                                                _dataSiswa["no_hp"].toString(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(right: 5),
                                                  child: Text("Absensi :"),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      "${_avgAbsensi.toString()}%"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  Text("Nilai Rata - Rata"),
                                  Text(
                                    _avgNilai.toString(),
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: isLoadingNilai
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Sedang Mengunduh Data Nilai..."),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: 300,
                                    child: PointsLineChart(_createSampleData()),
                                  ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Review Tugas",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: _nilai.map((e) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              width: 1),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e["tugas"]["nama"].toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              e["keterangan"] != null
                                                  ? e["keterangan"].toString()
                                                  : "Tugas Belum Di Review",
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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

class Rapor {
  final int nilai;
  final DateTime tanggal;

  Rapor(this.nilai, this.tanggal);
}
