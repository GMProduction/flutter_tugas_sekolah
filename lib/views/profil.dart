import 'package:flutter/material.dart';
import 'package:tugas_sekolah/component/line_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  static List<charts.Series<Rapor, DateTime>> _createSampleData() {
    final data = [
      new Rapor(80, new DateTime(2020, 8, 20)),
      new Rapor(75, new DateTime(2020, 8, 21)),
      new Rapor(100, new DateTime(2020, 8, 22)),
      new Rapor(80, new DateTime(2020, 8, 23)),
      new Rapor(65, new DateTime(2020, 8, 24)),
      new Rapor(90, new DateTime(2020, 8, 25)),
    ];

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
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Profil Siswa",
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
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Nama Siswa :"),
                              Text("Bagus Yanuar")
                            ],
                          ),
                          Row(
                            children: [
                              Text("Alamat :"),
                              Text("Wonosaren Rt 04 Rw 08")
                            ],
                          ),
                          Row(
                            children: [
                              Text("No. Hp :"),
                              Text("0895422630233"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Text("Nilai Rata - Rata"),
                  Text(
                    "80",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 300,
                child: PointsLineChart(_createSampleData()),
              ),
            )
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
