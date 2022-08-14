import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/models/BookCategoriesModel.dart';
import 'package:darularqam/models/BookModel.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/ScreenArguments.dart';
import 'package:darularqam/models/SheekhModel.dart';
import 'package:darularqam/widgets/book_list_widget.dart';
import 'package:darularqam/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:toast/toast.dart';

class GivenSheekhBooksScreen extends StatelessWidget {
  static const String screenName = '/givenSheekhBooksScreen';
  getGivenSheekhBooks(SheekhModel sheekhModel, BookCategoriesModel category,
      BuildContext context) async {
    CustomHttpRequestModel requestModel = CustomHttpRequestModel();
    Response response = await requestModel.makeApiRequest(
        url: ApiEndpoints.getSheekhCategoryBooks +
            sheekhModel.sheekhId.toString() +
            '/' +
            category.categoryId.toString());

    if (response.statusCode != 200) return -1;
    var jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse["isSuccess"] == false) {
      Toast.show(jsonResponse["errorMessage"].toString(),
          backgroundColor: Colors.red, duration: Toast.lengthLong);
    }
    var bookLIst = jsonResponse["data"]["books"];
    int bookCount = bookLIst.length;
    List<BookModel> books = [];
    for (int i = 0; i < bookCount; i++) {
      books.add(BookModel(bookLIst[i], sheekhModel: sheekhModel));
    }
    print('-----done');
    return books;
  }

  @override
  Widget build(BuildContext context) {
    BookCategoryScreenArgument args = ModalRoute.of(context).settings.arguments;
    SheekhModel givenSheekh = args.sheekhModel;
    BookCategoriesModel category = args.categoriesModel;
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
                  category.categoryName,
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
        future: getGivenSheekhBooks(givenSheekh, category, context),
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
            String errorMessage = 'There no books for this sheekh.';
            return CustomErrorWidget(errorMessage: errorMessage);
          }

          return BookListBuilder(
            books: snapshot.data,
          );
        },
      ),
    );
  }
}
