import 'dart:developer';
import 'dart:convert';
import 'dart:io';
import 'package:aadaiz_seller/src/features/seller/ui/profile/model/profile_details_model.dart';
import 'package:flutter/material.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/repository/profile_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../res/components/common_toast.dart';
import '../../../../auth/controller/auth_controller.dart';
import '../../home/controller/home_controller.dart';
import '../model/payment_model.dart';
import '../model/profile_model.dart' as address;
import '../model/support_model.dart'as support;

class ProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getprofiledetail();
  }
  var isLoading = false.obs;
  var isLoadingupdate = false.obs;
  var addresslist = <address.Datum>[].obs;
  var supportList = <support.Datum>[].obs;
  var currentPage = 1.obs;
  var hasMore = true.obs;
  bool enable = false;

  // In ProfileController
  final Rx<File?> tempImage = Rx<File?>(null);
  // TextEditingControllers for each field
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController problem = TextEditingController();
  final TextEditingController descriptionsupport = TextEditingController();
  final TextEditingController shopname = TextEditingController();

  final ProfileRepository repo = ProfileRepository();
  static ProfileController get to => Get.put(ProfileController(), permanent: true);
  Future<void> createsupport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {
      print("Error: Token is null");
      Get.snackbar("Error", "No token found. Please log in again.");
      isLoading(false);
      return;
    }

    // Validate input fields
    if (problem.text.isEmpty || descriptionsupport.text.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields.");
      isLoading(false);
      return;
    }

    // Upload the image
    try {
      await AuthController.to.uploadImage();
    } catch (e) {
      print("Error uploading image: $e");
      Get.snackbar("Error", "Failed to upload image. Please try again.");
      isLoading(false);
      return;
    }

    // Validate uploaded image
    if (AuthController.to.upload.isEmpty) {
      print("Error: No image uploaded");
      Get.snackbar("Error", "No image was uploaded. Please select an image and try again.");
      isLoading(false);
      return;
    }

    // Prepare the body
    Map<String, dynamic> body = {
      "title": problem.text,
      "description": descriptionsupport.text,
      "attachment": AuthController.to.upload[0],
      "token": token,
    };

    try {
      isLoading(true);
      var response = await repo.createsupportApi(body: jsonEncode(body));
      if (response.success==true) {

CommonToast.show(msg: response.message);
        await Future.delayed(const Duration(seconds: 2));
        Get.back();
        problem.clear();
        descriptionsupport.clear();
        AuthController.to.image.value = File('');
        AuthController.to.selectedImages.clear();
        AuthController.to.upload.clear();

        getSupportList(isRefresh: true); // Refresh support list
      } else {
        Get.snackbar("Error", response.message ?? "Failed to create support ticket.");
      }
    } catch (e, stackTrace) {
      print("Error creating support ticket: $e");
      log("Stack trace: $stackTrace");
      Get.snackbar("Error", "An error occurred while creating the support ticket.");
    } finally {
      isLoading(false);
    }
  }
  Future<void> getaddresslist(String? type,String? module) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {
      print("Error: Token is null");
      Get.snackbar("Error", "No token found. Please log in again.");
      isLoading(false);
      return;
    }
    Map<String, dynamic> body = {
      "action": type,
      "token": token,
    };
    try {
      isLoading(true);
      var response = await repo.addressApi(body: jsonEncode(body),module:module);
      if (response.data != null && response.data!.isNotEmpty) {
        if (type == "list") {
          addresslist.clear();
          addresslist.addAll(response.data!);
        }
      } else {
        Get.snackbar("Info", "No addresses found.");
      }
    } catch (e, stackTrace) {
      print("Error fetching address list: $e");
      log("Stack trace: $stackTrace");
    } finally {
      isLoading(false);
    }
  }


  Future<void> saveAddress(dynamic id, dynamic role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {
      Get.snackbar("Error", "No token found. Please log in again.");
      return;
    }

    Map<String, dynamic> body = {
      "action": "update",
      "token": token,
      "name": fullNameController.text,
      "mobile": mobileNumberController.text,
      "address": addressController.text,
      "city": cityController.text,
      "landmark": landmarkController.text,
      "state": stateController.text,
      "pincode": zipCodeController.text,
      "country": countryController.text,
      "address_id": id,
      "role": role,
    };

    try {
      isLoading(true);
      var response = await repo.addressApi(body: jsonEncode(body));
      if (response.success == true) {
        CommonToast.show(msg: response.message);
        Get.back();
        getaddresslist("list",'');
      } else {
        Get.snackbar("Error", "Failed to save address.");
      }
    } catch (e) {
      print("Error saving address: $e");
      Get.snackbar("Error", "An error occurred while saving the address.");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getSupportList({bool isRefresh = false, bool isLoadMore = false}) async {
    if (isRefresh) {
      currentPage.value = 1;
      supportList.clear();
      hasMore.value = true;
    } else if (isLoadMore && !hasMore.value) {
      return;
    }

    if (isLoadMore) {
      currentPage.value++;
    }


    try {
      isLoading(true);
      var res = await repo.SupportListApi(page: currentPage.value, );
      if (res.data != null && res.data!.data != null) {
        if (isRefresh || !isLoadMore) {
          supportList.clear();
        }
        supportList.addAll(res.data!.data!);
        hasMore.value = res.data!.nextPageUrl != null;
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      log("Error fetching support list: $e");
    } finally {
      isLoading(false);
    }
  }
  var paymentlist = <Datum>[].obs;
  var profiledetail = <Data>[].obs;
Future<void>getpaymentlist()async{
  try{
    isLoading(true);
  MyPaymentRes res = await repo.getpaymentlistApi();

  if(res.data!=null){
    paymentlist.assignAll(res.data!);

  }}catch(e){

  }finally{
    isLoading(false);
  }
}
Future<void>getprofiledetail()async{
  try{
    isLoading(true);
  ProfileRes res = await repo.getprofiledetailApi();

  if(res.data!=null){
    profiledetail.assignAll([res.data!]);

  }}catch(e){

  }finally{
    isLoading(false);
  }
}
  Future<dynamic> UpdateProfile(

  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {
      Get.snackbar("Error", "No token found. Please log in again.");
      return;
    }

    try {
      isLoadingupdate(true);
      List<String> uploadedUrls = await HomeController.to.uploadImage(); // Upload images first
      String imageUrls = uploadedUrls.join(',');


      Map<String, dynamic> body = {
        "token":token ,
       "shop_name":shopname.text,
        "shop_photo":imageUrls
      };

      var response = await repo.updateprofileApi(body: jsonEncode(body));
      if (response['status'] == true) {
        CommonToast.show(msg: response['message'] ?? "Profile Updated successfully");

        Future.delayed(const Duration(milliseconds: 500), () {
         getprofiledetail()
;        });

    enable=false;


      } else {

      }
    } catch (e) {
      print("Error saving order: $e");

    } finally {
      isLoadingupdate(false);
    }
  }
  @override
  void onClose() {
    fullNameController.dispose();
    mobileNumberController.dispose();
    addressController.dispose();
    cityController.dispose();
    landmarkController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    countryController.dispose();
    super.onClose();
  }
}