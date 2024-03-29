import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/models/BookCategoriesModel.dart';
import 'package:darularqam/models/BookModel.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/ScreenArguments.dart';
import 'package:darularqam/models/SheekhModel.dart';
import 'package:darularqam/screens/GivenSheekhBooksScreen.dart';
import 'package:darularqam/services/sheekh_services.dart';
import 'package:darularqam/widgets/books_listview_shimmer.dart';
import 'package:darularqam/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:toast/toast.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({@required this.givenSheekh});
  final SheekhModel givenSheekh;
  static const String screenName = 'CategoriesScreen';
  getCategories(context, SheekhModel sheekhModel) async {
    SheekhServices sheekhServices = SheekhServices();
    await sheekhServices.getGivenSheekhCategories(sheekhModel);
    List catList = sheekhServices.categoriesList;
    print('list');
    print(catList);
    int catLen = catList.length;
    List<BookCategoriesModel> categories = [];
    for (int i = 0; i < catLen; i++) {
      categories.add(BookCategoriesModel(catList[i]));
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorCodesModel.swatch1,
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
                  givenSheekh.sheekhName,
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
        future: getCategories(context, givenSheekh),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return BooksListViewShimmer();
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
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                BookCategoriesModel category = snapshot.data[index];

                return Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                  child: Card(
                    child: GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.adjust,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.categoryName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      category.books.length.toString() +
                                          ' Book(s)',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GivenSheekhBooksScreen(
                                    givenSheekh: givenSheekh,
                                    category: category)));
                      },
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
