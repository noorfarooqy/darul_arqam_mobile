import 'dart:convert';

import 'package:darularqam/models/BookCategoriesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/models/SheekhModel.dart';
import 'package:darularqam/services/default_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SheekhServices extends DefaultServices {
  getLatestSheekhs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sheekhList =
    //     jsonDecode(sharedPreferences.getString('latest_sheekhs') ?? '[]');
    // if (sheekhList.isNotEmpty) {
    //   print('found existing list');
    //   return;
    // }

    CustomHttpRequestModel requestModel = CustomHttpRequestModel();

    await requestModel.getRequest(uri: ApiEndpoints.getSheekhsList);

    if (requestModel.errorStatus) {
      setError(requestModel.errorMessage);
    } else
      sheekhList = requestModel.response['data'] as List;
    if (sheekhList.isNotEmpty) {
      await sharedPreferences.setString(
          'latest_sheekhs', jsonEncode(sheekhList));
    }
  }

  getGivenSheekhBooks(
      SheekhModel sheekhModel, BookCategoriesModel category) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // bookList = jsonDecode(sharedPreferences
    //         .getString('books_' + sheekhModel.sheekhId.toString()) ??
    //     '[]');
    // if (bookList.isNotEmpty) {
    //   print('found existing list');
    //   return;
    // }

    CustomHttpRequestModel requestModel = CustomHttpRequestModel();

    await requestModel.getRequest(
        uri:
            "${ApiEndpoints.getSheekhCategoryBooks}${sheekhModel.sheekhId?.toString()}/${category.categoryId.toString()}");

    if (requestModel.errorStatus) {
      setError(requestModel.errorMessage);
    } else
      bookList = requestModel.response['data'] as List;
    if (bookList.isNotEmpty) {
      await sharedPreferences.setString(
          'books_' + sheekhModel.sheekhId.toString(), jsonEncode(bookList));
    }
  }

  getGivenSheekhCategories(SheekhModel sheekhModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // categoriesList = jsonDecode(sharedPreferences
    //         .getString('categories_' + sheekhModel.sheekhId.toString()) ??
    //     '[]');
    // if (categoriesList.isNotEmpty) {
    //   print('found existing list');
    //   return;
    // }

    CustomHttpRequestModel requestModel = CustomHttpRequestModel();

    await requestModel.getRequest(
        uri: ApiEndpoints.getSheekhCategoryList +
            sheekhModel.sheekhId?.toString());

    if (requestModel.errorStatus) {
      setError(requestModel.errorMessage);
    } else
      categoriesList = requestModel.response['data'] as List;
    if (categoriesList.isNotEmpty) {
      await sharedPreferences.setString(
          'categories_' + sheekhModel.sheekhId.toString(),
          jsonEncode(categoriesList));
    }
  }

  List categoriesList = [];
  List bookList = [];
  List sheekhList = [];
}
