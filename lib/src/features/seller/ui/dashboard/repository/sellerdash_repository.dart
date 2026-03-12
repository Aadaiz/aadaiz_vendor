import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../services/api_service.dart';
import '../../../../../services/http_services.dart';
import '../model/sellerdash_model.dart';

class DashRepository {
  static final HttpHelper _http = HttpHelper();
  Future<SellerDashRes> sellerDashApi(String filter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      var url = '${Api.sellerdash}?token=$token&filter=$filter';

      var response = await _http.get(url);
      log("Raw API Response: $response");

      final decodedResponse = json.decode(response);
      SellerDashRes res = SellerDashRes.fromJson(decodedResponse);

      return res;
    } catch (e) {
      log("Error in SellerDashApi: $e");
      rethrow;
    }
  }
}