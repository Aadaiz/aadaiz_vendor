import 'dart:convert';
import 'dart:developer';

import 'package:aadaiz_seller/src/features/seller/ui/profile/model/payment_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../services/api_service.dart';
import '../../../../../services/http_services.dart';
import '../model/location_model.dart';
import '../model/profile_details_model.dart';
import '../model/profile_model.dart';
import '../model/support_model.dart';

class ProfileRepository {
  static final HttpHelper _http = HttpHelper();

  Future<MyProfileRes> addressApi({
    required dynamic body,
    dynamic module,
  }) async {
    try {
      var response = await _http.post(
        module == 'seller' ? Api.selleraddress : Api.tailorAddress,
        body,
        contentType: true,
      );
      log("Raw API Response: $response");

      final decodedResponse = json.decode(response);
      MyProfileRes res = MyProfileRes.fromMap(decodedResponse);

      return res;
    } catch (e) {
      log("Error in addressApi: $e");
      rethrow;
    }
  }

  Future<MyProfileRes> createsupportApi({required dynamic body}) async {
    try {
      var response = await _http.post(Api.support, body, contentType: true);
      log("Raw API Response: $response");

      final decodedResponse = json.decode(response);
      MyProfileRes res = MyProfileRes.fromMap(decodedResponse);

      return res;
    } catch (e) {
      log("Error in addressApi: $e");
      rethrow;
    }
  }

  Future<MysupportRes> SupportListApi({int page = 1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      var url = '${Api.support}?token=$token&page=$page';

      var response = await _http.get(url);
      log("Raw API Response: $response");

      final decodedResponse = json.decode(response);
      MysupportRes res = MysupportRes.fromMap(decodedResponse);

      return res;
    } catch (e) {
      log("Error in SupportListApi: $e");
      rethrow;
    }
  }

  Future<MyPaymentRes> getPaymentListApi({int page = 1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await _http.get('${Api.payment}?token=$token&page=$page');

    final res = jsonDecode(response);

    return MyPaymentRes.fromMap(res);
  }

  Future<ProfileRes> getprofiledetailApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await _http.get('${Api.profiledetail}?token=$token');
    final res = jsonDecode(response);
    ProfileRes data = ProfileRes.fromMap(res);
    return data;
  }

  Future<dynamic> updateprofileApi({required dynamic body}) async {
    try {
      var response = await _http.post(
        Api.updateProfile,
        body,
        contentType: true,
      );
      log("Raw API Response: $response");

      // final decodedResponse = json.decode(response);
      //ProductResponse res = ProductResponse.fromJson(decodedResponse);

      return json.decode(response);
    } catch (e) {
      log("Error in productApi: $e");
      rethrow;
    }
  }

  Future<CountryStateCityModel> getCountries() async {
    try {
      final response = await _http.get(Api.countries);
      final data = jsonDecode(response);

      return CountryStateCityModel.fromMap(data);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

   Future<CountryStateCityModel> getStates(int countryId) async {
    try {
      final response = await _http.get("${Api.state}/$countryId");

      final data = jsonDecode(response);

      return CountryStateCityModel.fromMap(data);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

   Future<CountryStateCityModel> getCities(int stateId) async {
    try {
      final response = await _http.get("${Api.city}/$stateId");

      final data = jsonDecode(response);

      return CountryStateCityModel.fromMap(data);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
