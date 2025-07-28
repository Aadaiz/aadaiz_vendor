import 'dart:convert';

import 'package:aadaiz_seller/src/features/designer/models/designer_login_model.dart';
import 'package:aadaiz_seller/src/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/http_services.dart';
import '../models/designer_appointment_model.dart';
import '../models/designer_notification_model.dart';
import '../models/designer_profile_model.dart';

class DesignerRepository {
  static final HttpHelper _http = HttpHelper();

  Future<dynamic> login({required dynamic body}) async {
    var response = await _http.post(Api.designerLogin, body, contentType: true);
    DesignerLoginRes res = DesignerLoginRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> sendOtp({required dynamic body}) async {
    var response = await _http.post(Api.sendOtp, body, contentType: true);
    return jsonDecode(response);
  }


  Future<dynamic> verifyOtp({required dynamic body}) async {
    var response = await _http.post(Api.designerVerifyOtp, body, contentType: true);
    return jsonDecode(response);
  }


  Future<dynamic> designerUpdatePassword({required dynamic body}) async {
    var response = await _http.post(Api.designerUpdatePassword, body, contentType: true);
    return jsonDecode(response);
  }

  Future<dynamic> getAppointments(status, page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await _http
        .get('${Api.designerAppointments}?status=$status&token=$token&page=$page');
    DesignerAppointmentRes res =
        DesignerAppointmentRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await _http
        .get('${Api.designerProfile}?token=$token');
    DesignerProfileRes res =
    DesignerProfileRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> updateProfile({required dynamic body}) async {
    var response = await _http.post(Api.designerUpdateProfile, body, contentType: true);
    return jsonDecode(response);
  }

  Future<dynamic> updatePassword({required dynamic body}) async {
    var response = await _http.post(Api.designerUpdatePasswordProfile, body, contentType: true);
    return jsonDecode(response);
  }


  Future<dynamic> getNotification(page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await _http
        .get('${Api.designerNotification}?token=$token&page=$page');
    DesignerNotificationRes res =
    DesignerNotificationRes.fromMap(jsonDecode(response));
    return res;
  }



  Future<dynamic> uploadDesign({required dynamic body}) async {
    var response = await _http.post(Api.uploadDesign, body, contentType: true);
    return jsonDecode(response);
  }



  Future<dynamic> cancelAppointment({required dynamic body}) async {
    var response = await _http.post(Api.cancelAppointment, body, contentType: true);
    return jsonDecode(response);
  }


  Future<dynamic> updateSchedule({required dynamic body}) async {
    var response = await _http.post(Api.updateSchedule, body, contentType: true);
    return jsonDecode(response);
  }
}
