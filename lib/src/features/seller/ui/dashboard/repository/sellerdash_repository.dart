import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../services/api_service.dart';
import '../../../../../services/http_services.dart';
import '../model/sellerdash_model.dart';

class dashRepository {
  static final HttpHelper _http = HttpHelper();
  Future<SellerdashRes> SellerdashApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      var url = '${Api.sellerdash}?token=$token';

      var response = await _http.get(url);
      log("Raw API Response: $response");

      final decodedResponse = json.decode(response);
      SellerdashRes res = SellerdashRes.fromJson(decodedResponse);

      return res;
    } catch (e) {
      log("Error in SellerdashApi: $e");
      rethrow;
    }
  }
}