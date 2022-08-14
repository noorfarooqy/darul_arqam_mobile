import 'package:audioplayers/audioplayers.dart';
import 'package:darularqam/models/LessonModel.dart';
import 'package:flutter/material.dart';


class LessonListViewBuilder extends StatelessWidget {
  const LessonListViewBuilder({
    Key key,
    @required this.lessons,
  }) : super(key: key);

  final List<LessonModel> lessons;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        AudioPlayer audioPlayer;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 20,
                  minRadius: 10,
                  backgroundColor: Colors.blue,
                  child: Text(
                    lessons[index].lessonNumber.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width:MediaQuery.of(context).size.width * 0.65,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                lessons[index].lessonTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(lessons[index]
                                  .sheekhInfo
                                  .sheekhName),
                              Text(
                                double.parse(lessons[index]
                                    .lessonFileSize
                                    .toString())
                                    .toStringAsFixed(2) +
                                    ' MB',
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          child:
                          Icon(Icons.play_circle_outline),
                          onTap: ()async{
                            audioPlayer = AudioPlayer();
                            Navigator.pushNamed(context,
                                '/audioPlayerScreen', arguments: {
                                  'lessonModel' : lessons[index],
                                  'audioPlayer' : audioPlayer,
                                });
                          },

                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}