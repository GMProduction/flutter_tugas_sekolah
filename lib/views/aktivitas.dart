import 'package:flutter/material.dart';
import 'package:tugas_sekolah/component/bottom_navbar.dart';
import 'package:tugas_sekolah/component/card_aktivitas.dart';
import 'package:tugas_sekolah/helper/helper.dart';

class Aktivitas extends StatefulWidget {
  @override
  _AktivitasState createState() => _AktivitasState();
}

class _AktivitasState extends State<Aktivitas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Align(
        alignment: Alignment(1, 0.8),
        child: FloatingActionButton(
          onPressed: () {},
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
                        children: DataDummies.aktivitasDummy.map((e) {
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
