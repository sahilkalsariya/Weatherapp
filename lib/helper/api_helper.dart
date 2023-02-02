import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_app/%20models/post_model.dart';

class APIHelper {
  APIHelper._();

  static final APIHelper apihelper = APIHelper._();

  Future<Weather?> fetchData({String city = "surat"}) async {
    String apiKey = "c9470f2e46ed0f3e878b172fa3f55322"; // website par sign up karvathi link male..
    String api = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey"; // webisite ni api mle aahiya call karvni.

    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      Map decodedata = jsonDecode(res.body);

      Weather weather = Weather.fromJson(json: decodedata);

      return weather;
    } else {
      return null;
    }
  }
}
