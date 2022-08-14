import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/SheekhModel.dart';
import 'package:darularqam/screens/CategoriesScreen.dart';
import 'package:darularqam/services/book_services.dart';
import 'package:darularqam/services/lesson_services.dart';
import 'package:darularqam/services/sheekh_services.dart';
import 'package:darularqam/widgets/custom_app_bar.dart';
import 'package:darularqam/widgets/custom_bottom_navigation.dart';
import 'package:darularqam/widgets/custom_error_widget.dart';
import 'package:darularqam/widgets/sheekh_gridview_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'dart:convert' as convert;

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({this.pageIndex});

  final int pageIndex;
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  getLatestSheikhList() async {
    SheekhServices sheekhServices = SheekhServices();
    await sheekhServices.getLatestSheekhs();
    return sheekhServices;
  }

  getLatestBooks() async {
    BookServices bookServices = BookServices();
    await bookServices.getLatestBooks();
    return bookServices;
  }

  getLatestLessons() async {
    LessonServices lessonServices = LessonServices();
    await lessonServices.getLatestLessons();
    return lessonServices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Sheekhs',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: getLatestSheikhList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SheekhGridShimmer();
                }

                if (snapshot.hasError) {
                  return CustomErrorWidget(
                      errorMessage: snapshot.error.toString());
                }

                SheekhServices sheekhServices = snapshot.data as SheekhServices;
                if (sheekhServices.errorStatus) {
                  return CustomErrorWidget(
                      errorMessage: sheekhServices.errorMessage);
                }

                int sheekhLength = sheekhServices.sheekhList.length;
                int sheekhLengthTwo = 0;
                print(sheekhServices.sheekhList.length);
                if (sheekhLength > 6) {
                  sheekhLength = int.parse((sheekhLength % 2 == 0
                          ? sheekhLength / 2
                          : ((sheekhLength - 1) / 2 + 1))
                      .round()
                      .toString());
                  sheekhLengthTwo = int.parse(
                      (sheekhServices.sheekhList.length % 2 == 0
                              ? sheekhServices.sheekhList.length / 2
                              : ((sheekhServices.sheekhList.length - 1) / 2))
                          .round()
                          .toString());
                }
                print(sheekhLength);
                print(sheekhLengthTwo);
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: sheekhLength,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: ColorCodesModel.swatch1,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/logo2.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      sheekhServices.sheekhList[index]
                                          ['sheekh_name'],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: sheekhLengthTwo,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: ColorCodesModel.swatch1,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/logo2.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      sheekhServices.sheekhList[index]
                                          ['sheekh_name'],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Books',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: getLatestBooks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SheekhGridShimmer();
                }

                if (snapshot.hasError) {
                  return CustomErrorWidget(
                      errorMessage: snapshot.error.toString());
                }

                BookServices bookServices = snapshot.data as BookServices;
                if (bookServices.errorStatus) {
                  return CustomErrorWidget(
                      errorMessage: bookServices.errorMessage);
                }

                int bookLength = bookServices.bookList.length;
                int bookLengthTwo = 0;
                if (bookLength > 6) {
                  bookLength = int.parse((bookLength % 2 == 0
                          ? bookLength / 2
                          : ((bookLength - 1) / 2 + 1))
                      .round()
                      .toString());
                  bookLengthTwo = int.parse(
                      (bookServices.bookList.length % 2 == 0
                              ? bookServices.bookList.length / 2
                              : ((bookServices.bookList.length - 1) / 2))
                          .round()
                          .toString());
                }
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: bookLength,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: ColorCodesModel.swatch1,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(bookServices
                                            .bookList[index]['book_icon_url']),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      bookServices.bookList[index]['book_name'],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: bookLengthTwo,
                          itemBuilder: (context, index) {
                            index += bookLength;
                            return Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: ColorCodesModel.swatch1,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(bookServices
                                            .bookList[index]['book_icon_url']),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      bookServices.bookList[index]['book_name'],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Lessons',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: getLatestLessons(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SheekhGridShimmer();
                }

                if (snapshot.hasError) {
                  return CustomErrorWidget(
                      errorMessage: snapshot.error.toString());
                }

                LessonServices lessonServices = snapshot.data as LessonServices;
                if (lessonServices.errorStatus) {
                  return CustomErrorWidget(
                      errorMessage: lessonServices.errorMessage);
                }

                int lessonLength = lessonServices.lessonsList.length;
                int lessonLengthTwo = 0;
                if (lessonLength > 6) {
                  lessonLength = int.parse((lessonLength % 2 == 0
                          ? lessonLength / 2
                          : ((lessonLength - 1) / 2 + 1))
                      .round()
                      .toString());
                  lessonLengthTwo = int.parse(
                      (lessonServices.lessonsList.length % 2 == 0
                              ? lessonServices.lessonsList.length / 2
                              : ((lessonServices.lessonsList.length - 1) / 2))
                          .round()
                          .toString());
                }
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: lessonLength,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: ColorCodesModel.swatch1,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/audio_icon.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      lessonServices.lessonsList[index]
                                          ['lesson_title'],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: lessonLengthTwo,
                          itemBuilder: (context, index) {
                            index += lessonLength;
                            return Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: ColorCodesModel.swatch1,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/audio_icon.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      lessonServices.lessonsList[index]
                                          ['lesson_title'],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
