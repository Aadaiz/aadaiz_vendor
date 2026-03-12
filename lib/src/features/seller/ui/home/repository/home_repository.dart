import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../services/api_service.dart';
import '../../../../../services/http_services.dart';
import '../../../../auth/model/add_image.dart';
import '../model/SellerOrder_model.dart';
import '../model/home_model.dart';
import '../model/notification_model.dart';
import '../model/tracking_model.dart';

class HomeRepository {
  static final HttpHelper _http = HttpHelper();
  Future uploadImage({image}) async {
    String fileNames = '';
    if (image != '') {
      fileNames = image.toString().split('/').last;
    }
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          image.toString(),
          filename: fileNames.toString(),
          // contentType: MediaType(
          //   "image",
          //   "jpg",
          // ),
        ),
      });
      for (var field in formData.fields) {}

      Response response = await dio.post(
        Api.uploadImage,
        data: formData,
        options: Options(headers: {"Accept": "application/json"}),
      );
      // body: data,
      // headers: {
      //   "Accept": "application/json",
      //   'Authorization': 'Bearer $token',
      // });

      // var jsonresponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddImage.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioException) {
        var response = e.response;
        if (response != null) {
          print('Request failed with status code ${response.statusCode}');
          print('Error response: ${response.data}');
        } else {
          print('Request failed with an error');
        }
      } else {
        print('Error: $e');
      }
    }
  }

  Future<dynamic> productaddApi({required dynamic body}) async {
    try {
      var response = await _http.post(Api.order, body, contentType: true);
      log("Raw API Response: $response");

      // final decodedResponse = json.decode(response);
      //ProductResponse res = ProductResponse.fromJson(decodedResponse);

      return json.decode(response);
    } catch (e) {
      log("Error in productApi: $e");
      rethrow;
    }
  }

  Future<dynamic> orderstatusApi({required dynamic body}) async {
    try {
      var response = await _http.post(
        Api.updateorderstatus,
        body,
        contentType: true,
      );
      log("Raw API Response: $response");

      // final decodedResponse = json.decode(response);
      //ProductResponse res = ProductResponse.fromJson(decodedResponse);

      return json.decode(response);
    } catch (e) {
      log("Error in orderstatusApi: $e");
      rethrow;
    }
  }

  Future<ProductResponse> productApi({required dynamic body}) async {
    try {
      log("========== PRODUCT API (GET LIST) ==========");

      log("API URL: ${Api.order}");

      log("Headers:");
      log({"Content-Type": "application/json"}.toString());

      log("Request Body:");
      log(body.toString());

      log("========== API CALL START ==========");

      var response = await _http.post(Api.order, body, contentType: true);

      log("========== API CALL END ==========");

      log("Raw API Response:");
      log(response.toString());

      final decodedResponse = json.decode(response);
      log("Decoded JSON Response:");
      log(decodedResponse.toString());

      ProductResponse res = ProductResponse.fromJson(decodedResponse);
      log("Parsed ProductResponse Model:");
      log(res.toString());

      log("========== PRODUCT API SUCCESS ==========");

      return res;
    } catch (e, stackTrace) {
      log("========== PRODUCT API ERROR ==========");
      log("Error: $e");
      log("StackTrace: $stackTrace");
      log("=======================================");
      rethrow;
    }
  }

  Future<dynamic> orderApi(String? type, String? token, dynamic page) async {
    try {
      var response = await _http.get(
        "${Api.orderList}?status=${type}&token=${token}&page=${page}",
      );
      log("Raw API Response: $response");

      final decodedResponse = json.decode(response);
      SellerOrderRes res = SellerOrderRes.fromJson(decodedResponse);

      return res;
    } catch (e) {
      log("Error in productApiget: $e");
      rethrow;
    }
  }
  Future<dynamic> getTrackingData(trackId) async {
    var response = await _http.get(
      "${Api.trackingData}/$trackId",
    );
    log("Raw API Response: $response");

    final decodedResponse = json.decode(response);
    TrackingModel res = TrackingModel.fromJson(decodedResponse);

    return res;

  }
  Future<NotificationRes> getNotificationListApi({int page = 1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await _http.get('${Api.notificationList}?token=$token&page=$page');

    final res = jsonDecode(response);

    return NotificationRes.fromMap(res);
  }
}
