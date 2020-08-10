import 'package:darularqam/models/ApiRequestNames.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/SheekhModel.dart';
import 'package:darularqam/widgets/CustomBottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';
import 'dart:convert' as convert;

class HomePageScreen extends StatelessWidget {
  HomePageScreen({this.pageIndex});
  final pageIndex;
  getSheekhList(BuildContext context) async {
    CustomHttpRequestModel requestModel = CustomHttpRequestModel();

    Response response = await requestModel
        .makeApiRequest(url: ApiRequestName.getSheekhsList, body: {});

    if (response.statusCode != 200) {
      Toast.show('Server error - ', context,
          backgroundColor: Colors.red, duration: Toast.LENGTH_LONG);
      return -1;
    }

    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["isSuccess"] == false) {
      Toast.show(jsonResponse["errorMessage"].toString(), context,
          backgroundColor: Colors.red, duration: Toast.LENGTH_LONG);
    }
    var sheekhList = jsonResponse["data"];
    int sheekhCount = sheekhList.length;
    List<SheekhModel> sheekhs = [];
    for (int i = 0; i < sheekhCount; i++) {
      sheekhs.add(SheekhModel(sheekhList[i]));
    }
    return sheekhs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCodesModel.swatch1,
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
                Expanded(
                  child: FutureBuilder(
                    future: getSheekhList(context),
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
                      List<SheekhModel> sheekhs = snapshot.data;
                      var orientation = MediaQuery.of(context).orientation;
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: GridView.builder(
                          itemCount: sheekhs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                (orientation == Orientation.portrait) ? 2 : 3,
                            crossAxisSpacing: 7.0,
                            mainAxisSpacing: 7.0,
                          ),
                          itemBuilder: (context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Image.asset(
                                        'assets/images/islamicAudioIcon.png',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 5),
                                    child: Text(
                                      sheekhs[index].sheekhName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, top: 8.0,bottom: 8.0),
                                    child: Text(
                                      sheekhs[index].bookCount.toString() +' kitaab',
                                      style: TextStyle(),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
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
        currentIndex: pageIndex,
      ),
    );
  }
}
