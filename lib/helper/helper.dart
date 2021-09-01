import 'package:shared_preferences/shared_preferences.dart';

const String BaseAvatar =
    'https://user-images.githubusercontent.com/4462072/63714494-c4d9c880-c7f6-11e9-8940-5a9636ecba36.png';
//const String HostAddress = 'http://192.168.100.12:8000/api';
//const String HostImage = "http://192.168.100.12:8000/";
//const String HostFile = "http://192.168.100.12:8000/";
//
const String HostAddress = 'http://192.168.137.1:8003/api';
const String HostImage = "http://192.168.137.1:8003/";
const String HostFile = "http://192.168.137.1:8003/";

const String Ongoing = "paket-ongoin";
const String ComingSoon = "paket-coming-soon";
const String DetailPaket = "paket/id";
const String DetailSoal = "paket/id/soal";
Future<String> GetToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("token") ?? "";
}

class DataDummies {
  static List<Map<String, dynamic>> materiDummy = [
    {
      "id": 1,
      "nama": "Nama Materi 1",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "deskripsi":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
    },
    {
      "id": 2,
      "nama": "Nama Materi 2",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "deskripsi":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
    },
  ];
  static List<Map<String, dynamic>> pencarianMateriDummy = [
    {
      "id": 1,
      "nama": "Nama Materi 1",
      "tanggal": "02-02-2021",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "deskripsi":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
    },
    {
      "id": 2,
      "nama": "Nama Materi 2",
      "tanggal": "03-02-2021",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "deskripsi":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
    },
    {
      "id": 3,
      "nama": "Nama Materi 3",
      "tanggal": "04-02-2021",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "deskripsi":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
    },
    {
      "id": 4,
      "nama": "Nama Materi 4",
      "tanggal": "05-02-2021",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "deskripsi":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
    },
    {
      "id": 5,
      "nama": "Nama Materi 5",
      "tanggal": "06-02-2021",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "deskripsi":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
    },
    {
      "id": 6,
      "nama": "Nama Materi 6",
      "tanggal": "07-02-2021",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "deskripsi":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
    },
  ];

  static List<Map<String, dynamic>> upComingDummy = [
    {
      "id": 3,
      "paket": "Paket Ujian 3",
      "mapel": "Matematika",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "time": 120,
      "aturan":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
    },
    {
      "id": 4,
      "paket": "Paket Ujian 4",
      "mapel": "Bahasa Indonesia",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "time": 120,
      "aturan":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
    },
    {
      "id": 5,
      "paket": "Paket Ujian 5",
      "mapel": "Bahasa Inggris",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "time": 90,
      "aturan":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
    },
    {
      "id": 6,
      "paket": "Paket Ujian 6",
      "mapel": "Sejarah",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "time": 60,
      "aturan":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
    },
  ];

  static List<Map<String, dynamic>> aktivitasDummy = [
    {
      "id": 1,
      "tanggal": "20-03-2001",
      "surat": "Alfatihah",
      "sholat": [
        {"nama": "shubuh"},
        {"nama": "isya"},
        {"nama": "maghrib"},
      ],
    },
    {
      "id": 2,
      "tanggal": "21-03-2001",
      "surat": "Al-Ikhlas",
      "sholat": [
        {"nama": "dzuhur"},
        {"nama": "ashar"},
        {"nama": "subuh"},
        {"nama": "isya"},
        {"nama": "maghrib"},
      ],
    },
    {
      "id": 3,
      "tanggal": "22-03-2001",
      "surat": "Alfatihah",
      "sholat": [
        {"nama": "isya"},
        {"nama": "maghrib"},
      ],
    },
    {
      "id": 4,
      "tanggal": "23-03-2001",
      "surat": "Alfatihah",
      "sholat": [
        {"nama": "subuh"},
        {"nama": "isya"},
        {"nama": "maghrib"},
        {"nama": "dzuhur"},
      ],
    },
  ];

  static List<String> sholat = ["subuh", "ashar", "dzuhur", "maghrib", "isya"];

  static List<Map<String, dynamic>> historyDummy = [
    {
      "id": 3,
      "paket": "Paket Ujian 3",
      "mapel": "Matematika",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "nilai": 120,
      "detail": {"jumlah": 20, "benar": 17, "salah": 2, "kosong": 1},
      "peringkat": [
        {
          "nama": "Danilla",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 100
        },
        {
          "nama": "wkwkwk",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 90
        },
        {
          "nama": "ckckckck wkwkw",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 87
        },
        {
          "nama": "Danilla",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 85
        },
        {
          "nama": "wkwkwk",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 70
        },
        {
          "nama": "ckckckck wkwkw",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 65
        },
      ]
    },
    {
      "id": 4,
      "paket": "Paket Ujian 4",
      "mapel": "Bahasa Indonesia",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "nilai": 120,
      "detail": {"jumlah": 20, "benar": 17, "salah": 2, "kosong": 1},
      "peringkat": [
        {
          "nama": "Danilla",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 100
        },
        {
          "nama": "wkwkwk",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 90
        },
        {
          "nama": "ckckckck wkwkw",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 85
        },
      ]
    },
    {
      "id": 5,
      "paket": "Paket Ujian 5",
      "mapel": "Bahasa Inggris",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "nilai": 90,
      "detail": {"jumlah": 20, "benar": 17, "salah": 2, "kosong": 1},
      "peringkat": [
        {
          "nama": "Danilla",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 100
        },
        {
          "nama": "wkwkwk",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 90
        },
        {
          "nama": "ckckckck wkwkw",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 85
        },
      ]
    },
    {
      "id": 6,
      "paket": "Paket Ujian 6",
      "mapel": "Sejarah",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "nilai": 60,
      "detail": {"jumlah": 20, "benar": 17, "salah": 2, "kosong": 1},
      "peringkat": [
        {
          "nama": "Danilla",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 100
        },
        {
          "nama": "wkwkwk",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 90
        },
        {
          "nama": "ckckckck wkwkw",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 85
        },
      ]
    },
    {
      "id": 7,
      "paket": "Paket Ujian 7",
      "mapel": "Geografi",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "nilai": 50,
      "detail": {"jumlah": 20, "benar": 17, "salah": 2, "kosong": 1},
      "peringkat": [
        {
          "nama": "Danilla",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 100
        },
        {
          "nama": "wkwkwk",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 90
        },
        {
          "nama": "ckckckck wkwkw",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 85
        },
      ]
    },
    {
      "id": 8,
      "paket": "Paket Ujian 8",
      "mapel": "Olahraga",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "nilai": 100,
      "detail": {"jumlah": 20, "benar": 17, "salah": 2, "kosong": 1},
      "peringkat": [
        {
          "nama": "Danilla",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 100
        },
        {
          "nama": "wkwkwk",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 90
        },
        {
          "nama": "ckckckck wkwkw",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 85
        },
      ]
    },
    {
      "id": 9,
      "paket": "Paket Ujian 9",
      "mapel": "Ekonomi",
      "image":
          "https://www.smkn63jkt.sch.id/wp-content/uploads/2020/06/ujian-online.png",
      "nilai": 75,
      "detail": {"jumlah": 20, "benar": 17, "salah": 2, "kosong": 1},
      "peringkat": [
        {
          "nama": "Danilla",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 100
        },
        {
          "nama": "wkwkwk",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 90
        },
        {
          "nama": "ckckckck wkwkw",
          "image":
              "https://asset.kompas.com/crops/Yo_YfeFHMsovw0s9XPyE8JCyYSc=/267x150:960x611/750x500/data/photo/2020/10/01/5f75dbce19db7.png",
          "nilai": 85
        },
      ]
    },
  ];
}
