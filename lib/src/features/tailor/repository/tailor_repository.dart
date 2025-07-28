import 'dart:convert';

import 'package:aadaiz_seller/src/features/auth/model/category_model.dart';
import 'package:aadaiz_seller/src/features/tailor/model/address_list_model.dart';
import 'package:aadaiz_seller/src/features/tailor/model/address_model.dart';
import 'package:aadaiz_seller/src/features/tailor/model/support_list_model.dart';
import 'package:aadaiz_seller/src/features/tailor/model/tailor_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/api_service.dart';
import '../../../services/http_services.dart';
import '../model/category_list_model.dart';

class TailorRepository {
  static final HttpHelper _http = HttpHelper();

  Future<dynamic> kycTailor({required dynamic body}) async {
    var response = await _http.post(Api.tailorKyc, body, contentType: true);
    TailorAddressRes res = TailorAddressRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> address({required dynamic body}) async {
    var response = await _http.post(Api.tailorAddress, body, contentType: true);
    TailorAddressRes res = TailorAddressRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getAddress({required dynamic body}) async {
    var response = await _http.post(Api.tailorAddress, body, contentType: true);
    TailorAddressListRes res = TailorAddressListRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getOrders(status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await _http.get("${Api.tailorOrderList}?status=$status&token=$token");
    TailorOrderListRes res = TailorOrderListRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getSupport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await _http.get("${Api.tailorSupportList}?token=$token");
    SupportListRes res = SupportListRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getCategory() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vNTIuMi4yMzQuMTIxL3N0YWdpbmcvQWFkYWl6L3B1YmxpYy9pbmRleC5waHAvYXBpL2xvZ2luX3ZlcmlmeV9vdHAiLCJpYXQiOjE3MjUwODMyODgsIm5iZiI6MTcyNTA4MzI4OCwianRpIjoiQnpjOVVQSm5kSVRXWGtiUCIsInN1YiI6IjMiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0._0801M86-B_Bn3zOb3hJdwAFk0dnbKF6amXwPc8DGgM';
    //prefs.getString("token");
    var response = await _http.get("${Api.tailorCategory}?token=$token");
    TailorCategoryListRes res  = TailorCategoryListRes.fromMap(jsonDecode(response));
    return res;
  }
}
