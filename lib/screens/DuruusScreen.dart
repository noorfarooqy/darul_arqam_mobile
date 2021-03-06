import 'package:audioplayers/audioplayers.dart';
import 'package:darularqam/models/ApiRequestNames.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/LessonModel.dart';
import 'package:darularqam/widgets/CustomBottomNavigation.dart';
import 'package:darularqam/widgets/LessonListViewBuilder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:toast/toast.dart';

class DuruusScreen extends StatelessWidget {
  DuruusScreen({this.pageIndex});
  final pageIndex;

  getLessonList(BuildContext context) async {
    CustomHttpRequestModel requestModel = CustomHttpRequestModel();
    Response response =
        await requestModel.makeApiRequest(url: ApiRequestName.getLessonsList);

    if (response.statusCode != 200) return -1;
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["isSuccess"] == false) {
      Toast.show(jsonResponse["errorMessage"].toString(), context,
          backgroundColor: Colors.red, duration: Toast.LENGTH_LONG);
    }
    var lessonList = jsonResponse["data"];
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
      body: SafeArea(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey.shade200,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          height: 40,
                          image: AssetImage('assets/images/logo2.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'DAARUL-ARQAM',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: ColorCodesModel.swatch4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Duruusta ugu danbeesay',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: getLessonList(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(
                          child: Text(
                              'This is embarrassing. Something went wrong '),
                        );
                      }
                      if (snapshot.data == -1) {
                        return Center(
                          child: Text(
                              'We are sorry. Our server is experiencing some problems.'
                              ' Try again '),
                        );
                      }
                      if(snapshot.data.length <=0){
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
  MiniPlayer({this.audioPlayer,this.lessonModel});
  final AudioPlayer audioPlayer;
  final LessonModel lessonModel;
  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  playAudio(AudioPlayer audioPlayer, LessonModel lessonModel,BuildContext context)async{
    int result = await audioPlayer.play(lessonModel.lessonAudioUrl);
    if(result != 1){
      Toast.show('Can\'t play audio.', context,
          backgroundColor: Colors.red.shade700,duration: Toast.LENGTH_LONG);
    }
    else{
      setState(() {
        isPlaying = true;
      });
      print('should play audio '+result.toString());
    }
  }
  pauseAudio(AudioPlayer audioPlayer ,BuildContext context)async{
    int result  = await audioPlayer.pause();
    if(result != 1){
      Toast.show('Can\'t play audio.', context,
          backgroundColor: Colors.red.shade700,duration: Toast.LENGTH_LONG);
    }
    else{
      setState(() {
        isPlaying = false;
        isPaused = true;
      });
    }
  }
  bool isPlaying = false;
  bool isPaused = false;
  double sliderValue =0;
  int hours = 0;
  int seconds = 0;
  int minutes = 0;
  getHours(){
    return hours < 10 ? '0'+hours.toString() : hours.toString();
  }
  getMinutes(){
    return minutes < 10 ? '0'+minutes.toString() : minutes.toString();
  }
  getSeconds() {
    return seconds < 10 ? '0'+seconds.toString() : seconds.toString();
  }
  @override
  initState(){
    super.initState();
    widget.audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        hours = event.inHours;
        seconds = event.inSeconds;
        if(seconds > 59)
          seconds = 0;
        minutes = event.inMinutes;
        if(minutes > 59)
          minutes = 0;

      });
    });
  }
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          onPressed: (){},
          icon: Icon(FontAwesomeIcons.fastBackward),
        ),
        IconButton(
          iconSize: 50,
          onPressed: (){
            if(isPlaying)
              pauseAudio(widget.audioPlayer,context);
            else
              playAudio(widget.audioPlayer, widget.lessonModel, context);
          },
          icon: isPlaying ? Icon(FontAwesomeIcons.pause) :
          Icon(FontAwesomeIcons.play),
        ),IconButton(
          onPressed: (){
            if(isPlaying || isPaused){
              widget.audioPlayer.stop();
              widget.audioPlayer.release();
              setState(() {
                isPlaying = false;
                hours =0;
                minutes =0;
                seconds =0;
              });
            }


          },
          iconSize: 50,
          icon: Icon(FontAwesomeIcons.stop),
        ),
        IconButton(
          onPressed: (){},
          icon: Icon(FontAwesomeIcons.fastForward),
        ),
      ],
    );
  }
}
