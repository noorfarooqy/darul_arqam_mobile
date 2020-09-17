import 'package:darularqam/models/ApiRequestNames.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/SermonModel.dart';
import 'package:darularqam/widgets/CustomBottomNavigation.dart';
import 'package:darularqam/widgets/SermonListViewBuilder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:toast/toast.dart';

class SermonScreen extends StatelessWidget {
  getSermonsList(BuildContext context) async {
    CustomHttpRequestModel requestModel = CustomHttpRequestModel();
    Response response =
        await requestModel.makeApiRequest(url: ApiRequestName.getLatestSermons);

    if (response.statusCode != 200) return -1;
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["isSuccess"] == false) {
      Toast.show(jsonResponse["errorMessage"].toString(), context,
          backgroundColor: Colors.red, duration: Toast.LENGTH_LONG);
    }
    var lessonList = jsonResponse["data"];
    int lessonCount = lessonList.length;
    List<SermonModel> sermons = [];
    for (int i = 0; i < lessonCount; i++) {
      sermons.add(SermonModel(lessonList[i]));
    }
    return sermons;
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
                    'Muxaadarooyinka / Qudbooyinka',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: getSermonsList(context),
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
                      List<SermonModel> sermons = snapshot.data;
                      if (sermons.length <= 0) {
                        return Center(
                          child: Text('Wax Muxaadaro ah kuma jiro'),
                        );
                      }
                      return SermonListViewBuilder(
                        sermons: sermons,
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BuildCustomBottomNavigationWidget(
        currentIndex: 3,
      ),
    );
  }
}
