import 'package:flutter/material.dart';
import 'package:tugas_sekolah/component/bottom_navbar.dart';
import 'package:tugas_sekolah/component/card_materi.dart';
import 'package:tugas_sekolah/component/profile_navbar.dart';
import 'package:tugas_sekolah/helper/helper.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                  return Future.delayed(const Duration(seconds: 1));
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
                            child: Column(
                              children: DataDummies.materiDummy.map((e) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/detail-materi');
                                    },
                                    child: CardMateri(
                                      nama: e["nama"].toString(),
                                      deskripsi: e["deskripsi"].toString(),
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
                            child: Column(
                              children: DataDummies.materiDummy.map((e) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/detail-tugas");
                                    },
                                    child: CardMateri(
                                      nama: e["nama"].toString(),
                                      deskripsi: e["deskripsi"].toString(),
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
