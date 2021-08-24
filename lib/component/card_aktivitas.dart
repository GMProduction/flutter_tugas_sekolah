import 'package:flutter/material.dart';
import 'package:tugas_sekolah/helper/helper.dart';

class CardAktivitas extends StatelessWidget {
  final String tanggal;
  final String surat;
  final List<dynamic> sholat;

  const CardAktivitas({
    Key? key,
    this.tanggal = "",
    this.surat = "Nama Mapel",
    this.sholat = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(2, 2))
        ],
      ),
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Center(
              child: Text(
                this.tanggal,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.surat,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: DataDummies.sholat.map((e) {
                    var anu = this
                        .sholat
                        .where((element) => element["nama"] == e.toString());
                    bool active = false;
                    if (anu.isNotEmpty) {
                      active = true;
                      print("enek Bos");
                    }
                    print(this.sholat);
                    return Expanded(
                      flex: 1,
                      child: Container(
                        height: 25,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            color: active ? Colors.lightBlue : Colors.black12,
                            borderRadius: BorderRadius.circular(3)),
                        child: Center(
                          child: Text(
                            e.toString().toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: active ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Wrap(
                //   spacing: 5,
                //   children: this.sholat.map((e) {
                //     return Container(
                //       padding: EdgeInsets.symmetric(vertical: 5),
                //       decoration: BoxDecoration(
                //         color: Colors.grey,
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       child: Text("sholat"),
                //     );
                //   }).toList(),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
