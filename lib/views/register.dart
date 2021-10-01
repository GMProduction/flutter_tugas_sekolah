import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_sekolah/helper/helper.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String nis = "";
  String nama = "";
  String password = "";
  String konfirm_password = "";
  String roles = "user";
  String noHp = "";
  DateTime tanggal;
  String alamat = "";
  dynamic kelas;
  int pilihkelas = 0;
  bool isLoading = false;
  List<dynamic> _listKelas = [];

  bool readyTohit = true;

  void daftar() async {
    setState(() {
      readyTohit = false;
    });

    String url = "$HostAddress/register";
    try {
      Map<String, dynamic> data = {
        "nama": nama,
        "username": nis,
        "password": password,
        "password_confirmation": konfirm_password,
        "roles": roles,
        "no_hp": noHp,
        "tanggal_lahir": tanggal,
        "alamat": alamat,
        "kelas": pilihkelas
      };
      print(data.toString());
      FormData formData = FormData.fromMap(data);
      final response = await Dio().post(
        url,
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
          },
        ),
      );

      setState(() {
        readyTohit = true;
      });

      String token = response.data['token'] as String;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("token", token);
      Fluttertoast.showToast(
          msg: "Login Berhasil Token $token",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/dashboard",
        ModalRoute.withName("/dashboard"),
      );
      print(response.data);
    } on DioError catch (e) {
      setState(() {
        readyTohit = true;
      });

      print(e.response.data);
      print(e);
      Fluttertoast.showToast(
          msg: "Registrasi Gagal. Mohon Lengkapi Data Dengan Benar...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void fetchKelas() async {
    print("fetch kelas");

    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString("token") ?? "";
      final response = await Dio().get(
        '$HostAddress/kelas',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          },
        ),
      );

      print(response.data);
      setState(() {
        _listKelas = response.data;
        kelas = _listKelas[0];
        pilihkelas = _listKelas[0]["id"];
      });
    } on DioError catch (e) {
      print(e.response.data);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchKelas();

  }

  @override
  Widget build(BuildContext context) {
    print(_listKelas);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pendaftaran Siswa",
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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("NIS"),
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 20),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              nis = text;
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: "NIS"),
                        ),
                      ),
                      Text("Kelas"),
                      _listKelas.length == 0 ? Container() :
                      DropdownButton(

                        value: kelas,
                        items: _listKelas
                            .map((code) => new DropdownMenuItem(
                                value: code, child: new Text(code["nama"].toString())))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            kelas = value;
                            pilihkelas = value["id"];
                            print(pilihkelas.toString());
                          });

                        },
                      ),
                      SizedBox(height: 5,),
                      Text("Password"),
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 20),
                        child: TextField(
                          obscureText: true,
                          onChanged: (text) {
                            setState(() {
                              password = text;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: "Password"),
                        ),
                      ),
                      Text("Konfirmasi Password"),
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 20),
                        child: TextField(
                          obscureText: true,
                          onChanged: (text) {
                            setState(() {
                              konfirm_password = text;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: "Konfirmasi Password"),
                        ),
                      ),
                      Text("Nama Siswa"),
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 20),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              nama = text;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: "Nama Siswa"),
                        ),
                      ),
                      Text("No. Hp"),
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 20),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              noHp = text;
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: "Nomor Handphone"),
                        ),
                      ),
                      Text("Alamat"),
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 20),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              alamat = text;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: "Alamat"),
                        ),
                      ),
                      Text("Tanggal Lahir"),
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: tanggal == null
                                        ? DateTime.now()
                                        : tanggal,
                                    firstDate: DateTime(1980),
                                    lastDate: DateTime(2500))
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  tanggal = value;
                                });
                              }
                            });
                          },
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black54, width: 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                tanggal != null
                                    ? Text(
                                        "${tanggal.day.toString().padLeft(2, "0")}-${tanggal.month.toString().padLeft(2, "0")}-${tanggal.year.toString()}")
                                    : Text(""),
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  daftar();
                },
                child: readyTohit
                    ? Container(
                        height: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.lightBlue,
                        ),
                        child: Center(
                          child: Text(
                            "Simpan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      )
                    : CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
