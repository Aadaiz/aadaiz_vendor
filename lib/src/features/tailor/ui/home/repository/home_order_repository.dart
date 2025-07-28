
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../../services/api_service.dart';
import '../../../../../services/http_services.dart';
import '../../../../auth/model/add_image.dart';
import '../model/home_order_model.dart';


class TailorOrderRepository {
  static final HttpHelper _http = HttpHelper();
  Future uploadImage({image}) async
  {
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
      for (var field in formData.fields) {
      }

      Response response = await dio.post(
          Api.uploadImage,
          data: formData,
          options: Options(headers: {
            "Accept": "application/json",
          }));
      // body: data,
      // headers: {
      //   "Accept": "application/json",
      //   'Authorization': 'Bearer $token',
      // });

      // var jsonresponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return  AddImage.fromJson(response.data);
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

  Future<dynamic> orderstatusApi({required dynamic body}) async {
    try {
      var response = await _http.post(Api.updatetailororderstatus, body, contentType: true);
      log("Raw API Response: $response");

      // final decodedResponse = json.decode(response);
      //ProductResponse res = ProductResponse.fromJson(decodedResponse);

      return  json.decode(response);
    } catch (e) {
      log("Error in orderstatusApi: $e");
      rethrow;
    }
  }

  Future<dynamic> orderApi(String? type, String?token,dynamic page) async {
    try {
      var response = await _http.get("${Api.tailorOrderList}?status=${type}&token=${token}&page=${page}");
      log("Raw API Response: $response");

      final decodedResponse = json.decode(response);
      TailorOrderRes res = TailorOrderRes.fromJson(decodedResponse);

      return  res;
    } catch (e) {
      log("Error in productApiget: $e");
      rethrow;
    }
  }
}