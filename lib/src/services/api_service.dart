

import '../config/app_config.dart';

class Api {
  ///Registration
  static const fcm = "${AppConfig.baseUrl}fcm_update";
  static const signUp = "${AppConfig.baseUrl}mv_send_otp";
  static const verifyOtp = "${AppConfig.baseUrl}mv_verify_otp";
  static const kycSeller = "${AppConfig.baseUrl}seller/kyc";
  static const category = "${AppConfig.baseUrl}seller/material_category";
  static const uploadImage = "${AppConfig.baseUrl}upload-image";

  ///designer
  static const designerLogin = "${AppConfig.baseUrl}designer/login";
  static const sendOtp = "${AppConfig.baseUrl}designer/send_otp";
  static const designerVerifyOtp = "${AppConfig.baseUrl}designer/verify_otp";
  static const designerUpdatePassword = "${AppConfig.baseUrl}designer/forget_update_password";
  static const designerAppointments = "${AppConfig.baseUrl}designer/appointments_list";
  static const designerProfile = "${AppConfig.baseUrl}designer/profile";
  static const designerUpdateProfile = "${AppConfig.baseUrl}designer/profile_update";
  static const designerUpdatePasswordProfile = "${AppConfig.baseUrl}designer/profile/update_password";
  static const designerNotification = "${AppConfig.baseUrl}designer/notification";
  static const uploadDesign = "${AppConfig.baseUrl}designer/upload_design";
  static const cancelAppointment = "${AppConfig.baseUrl}designer/cancelAppointment";
  static const updateSchedule = "${AppConfig.baseUrl}designer/updateTiming";

//tailor
  static const tailorKyc = "${AppConfig.baseUrl}tailor/kyc";
  static const tailorAddress = "${AppConfig.baseUrl}tailor/address";
  static const tailorOrderList = "${AppConfig.baseUrl}tailor/order_list";
  static const tailorSupportList = "${AppConfig.baseUrl}tailor/support_tickets";
  static const tailorCategory = "${AppConfig.baseUrl}selfcustomize/filter";
  static const tailordash = "${AppConfig.baseUrl}tailor/dashboard";
  static const updatetailororderstatus = "${AppConfig.baseUrl}tailor/updateOrderStatus";

//seller
  static const selleraddress = "${AppConfig.baseUrl}seller/address";
  static const tailoraddress = "${AppConfig.baseUrl}tailor/address";
  static const support = "${AppConfig.baseUrl}seller/support_tickets";
  static const payment = "${AppConfig.baseUrl}seller/paymentHistory";
  static const notificationList = "${AppConfig.baseUrl}seller/notification";
  static const order = "${AppConfig.baseUrl}seller/sell";
  static const profiledetail = "${AppConfig.baseUrl}seller/profile";
  static const updateProfile = "${AppConfig.baseUrl}seller/updateProfile";
  static const sellerdash = "${AppConfig.baseUrl}seller/dashboard";
  static const orderList = "${AppConfig.baseUrl}seller/order_list";
  static const trackingData = "${AppConfig.baseUrl}shiprocket/track";
  static const updateorderstatus = "${AppConfig.baseUrl}seller/updateOrderStatus";
  static const countries = "${AppConfig.baseUrl}countries";
  static const state = "${AppConfig.baseUrl}states";
  static const city = "${AppConfig.baseUrl}cities";
  static const checkKycStatus = "${AppConfig.baseUrl}seller/kycDetails";

}