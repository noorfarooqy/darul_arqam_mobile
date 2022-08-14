import 'dart:convert';

import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/services/default_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SheekhServices extends DefaultServices {
  getLatestSheekhs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sheekhList =
        jsonDecode(sharedPreferences.getString('latest_sheekhs') ?? '[]');
    if (sheekhList.isNotEmpty) {
      print('found existing list');
      return;
    }

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

  List sheekhList = [];
}
