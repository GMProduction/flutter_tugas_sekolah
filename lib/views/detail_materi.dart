import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_sekolah/helper/helper.dart';
import 'package:video_player/video_player.dart';

class DetailMateri extends StatefulWidget {
  @override
  _DetailMateriState createState() => _DetailMateriState();
}

class _DetailMateriState extends State<DetailMateri> {
  VideoPlayerController _controller;
  bool isPlaying = false;
  bool isLoading = true;
  Map<String, dynamic> _materi = {};
  String urlVideo =
      "https://file-examples-com.github.io/uploads/2018/04/file_example_MOV_1280_1_4MB.mov";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var id = ModalRoute.of(context).settings.arguments as String;
      print(id);
      getDetailMateri(id);
    });
  }

  void getDetailMateri(String id) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString("token") ?? "";
      print(token);
      final response = await Dio().get(
        '$HostAddress/materi/$id',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          },
        ),
      );
      print(response.data);
      setState(() {
        _materi = response.data as Map<String, dynamic>;
      });
      _controller =
          VideoPlayerController.network("$HostFile${_materi["url_video"]}")
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

  @override
  void dispose() {
    // TODO: implement dispose
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
                    Text("Sedang Mengunduh Detail Materi...")
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
                      _materi["nama"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      _materi["deskripsi"],
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
