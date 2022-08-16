import 'package:audioplayers/audioplayers.dart';
import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/LessonModel.dart';
import 'package:darularqam/services/lesson_services.dart';
import 'package:darularqam/widgets/books_listview_shimmer.dart';
import 'package:darularqam/widgets/custom_app_bar.dart';
import 'package:darularqam/widgets/custom_bottom_navigation.dart';
import 'package:darularqam/widgets/custom_error_widget.dart';
import 'package:darularqam/widgets/lesson_list_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:toast/toast.dart';

class DuruusScreen extends StatelessWidget {
  DuruusScreen({this.pageIndex});
  final pageIndex;

  getLessonList(BuildContext context) async {
    print('getting lessons');
    LessonServices lessonServices = LessonServices();
    await lessonServices.getLatestLessons();
    var lessonList = lessonServices.lessonsList;
    int lessonCount = lessonList.length;
    List<LessonModel> lessons = [];
    for (int i = 0; i < lessonCount; i++) {
      lessons.add(LessonModel(lessonList[i]));
    }
    return lessons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(),
      body: SafeArea(
        child: Stack(
          // overflow: Overflow.visible,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Duruusta ugu danbeesay',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: getLessonList(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return BooksListViewShimmer();
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(
                          child: Text(
                              'This is embarrassing. Something went wrong '),
                        );
                      }
                      if (snapshot.data == -1) {
                        return CustomErrorWidget(
                            errorMessage: snapshot.data['error_message']);
                      }
                      if (snapshot.data.length <= 0) {
                        return Center(
                          child: Text('Wax duruus ah kuma jiro'),
                        );
                      }
                      List<LessonModel> lessons = snapshot.data;
                      return LessonListViewBuilder(lessons: lessons);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BuildCustomBottomNavigationWidget(
        currentIndex: pageIndex,
      ),
    );
  }
}

class MiniPlayer extends StatefulWidget {
  MiniPlayer({this.audioPlayer, this.lessonModel});
  final AudioPlayer audioPlayer;
  final LessonModel lessonModel;
  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  playAudio(AudioPlayer audioPlayer, LessonModel lessonModel,
      BuildContext context) async {
    await audioPlayer.setSourceUrl(lessonModel.lessonAudioUrl);
    // await audioPlayer.play(lessonModel.lessonAudioUrl);
    // if (result != 1) {
    //   Toast.show('Can\'t play audio.', context,
    //       backgroundColor: Colors.red.shade700, duration: Toast.LENGTH_LONG);
    // } else {
    //   setState(() {
    //     isPlaying = true;
    //   });
    //   print('should play audio ' + result.toString());
    // }
  }

  pauseAudio(AudioPlayer audioPlayer, BuildContext context) async {
    await audioPlayer.pause();
    // if (result != 1) {
    //   Toast.show('Can\'t play audio.', context,
    //       backgroundColor: Colors.red.shade700, duration: Toast.LENGTH_LONG);
    // } else {
    //   setState(() {
    //     isPlaying = false;
    //     isPaused = true;
    //   });
    // }
  }

  bool isPlaying = false;
  bool isPaused = false;
  double sliderValue = 0;
  int hours = 0;
  int seconds = 0;
  int minutes = 0;
  getHours() {
    return hours < 10 ? '0' + hours.toString() : hours.toString();
  }

  getMinutes() {
    return minutes < 10 ? '0' + minutes.toString() : minutes.toString();
  }

  getSeconds() {
    return seconds < 10 ? '0' + seconds.toString() : seconds.toString();
  }

  @override
  initState() {
    super.initState();
    // widget.audioPlayer.onAudioPositionChanged.listen((event) {
    widget.audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        hours = event.inHours;
        seconds = event.inSeconds;
        if (seconds > 59) seconds = 0;
        minutes = event.inMinutes;
        if (minutes > 59) minutes = 0;
      });
    });
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.backwardFast),
        ),
        IconButton(
          iconSize: 50,
          onPressed: () {
            if (isPlaying)
              pauseAudio(widget.audioPlayer, context);
            else
              playAudio(widget.audioPlayer, widget.lessonModel, context);
          },
          icon: isPlaying
              ? Icon(FontAwesomeIcons.pause)
              : Icon(FontAwesomeIcons.play),
        ),
        IconButton(
          onPressed: () {
            if (isPlaying || isPaused) {
              widget.audioPlayer.stop();
              widget.audioPlayer.release();
              setState(() {
                isPlaying = false;
                hours = 0;
                minutes = 0;
                seconds = 0;
              });
            }
          },
          iconSize: 50,
          icon: Icon(FontAwesomeIcons.stop),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.fastForward),
        ),
      ],
    );
  }
}
