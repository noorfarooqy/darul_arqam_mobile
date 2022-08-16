import 'dart:convert';

import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/models/BookModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/services/default_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookServices extends DefaultServices {
  getLatestBooks() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // bookList = jsonDecode(sharedPreferences.getString('latest_books') ?? '[]');
    // if (bookList.isNotEmpty) {
    //   print('found existing book list');
    //   return;
    // }
    CustomHttpRequestModel requestModel = CustomHttpRequestModel();

    await requestModel.getRequest(uri: ApiEndpoints.getBooksList);

    if (requestModel.errorStatus) {
      setError(requestModel.errorMessage);
    } else
      bookList = requestModel.response['data'] as List;
    if (bookList.isNotEmpty) {
      await sharedPreferences.setString('latest_books', jsonEncode(bookList));
    }
  }

  getBookLessons(BookModel bookModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // bookLessons = jsonDecode(sharedPreferences
    //         .getString('book_lessons' + bookModel.bookId.toString()) ??
    //     '[]');
    // if (bookLessons.isNotEmpty) {
    //   print('found existing book lessons list');
    //   return;
    // }
    CustomHttpRequestModel requestModel = CustomHttpRequestModel();

    await requestModel.getRequest(
        uri: ApiEndpoints.getGivenBookLessons + bookModel.bookId.toString());

    if (requestModel.errorStatus) {
      setError(requestModel.errorMessage);
    } else
      print('setting-data');
    print(requestModel.response['data']);
    bookLessons = requestModel.response['data'] as List;
    if (bookLessons.isNotEmpty) {
      await sharedPreferences.setString(
          'book_lessons' + bookModel.bookId.toString(),
          jsonEncode(bookLessons));
    }
  }

  List bookLessons = [];

  List bookList = [];
}
