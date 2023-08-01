import 'dart:convert';

import 'package:api_with_database/screens/home/model/api_model.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static final ApiHelper helper = ApiHelper._();

  ApiHelper._();

  Future<NewsModel> getApi() async {
    String link =
        "https://newsapi.org/v2/everything?q=apple&from=2023-07-01&to=${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}&sortBy=popularity&apiKey=b080f300e173423aa5819f8c3e3e2114";

    var response = await http.get(Uri.parse(link));

    var json = jsonDecode(response.body);

    NewsModel n1 = NewsModel.fromJson(json);

    return n1;
  }
}
