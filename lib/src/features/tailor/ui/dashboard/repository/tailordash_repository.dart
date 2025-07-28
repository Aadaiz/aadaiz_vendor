import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../services/api_service.dart';
import '../../../../../services/http_services.dart';

import '../model/tailordash_model.dart';

class tailordashRepository {
  static final HttpHelper _http = HttpHelper();
  Future<TailordashRes> TailordashApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      var url = '${Api.tailordash}?token=$token';

      var response = await _http.get(url);
      log("Raw API Response: $response");

      final decodedResponse = json.decode(response);
      TailordashRes res = TailordashRes.fromJson(decodedResponse);

      return res;
    } catch (e) {
      log("Error in SellerdashApi: $e");
      rethrow;
    }
  }
}