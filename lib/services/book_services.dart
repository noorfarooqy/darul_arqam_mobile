import 'dart:convert';

import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/services/default_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookServices extends DefaultServices {
  getLatestBooks() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bookList = jsonDecode(sharedPreferences.getString('latest_books') ?? '[]');
    if (bookList.isNotEmpty) {
      print('found existing book list');
      return;
    }

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

  List bookList = [];
}
