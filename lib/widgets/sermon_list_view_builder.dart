import 'package:audioplayers/audioplayers.dart';
import 'package:darularqam/models/SermonModel.dart';
import 'package:flutter/material.dart';

class SermonListViewBuilder extends StatelessWidget {
  const SermonListViewBuilder({
    Key key,
    @required this.sermons,
  }) : super(key: key);

  final List<SermonModel> sermons;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: sermons.length,
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
                    (index+1).toString(),
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
                                sermons[index].sermonTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(sermons[index]
                                  .sheekhInfo
                                  .sheekhName),
                              Text(
                                double.parse(sermons[index]
                                    .sermonFileSize
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
                                '/sermonAudioPlayer', arguments: {
                                  'sermonModel' : sermons[index],
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
