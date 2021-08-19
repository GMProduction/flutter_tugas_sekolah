import 'package:flutter/material.dart';
import 'package:tugas_sekolah/component/bottom_navbar.dart';
import 'package:tugas_sekolah/component/card_pencarian_materi.dart';
import 'package:tugas_sekolah/helper/helper.dart';

class Materi extends StatefulWidget {
  @override
  _MateriState createState() => _MateriState();
}

class _MateriState extends State<Materi> {
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
                  "Materi",
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Cari Materi",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Hasil Pencarian"),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(const Duration(seconds: 2));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: DataDummies.pencarianMateriDummy.map((e) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.only(right: 10),
                            child: CardPencarianMateri(
                              nama: e["nama"].toString(),
                              deskripsi: e["deskripsi"].toString(),
                              buttonText: "Lihat Materi",
                              tanggal: e["tanggal"].toString(),
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
              selected: 1,
            )
          ],
        ),
      ),
    );
  }
}
