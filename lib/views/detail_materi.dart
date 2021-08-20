import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DetailMateri extends StatefulWidget {
  @override
  _DetailMateriState createState() => _DetailMateriState();
}

class _DetailMateriState extends State<DetailMateri> {
  late VideoPlayerController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
        'https://file-examples-com.github.io/uploads/2018/04/file_example_MOV_1280_1_4MB.mov')
      ..addListener(() {
        setState(() {
          isPlaying = _controller.value.isPlaying;
        });
      })
      ..initialize().then((_) {
        setState(() {});
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
        child: Column(
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
                          VideoProgressIndicator(_controller,
                              allowScrubbing: true)
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
                "Nama Materi",
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
                "Deskripsi Materi, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
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
