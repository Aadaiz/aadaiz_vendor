import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'exceptions.dart';

class HttpHelper {
  Future<dynamic> get(String url, {bool auth = false}) async {
    Map<String, String> hd = await getHeaders(auth);

    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: hd);
      responseJson = _returnResponse(response);
      log("Api URL:$url response ${response.body}");
    } on SocketException {
      throw FetchDataException('No Internet Connection', 500);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body,
      {bool auth = false, bool contentType = true}) async {
    Map<String, String> hd = await getHeaders(auth, contentType: contentType);
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: body, headers: hd);
      log("Api URL:$url body: $body response:${response.body}");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection', 500);
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body,
      {bool auth = false, bool contentType = false}) async {
    Map<String, String> hd = await getHeaders(auth, contentType: contentType);
    dynamic responseJson;
    try {
      final response = await http.put(Uri.parse(url), body: body, headers: hd);
      debugPrint("Api URL:$url body: $body response:${response.body}");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection', 500);
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, dynamic body,
      {bool auth = false, bool contentType = false}) async {
    Map<String, String> hd = await getHeaders(auth, contentType: contentType);
    dynamic responseJson;
    try {
      final response =
          await http.delete(Uri.parse(url), body: body, headers: hd);
      //debugPrint("Api URL:$url body: $body response:${response.body}");
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection", 500);
    }
    return responseJson;
  }

  Future<Response> multipart(
    String url,
    Map<String, dynamic> data,
    Map<String, File> files, {
    bool isImageUpload = false,
    bool auth = false,
  }) async {
    Map<String, String> headers = await getHeaders(auth);

    Dio dio = Dio();
    FormData formData = FormData();

    if (isImageUpload) {
      for (MapEntry<String, File> fileEntry in files.entries) {
        File file = fileEntry.value;
        if (file.existsSync()) {
          String fileName = file.path.split('/').last;
          formData.files.add(
            MapEntry(
              fileEntry.key, // Field name
              MultipartFile.fromFileSync(file.path, filename: fileName),
            ),
          );
        } else {}
      }
    }

    Map<String, String> stringData = {};
    data.forEach((key, value) {
      stringData[key] = value.toString();
    });

    formData.fields.addAll(stringData.entries);
    String formDataString = 'FormData {\n';
    for (var field in formData.fields) {
      formDataString += "  ${field.key}: ${field.value}\n";
    }
    for (var file in formData.files) {
      formDataString += "  ${file.key}: ${file.value.filename}\n";
    }
    formDataString += '}';

    try {
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: headers,
          contentType: 'multipart/form-data',
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //     {bool auth = false, bool contentType = false}) async {
  //   Map<String, String> hd = await getHeaders(auth, contentType: contentType);
  //
  //   debugPrint('Api Post, url $url body : $body header :$hd');
  //   dynamic responseJson;
  //   try {
  //     final response = await http.put(Uri.parse(url), body: body,headers: hd);
  //     debugPrint("api response before decode  ${"${response.statusCode}${response.body}"}");
  //
  //     responseJson = _returnResponse(response);
  //     debugPrint("api response ${"$responseJson"}");
  //     // Utility.log(responseJson);
  //   } on SocketException {
  //     // Utility.log('No net');
  //     throw FetchDataException('No Internet connection', 500);
  //   }
  //   // Utility.log('api post.');
  //   return responseJson;
  // }

  getHeaders(auth, {bool contentType = false}) async {
    //  SharedPreferences prefs=await SharedPreferences.getInstance();
    String location = '';
    // location=prefs.getString("location")??"";
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      // "location":"$location"
      // "Access-Control-Allow-Origin": "*"
    };
    if (contentType == true) {
      headers.addAll({
        HttpHeaders.contentTypeHeader: "application/json",
      });
    } else {
      headers.addAll({
        HttpHeaders.acceptHeader: "application/json",
      });
    }
    // var token=prefs.getString("token");
    // debugPrint("saved token $token");
    // if(token!=null && token.isNotEmpty){
    //   headers.addAll({
    //     HttpHeaders.authorizationHeader: "Bearer $token",
    //   });
    // }
    return headers;
  }
}

dynamic _returnResponse(http.Response response) async {
  if (response.statusCode == 500 || response.statusCode == 502) {
    throw FetchDataException('', 500);
  }
  // var responseBody = jsonDecode(response.body);

  switch (response.statusCode) {
    case 200:
      var responseJson = response.body;
      return responseJson;
    case 404:
      var responseJson = response.body;
      return responseJson;
    case 201:
      var responseJson = response.body;
      return responseJson;
    case 400:
      var responseJson = response.body;
      return responseJson;
    //  var message = "";
    // throw BadRequestException(message.toString(), response.statusCode);
    // var responseJson = response.body;
    // debugPrint("404error$responseJson");
    // return responseJson;
    case 401:
    case 403:
      //Utility.log('object');

      throw UnauthorisedException("", response.statusCode, next: "");

      break;
    case 422:
      var responseJson = response.body;
      return responseJson;
    case 502:
      throw FetchDataException('', 500);
    case 500:
      throw FetchDataException('${json.decode(response.body)['message']}', 500);
    default:
      throw FetchDataException('${json.decode(response.body)['message']}', 500);
  }
}
