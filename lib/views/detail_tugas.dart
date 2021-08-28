import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_sekolah/helper/helper.dart';
import 'package:video_player/video_player.dart';

class DetailTugas extends StatefulWidget {
  @override
  _DetailTugasState createState() => _DetailTugasState();
}

class _DetailTugasState extends State<DetailTugas> {
  late VideoPlayerController _controller;
  bool isPlaying = false;
  bool isLoading = true;
  bool isLoadingUpload = false;
  Map<String, dynamic> _tugas = {};
  String _fileTugas = "Belum Ada File...";
  PlatformFile? file;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      var id = ModalRoute.of(context)!.settings.arguments as String;
      print(id);
      getDetailTugas(id);
    });
  }

  void getDetailTugas(String id) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString("token") ?? "";
      print(token);
      final response = await Dio().get(
        '$HostAddress/tugas/$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          },
        ),
      );
      print(response.data);
      setState(() {
        _tugas = response.data as Map<String, dynamic>;
      });
      _controller =
          VideoPlayerController.network("$HostFile${_tugas["url_video"]}")
            ..addListener(() {
              setState(() {
                isPlaying = _controller.value.isPlaying;
              });
            })
            ..initialize().then((_) {
              setState(() {});
            });
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Terjadi Kesalahan Pada Server...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.response);
    }
    setState(() {
      isLoading = false;
    });
  }

  void cariFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        file = result.files.first;
        _fileTugas = result.files.first.name;
      });
      print(_fileTugas);
    } else {
      print("cancel");
    }
  }

  void uploadTugas() async {
    setState(() {
      isLoadingUpload = true;
    });
    if (file != null) {
      try {
        String url = "$HostAddress/tugas/${_tugas["id"]}";
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String token = preferences.getString("token") ?? "";
        print(token);
        FormData form = FormData.fromMap({
          "url": await MultipartFile.fromFile(file!.path!, filename: file!.name)
        });
        final response = await Dio().post(
          url,
          data: form,
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
              "Accept": "application/json"
            },
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/dashboard",
          ModalRoute.withName("/dashboard"),
        );
        print(response.data);
      } on DioError catch (e) {
        print(e.response!.data);
        Fluttertoast.showToast(
            msg: "Terjadi Kesalahan Pada Server...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Kamu Belum Memilih File..",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    setState(() {
      isLoadingUpload = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    ),
                    Text("Sedang Mengunduh Detail Tugas...")
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                VideoPlayer(_controller),
                                VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text("No Video Available"),
                            ),
                          ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      _tugas["nama"].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(top: 10, bottom: 50),
                    child: Text(
                      _tugas["deskripsi"],
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: [
                        Text("File Tugas :"),
                        Expanded(
                          child: Text(
                            _fileTugas.toString(),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cariFile();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Center(
                              child: Text("Cari File"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        uploadTugas();
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(10)),
                        child: isLoadingUpload
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 14,
                                    width: 14,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Sedang Mengupload Tugas...",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              )
                            : Center(
                                child: Text(
                                "Upload Tugas",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
