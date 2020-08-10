import 'package:http/http.dart' as http;
class CustomHttpRequestModel {

  static const String siteUrl = 'https://daarularqam.drongo.vip/';

  makeApiRequest({url,body})async{
    if(body == null)
      body = {};
    url = siteUrl+url;
    http.Response  response = await http.post(url,body: body, headers: {'Accept' :'application/json'});

    return response;

  }
}