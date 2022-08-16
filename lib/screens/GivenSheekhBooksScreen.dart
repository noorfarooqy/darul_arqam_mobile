import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/models/BookCategoriesModel.dart';
import 'package:darularqam/models/BookModel.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/ScreenArguments.dart';
import 'package:darularqam/models/SheekhModel.dart';
import 'package:darularqam/services/book_services.dart';
import 'package:darularqam/services/sheekh_services.dart';
import 'package:darularqam/widgets/book_list_widget.dart';
import 'package:darularqam/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:toast/toast.dart';

class GivenSheekhBooksScreen extends StatelessWidget {
  GivenSheekhBooksScreen({@required this.givenSheekh, @required this.category});

  final SheekhModel givenSheekh;
  final BookCategoriesModel category;
  static const String screenName = '/givenSheekhBooksScreen';
  getGivenSheekhBooks(
      SheekhModel sheekhModel, BookCategoriesModel category) async {
    SheekhServices sheekhServices = SheekhServices();
    await sheekhServices.getGivenSheekhBooks(sheekhModel, category);
    List bookList = sheekhServices.bookList;
    int bookCount = bookList.length;
    List<BookModel> books = [];
    for (int i = 0; i < bookCount; i++) {
      books.add(BookModel(bookList[i], sheekhModel: sheekhModel));
    }
    print('-----done');
    return books;
  }

  @override
  Widget build(BuildContext context) {
    // BookCategoryScreenArgument args = ModalRoute.of(context).settings.arguments;
    // SheekhModel givenSheekh = args.sheekhModel;
    // BookCategoriesModel category = args.categoriesModel;
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
        future: getGivenSheekhBooks(givenSheekh, category),
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
