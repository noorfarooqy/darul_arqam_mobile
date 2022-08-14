import 'dart:convert';

import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/services/default_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LessonServices extends DefaultServices {
  getLatestLessons() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    lessonsList =
        jsonDecode(sharedPreferences.getString('latest_lessons') ?? '[]');
    if (lessonsList.isNotEmpty) {
      print('found existing lessons list');
      return;
    }

    CustomHttpRequestModel requestModel = CustomHttpRequestModel();

    await requestModel.getRequest(uri: ApiEndpoints.getLessonsList);

    if (requestModel.errorStatus) {
      setError(requestModel.errorMessage);
    } else
      lessonsList = requestModel.response['data'] as List;
    if (lessonsList.isNotEmpty) {
      await sharedPreferences.setString(
          'latest_lessons', jsonEncode(lessonsList));
    }
  }

  List lessonsList = [];
}
