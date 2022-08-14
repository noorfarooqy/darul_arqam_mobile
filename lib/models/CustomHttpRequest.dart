import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CustomHttpRequestModel {
  static const String siteUrl = 'http://daarul_arqam_web.test/';
//   static const String siteUrl = 'https://daarularqam.drongo.vip/';

  // static const String siteUrl = 'http://127.0.0.1:8000/';
  String errorMessage = '';
  bool errorStatus = false;
  var response;
  makeApiRequest({url, body}) async {
    if (body == null) body = {};
    url = siteUrl + url;
    print('requesting ' + url);
    http.Response response = await http.post(Uri.parse(url),
        body: body, headers: {'Accept': 'application/json'});

    return response;
  }

  postRequest({uri, body = const {}}) async {
    try {
      var url = siteUrl + uri;
      print('requesting ' + url);
      http.Response resp = await http.post(Uri.parse(url), body: body);
      checkResponse(resp);
    } catch (e) {
      setError(e.toString());
    }
  }

  getRequest({uri, body = const {}}) async {
    try {
      var url = siteUrl + uri;
      print('Get requesting ' + url);
      http.Response resp = await http
          .get(Uri.parse(url), headers: {'Accept': 'application/json'});
      checkResponse(resp);
    } catch (e) {
      setError(e.toString());
    }
  }

  checkResponse(http.Response resp) {
    print(resp.body);
    if (resp.statusCode != 200) {
      this.setResponseErrorMessage(resp);
    }
    response = convert.jsonDecode(resp.body);
    if (response['message'] != null) {
      setError(response['message'].toString());
    }
    // response = response['da'];
    if (response['error_status'] == true) {
      setError(response['error_message'].toString());
    }
  }

  setError(String e) {
    errorStatus = true;
    errorMessage = e;
  }

  setResponseErrorMessage(http.Response resp) {
    errorStatus = true;
    Map body = convert.jsonDecode(resp.body);
    if (body['message'] != null) {
      errorMessage = body['message'];
    } else if (body['error_message'] != null) {
      errorMessage = body['error_message'];
    }
  }
}
