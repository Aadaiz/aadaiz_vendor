

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:aadaiz_seller/src/features/auth/model/add_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/api_service.dart';
import '../../../services/http_services.dart';
import '../model/category_model.dart';
import '../model/otp_verify_model.dart';
import '../model/seller_kyc_model.dart';
import '../model/signup_model.dart';

class AuthRepository{
  static final HttpHelper _http = HttpHelper();

  Future<dynamic> signUp({required dynamic body}) async{
    var response =await _http.post(Api.signUp, body,contentType: true);
    SignUpRes res = SignUpRes.fromMap(jsonDecode(response));
    return res;
  }
  Future<dynamic> verifyOtp({required dynamic body}) async{
    var response =await _http.post(Api.verifyOtp, body,contentType: true);
    OtpVerifyRes res = OtpVerifyRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> kyc({required dynamic body}) async{

    var response =await _http.post(Api.kycSeller, body,contentType: true);
    SellerKycRes res = SellerKycRes.fromMap(jsonDecode(response));
    return res;
  }

  Future<dynamic> getCategory() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response =await _http.get(Api.category);
    CategoryListRes res = CategoryListRes.fromMap(jsonDecode(response));
    return res;
  }



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
          // print('Request failed with status code ${response.statusCode}');
          // print('Error response: ${response.data}');
        } else {
          //  print('Request failed with an error');
        }
      } else {
        //  print('Error: $e');
      }
    }
  }

}