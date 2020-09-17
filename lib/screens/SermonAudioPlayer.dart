import 'package:audioplayers/audioplayers.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/SermonModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class SermonAudioPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    SermonModel sermonModel = args["sermonModel"];
    AudioPlayer audioPlayer = args["audioPlayer"];
    return Scaffold(
      backgroundColor: ColorCodesModel.swatch1,
      appBar: AppBar(
        title: Text('DAARUL-ARQAM'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            audioPlayer.setNotification(
              title: 'Daarul Arqam',
              albumTitle: sermonModel.sermonTitle,
              artist: sermonModel.sheekhInfo.sheekhName,
              forwardSkipInterval: Duration(seconds: 5),
            );
            audioPlayer.stop();
            audioPlayer.release();
            Navigator.pop(context, audioPlayer);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: PlayerWidget(
          sermonModel: sermonModel,
          audioPlayer: audioPlayer,
        )),
      ),
    );
  }
}

class PlayerWidget extends StatefulWidget {
  PlayerWidget({this.sermonModel, this.audioPlayer});
  final SermonModel sermonModel;
  final AudioPlayer audioPlayer;
  @override
  _PlayerWidgetTrackerState createState() => _PlayerWidgetTrackerState();
}

class _PlayerWidgetTrackerState extends State<PlayerWidget> {
  playAudio(AudioPlayer audioPlayer, SermonModel sermonModel,
      BuildContext context) async {
    int result;
    if (audioPlayer.state == AudioPlayerState.PAUSED)
      result = await audioPlayer.play(sermonModel.sermonFileUrl);
    else if (audioPlayer.state != AudioPlayerState.PLAYING)
      result = await audioPlayer.play(sermonModel.sermonFileUrl);
    if (result != 1 && audioPlayer.state != AudioPlayerState.PLAYING) {
      Toast.show('Can\'t play audio.', context,
          backgroundColor: Colors.red.shade700, duration: Toast.LENGTH_LONG);
    } else {
      setState(() {
        isPlaying = true;
      });
      print('should play audio ' + result.toString());
    }
  }

  pauseAudio(AudioPlayer audioPlayer, BuildContext context) async {
    int result = await audioPlayer.pause();
    if (result != 1) {
      Toast.show('Can\'t play audio.', context,
          backgroundColor: Colors.red.shade700, duration: Toast.LENGTH_LONG);
    } else {
      setState(() {
        isPlaying = false;
        isPaused = true;
      });
    }
  }

  bool isPlaying = false;
  bool isPaused = false;
  double sliderValue = 0;
  int hours = 0;
  int seconds = 0;
  int minutes = 0;
  int maxSeconds = 0;
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
    if (widget.audioPlayer.state == AudioPlayerState.PLAYING) {
      setState(() {
        isPaused = false;
        isPlaying = true;
      });
    }
    widget.audioPlayer.onDurationChanged.listen((event) {
      if (maxSeconds != event.inSeconds) {
        setState(() {
          maxSeconds = event.inSeconds;
        });
      }
    });
    widget.audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        hours = event.inHours;
        seconds = event.inSeconds;
        if (seconds > 59) seconds = seconds % 60;
        minutes = event.inMinutes;
        if (minutes > 59) minutes = seconds % 60;
        sliderValue = event.inSeconds.toDouble();
      });
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    spreadRadius: 0)
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: AssetImage('assets/images/logo2.png'),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          widget.sermonModel.sermonTitle,
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          widget.sermonModel.sheekhInfo.sheekhName,
        ),
        Slider(
          onChanged: (va) {},
          max: maxSeconds.toDouble(),
          min: 0,
          value: sliderValue.toDouble(),
          activeColor: Color(0xff5e35b1),
        ),
        SizedBox(
          height: 20,
          child: Text(getHours() + ':' + getMinutes() + ':' + getSeconds()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () async {
                widget.audioPlayer.seek(Duration(
                    milliseconds:
                        (await widget.audioPlayer.getCurrentPosition() -
                            5000)));
              },
              icon: Icon(FontAwesomeIcons.fastBackward),
            ),
            IconButton(
              iconSize: 50,
              onPressed: () {
                if (isPlaying)
                  pauseAudio(widget.audioPlayer, context);
                else
                  playAudio(widget.audioPlayer, widget.sermonModel, context);
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
              onPressed: () async {
                int currentPosition =
                    await widget.audioPlayer.getCurrentPosition();
                Toast.show(currentPosition.toString(), context);
                widget.audioPlayer.seek(Duration(
                    milliseconds:
                        (await widget.audioPlayer.getCurrentPosition() +
                            5000)));
              },
              icon: Icon(FontAwesomeIcons.fastForward),
            ),
          ],
        )
      ],
    );
  }
}
