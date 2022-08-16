import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/models/BookModel.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/services/book_services.dart';
import 'package:darularqam/widgets/book_list_widget.dart';
import 'package:darularqam/widgets/books_listview_shimmer.dart';
import 'package:darularqam/widgets/custom_app_bar.dart';
import 'package:darularqam/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:toast/toast.dart';

class BuugaagtaScreen extends StatelessWidget {
  BuugaagtaScreen({this.pageIndex});
  final pageIndex;

  getBookList(BuildContext context) async {
    BookServices bookServices = BookServices();
    await bookServices.getLatestBooks();
    List bookList = bookServices.bookList;
    int bookCount = bookList.length;
    List<BookModel> books = [];
    for (int i = 0; i < bookCount; i++) {
      books.add(BookModel(bookList[i]));
    }
    return books;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(),
      body: SafeArea(
        child: Stack(
          // overflow: Overflow.visible,
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: FutureBuilder(
                    future: getBookList(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return BooksListViewShimmer();
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
                      return BookListBuilder(books: books);
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
