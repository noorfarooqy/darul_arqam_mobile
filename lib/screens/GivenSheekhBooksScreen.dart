import 'package:darularqam/models/ApiRequestNames.dart';
import 'package:darularqam/models/BookModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/SheekhModel.dart';
import 'package:darularqam/widgets/BookListWidget.dart';
import 'package:darularqam/widgets/ErrorWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:toast/toast.dart';
class GivenSheekhBooksScreen extends StatelessWidget {
  
  getGivenSheekhBooks(SheekhModel sheekhModel,BuildContext context)async{
    CustomHttpRequestModel requestModel = CustomHttpRequestModel();
    Response response =
    await requestModel.makeApiRequest(
        url: ApiRequestName.getGivenSheekhBooks+sheekhModel.sheekhId.toString());

    if (response.statusCode != 200) return -1;
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["isSuccess"] == false) {
      Toast.show(jsonResponse["errorMessage"].toString(), context,
          backgroundColor: Colors.red, duration: Toast.LENGTH_LONG);
    }
    var bookLIst = jsonResponse["data"]["books"];
    int bookCount = bookLIst.length;
    List<BookModel> books = [];
    for (int i = 0; i < bookCount; i++) {
      books.add(BookModel(bookLIst[i], sheekhModel: sheekhModel));
    }
    return books;
  }
  
  @override
  Widget build(BuildContext context) {
    SheekhModel givenSheekh = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
      ),
      body: FutureBuilder(
        future: getGivenSheekhBooks(givenSheekh, context),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            print(snapshot.error);
            String errorMessage = 'Embarrassing. Something went wrong.';
            return CustomErrorWidget(errorMessage: errorMessage);
          }
          if(snapshot.data == -1){
            String errorMessage = 'Embarrassing. We are having server issues.';
            return CustomErrorWidget(errorMessage: errorMessage);
          }
          return BookListBuilder(books: snapshot.data,);
        },
      ),
    );
  }
}