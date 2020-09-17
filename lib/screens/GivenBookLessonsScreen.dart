import 'package:darularqam/models/ApiRequestNames.dart';
import 'package:darularqam/models/BookModel.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/LessonModel.dart';
import 'package:darularqam/widgets/ErrorWidget.dart';
import 'package:darularqam/widgets/LessonListViewBuilder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:toast/toast.dart';

class GivenBookLessonsScreen extends StatelessWidget {
  getGivenBookLessons(BookModel bookModel, BuildContext context) async {
    CustomHttpRequestModel requestModel = CustomHttpRequestModel();
    Response response = await requestModel.makeApiRequest(
        url: ApiRequestName.getGivenBookLessons + bookModel.bookId.toString());

    if (response.statusCode != 200) return -1;
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["isSuccess"] == false) {
      Toast.show(jsonResponse["errorMessage"].toString(), context,
          backgroundColor: Colors.red, duration: Toast.LENGTH_LONG);
    }
    var lessonList = jsonResponse["data"]["casharada"];
    int lessonCount = lessonList.length;
    List<LessonModel> lessons = [];
    for (int i = 0; i < lessonCount; i++) {
      lessonList[i]["book_info"] = bookModel;
      lessons.add(LessonModel(lessonList[i]));
    }
    return lessons;
  }

  @override
  Widget build(BuildContext context) {
    BookModel bookModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Row(
          children: <Widget>[
            Image(
              height: 25,
              image: AssetImage('assets/images/logo2.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  bookModel.bookName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: ColorCodesModel.swatch4,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getGivenBookLessons(bookModel, context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            String errorMessage = 'Embarrassing. Something went wrong.';
            return CustomErrorWidget(errorMessage: errorMessage);
          }
          if (snapshot.data == -1) {
            String errorMessage = 'Embarrassing. We are having server issues.';
            return CustomErrorWidget(errorMessage: errorMessage);
          }
          if (snapshot.data.length <= 0) {
            String errorMessage = 'Wax cashar ah kuma jiro buugaan';
            return CustomErrorWidget(errorMessage: errorMessage);
          }
          return LessonListViewBuilder(
            lessons: snapshot.data,
          );
        },
      ),
    );
  }
}
