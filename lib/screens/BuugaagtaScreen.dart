import 'package:darularqam/models/ApiRequestNames.dart';
import 'package:darularqam/models/BookModel.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/widgets/CustomBottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:toast/toast.dart';
class BuugaagtaScreen extends StatelessWidget {
BuugaagtaScreen({this.pageIndex});
final pageIndex;

getBookList(BuildContext context) async {
  CustomHttpRequestModel requestModel = CustomHttpRequestModel();
  Response response =
  await requestModel.makeApiRequest(url: ApiRequestName.getBooksList);

  if (response.statusCode != 200) return -1;
  var jsonResponse = convert.jsonDecode(response.body);
  if (jsonResponse["isSuccess"] == false) {
    Toast.show(jsonResponse["errorMessage"].toString(), context,
        backgroundColor: Colors.red, duration: Toast.LENGTH_LONG);
  }
  var bookLIst = jsonResponse["data"];
  int bookCount = bookLIst.length;
  List<BookModel> books = [];
  for (int i = 0; i < bookCount; i++) {
    books.add(BookModel(bookLIst[i]));
  }
  return books;
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
                Expanded(
                  child: FutureBuilder(
                    future: getBookList(context),
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
                      List<BookModel> books = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.book,
                                    color: Colors.orange,
                                    size: 100,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                books[index].bookName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                  books[index].sheekhInfo.sheekhName
                                              ),
                                              Text(
                                                books[index].lessonCount.toString()+
                                                    ' duruus',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(Icons.share)
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
