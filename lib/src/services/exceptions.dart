import 'package:get/get.dart';
class AppException implements Exception{
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  int code;
  String message;

  FetchDataException(this.message, this.code)
      : super(message, "") {
    print("500 entry");

    if(code==500 || code==502) {}

  }
}

class BadRequestException extends AppException {
  int code;
  String message;

  BadRequestException(this.message, this.code)
      : super(message, "Invalid Request: ") {
    // navigator!.pushNamed('/' + code.toString());
    // String scode = code != null ? code.toString() : '404';
    // Get.to(()=>Error404(errorCode: "404",platForm: "Whoops",));
  }
}

class UnauthorisedException extends AppException {
  int code;
  String message;
  String next;
  var res;

  UnauthorisedException(this.message, this.code,{this.next=""})
      : super(message, "Unauthorised: ") {
    String scode = code != null ? code.toString() : '401';
    //navigator.pushNamed('/login');
    // Utility.log("next screen $next error $res");
    // LoginController.to.otpStatusFor.value="Login";
    Get.back();

    // userPref.token.val=null;
   // Get.to(()=>LoginPage());
    Get.snackbar("Error", message);
    // SnackBarCommon.showSnack("Error", message);
  }
}
