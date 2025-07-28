import 'dart:convert';
import 'dart:io';

import 'package:aadaiz_seller/src/features/designer/models/designer_login_model.dart';
import 'package:aadaiz_seller/src/features/designer/models/designer_profile_model.dart';
import 'package:aadaiz_seller/src/features/designer/repository/designer_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../res/components/common_toast.dart';
import '../../../utils/routes/routes_name.dart';
import '../../auth/controller/auth_controller.dart';
import '../models/designer_appointment_model.dart';
import '../models/designer_notification_model.dart';
import '../ui/forgot_password/forgot_create_new.dart';
import '../ui/forgot_password/forgot_otp.dart';

class DesignerController extends GetxController {
  static DesignerController get to => Get.put(DesignerController());
  var repo = DesignerRepository();

  var tabSelected = 0.obs;

  var signUpLoading = false.obs;
  var otpToken = ''.obs;

  Future<dynamic> designerLogin(email, password, BuildContext context) async {
    signUpLoading(true);
    final Map<String, dynamic> body = <String, dynamic>{
      "email": email,
      "password": password,
    };
    DesignerLoginRes res = await repo.login(body: jsonEncode(body));
    signUpLoading(false);
    CommonToast.show(msg: res.message ?? '');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('isLogin', 0);
    await prefs.setString('email', email);
    await prefs.setString('token', res.designer!.token);
    Navigator.of(context).pushReplacementNamed(RoutesName.designerHome);
  }

  var sendOtpLoading = false.obs;
  sendOtp(context, email) async {
    sendOtpLoading(true);
    final Map<String, dynamic> body = <String, dynamic>{"email": email};
    final res = await repo.sendOtp(body: jsonEncode(body));
    sendOtpLoading(false);
    CommonToast.show(msg: res['message']);
    // if(res['status']){
    Get.to(() => ForgotOtp(email: email));
    //  }
  }

  var verifyOtpLoading = false.obs;
  verifyOtp(context, email, otp) async {
    verifyOtpLoading(true);
    final Map<String, dynamic> body = <String, dynamic>{
      "email": email,
      "otp": otp,
    };
    final res = await repo.verifyOtp(body: jsonEncode(body));
    verifyOtpLoading(false);
    CommonToast.show(msg: res['message']);
    // if(res['status']){
    Get.to(() => ForgotCreateNewPassword(email: email, otp: otp));
    // }
  }

  var updateOtpLoading = false.obs;
  updatePasswordForgot(context, email, otp, pss, con) async {
    updateOtpLoading(true);
    final Map<String, dynamic> body = <String, dynamic>{
      "email": email,
      "otp": otp,
      "password": pss,
      "password_confirmation": con,
    };
    final res = await repo.designerUpdatePassword(body: jsonEncode(body));
    updateOtpLoading(false);
    CommonToast.show(msg: res['message']);
    //if (res['status']) {
    Navigator.of(context).pushReplacementNamed(RoutesName.loginActivity);
    // }
  }

  var updateProfilePasswordLoading = false.obs;
  updateProfilePassword(old, pss, con) async {
    updateProfilePasswordLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final Map<String, dynamic> body = <String, dynamic>{
      "current_password": old,
      "new_password": pss,
      "new_password_confirmation": con,
      'token': token,
    };
    final res = await repo.updatePassword(body: jsonEncode(body));
    updateProfilePasswordLoading(false);
    CommonToast.show(msg: res['message']);
  }

  var appointmentList = <DesignerAppointment>[].obs;
  final currentPage = 1.obs;
  final totalPages = 1.obs;

  Future<dynamic> getAppointments({
    bool isRefresh = false,
    dynamic status,
  }) async {
    if (isRefresh) {
      currentPage.value = 1;
      appointmentList.clear();
    } else {
      currentPage.value++;
    }
    DesignerAppointmentRes res = await repo.getAppointments(
      status,
      currentPage.value,
    );
    if (res.status == true) {
      totalPages.value = res.data!.lastPage;
      if (res.data!.data!.isNotEmpty) {
        if (isRefresh) {
          appointmentList.value = res.data!.data!;
        } else {
          final newItems = res.data!.data! ?? [];
          appointmentList.addAll(newItems);
        }
      } else {
        appointmentList.clear();
      }
    } else {}
    return true;
  }

  var notificationList = <DesignerNotification>[].obs;
  final notificationCurrentPage = 1.obs;
  final notificationTotalPages = 1.obs;

  Future<dynamic> getNotifications({
    bool isRefresh = false,
    dynamic status,
  }) async {
    if (isRefresh) {
      notificationCurrentPage.value = 1;
      notificationList.clear();
    } else {
      notificationCurrentPage.value++;
    }
    DesignerNotificationRes res = await repo.getNotification(
      notificationCurrentPage.value,
    );
    if (res.status == true) {
      notificationTotalPages.value = res.data!.lastPage;
      if (res.data!.data!.isNotEmpty) {
        if (isRefresh) {
          notificationList.value = res.data!.data!;
        } else {
          final newItems = res.data!.data! ?? [];
          notificationList.addAll(newItems);
        }
      } else {
        notificationList.clear();
      }
    } else {}
    return true;
  }


  var profileLoading =false.obs;
  var scheduleList = <ScheduleData>[].obs;



  Future<dynamic> profile() async {
    profileLoading(true);
      DesignerProfileRes res = await repo.profile();
    profileLoading(false);
    if(res.status==true){
      scheduleList.value = res.data!.scheduleData!;
    }
  }




  Rx<File> image = File('').obs;
  Rx<File> design = File('').obs;
  var updateLoading = false.obs;

  Future<dynamic> uploadProfile(name, email, imag) async {
    updateLoading(true);
    if (image.value.path != '') {
      await AuthController.to.uploadImage();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final Map<String, dynamic> body = <String, dynamic>{
      "name": "${name}",
      "email": "${email ?? ""}",
      "profile_image": AuthController.to.upload.isNotEmpty
          ? AuthController.to.upload[0]
          : imag,
      "token": token,
    };
    final res = await repo.updateProfile(body: jsonEncode(body));
    updateLoading(false);
    CommonToast.show(msg: res['message']);
  }

  Future<dynamic> uploadDesign(appointmentId) async {
    await AuthController.to.uploadImage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final Map<String, dynamic> body = <String, dynamic>{
      "appointment_id": appointmentId,
      "design_image": AuthController.to.upload[0],
      "token": token,
    };
    final res = await repo.uploadDesign(body: jsonEncode(body));
    CommonToast.show(msg: res['message']);
  }

  Future<dynamic> cancelAppointment(appointmentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final Map<String, dynamic> body = <String, dynamic>{
      "appointment_id": appointmentId,
      "token": token,
    };
    final res = await repo.cancelAppointment(body: jsonEncode(body));
    CommonToast.show(msg: res['message']);
  }

  Map<String, Map<String, String>> dayWiseTimeMap = {};
  var scheduleLoading = false.obs;
  updateSchedule() async {
    scheduleLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final Map<String, dynamic> body = <String, dynamic>{
      "day_of_week": dayWiseTimeMap,
      "token": token,
    };
    final res = await repo.updateSchedule(body: jsonEncode(body));
    scheduleLoading(false);
    CommonToast.show(msg: res['message']);
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(scheme: 'tel', path: '100');
    await launchUrl(launchUri);
  }
}
