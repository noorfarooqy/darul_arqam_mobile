import 'dart:convert';

import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/services/default_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SermonServices extends DefaultServices {
  getLatestSermons() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sermonList =
        jsonDecode(sharedPreferences.getString('latest_sermons') ?? '[]');
    if (sermonList.isNotEmpty) {
      print('found existing sermon list');
      return;
    }

    CustomHttpRequestModel requestModel = CustomHttpRequestModel();

    await requestModel.getRequest(uri: ApiEndpoints.getLatestSermons);

    if (requestModel.errorStatus) {
      setError(requestModel.errorMessage);
    } else
      sermonList = requestModel.response['data'] as List;
    if (sermonList.isNotEmpty) {
      await sharedPreferences.setString(
          'latest_sermons', jsonEncode(sermonList));
    }
  }

  List sermonList = [];
}
