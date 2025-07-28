import 'dart:convert';
import 'dart:io';
import 'package:aadaiz_seller/src/features/designer/ui/designer_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aadaiz_seller/src/features/auth/model/category_model.dart';
import 'package:aadaiz_seller/src/features/auth/model/otp_verify_model.dart';
import 'package:aadaiz_seller/src/features/auth/ui/sms/otp_auth.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/utils/responsive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../res/components/common_toast.dart';
import '../../../utils/routes/routes_name.dart';
import '../../designer/controller/designer_controller.dart';
import '../../seller/ui/dashboard.dart';
import '../../seller/ui/home/controller/home_controller.dart';
import '../../tailor/controller/tailor_controller.dart';
import '../../tailor/ui/dashboard/tailor_dashboard.dart';
import '../auth_repository/auth_repo.dart';
import '../model/seller_kyc_model.dart';
import '../model/signup_model.dart';
import '../ui/login/login.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.put(AuthController());
  var repo = AuthRepository();

  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();

  var signUpLoading = false.obs;
  var otpToken = ''.obs;

  Future<dynamic>
  signUp({required String type}) async {

    signUpLoading(true);
    final Map<String, dynamic> body = <String, dynamic>{
      "account_type": type,
      "mobile_number": mobile.text,
      "email": email.text,
    };
    SignUpRes res = await repo.signUp(body: jsonEncode(body));
    signUpLoading(false);
    if (res.success == true) {
       otpToken.value= res.data!.otpToken;
        SharedPreferences prefs = await SharedPreferences.getInstance();
       await prefs.setString('mobile', '${res.data!.mobileNumber}');
       await prefs.setString('email', email.text);

       await Get.to(()=> OtpAuth(phoneNumber: mobile.text,type:type));
    } else {
         CommonToast.show(msg: "${res.message}");
    }
  }


var verifyLoading=false.obs;
  Future<dynamic> verifyOtp(context,otp,type) async {
    verifyLoading(true);
    final Map<String, dynamic> body = <String, dynamic>{
      "mobile_number": mobile.text,
      "otp_token": otpToken.value,
      "otp_code": otp.toString(),
      "role":type
    };
    OtpVerifyRes res = await repo.verifyOtp(body: jsonEncode(body));
    verifyLoading(false);
    if (res.success == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', '${res.data!.token}');
      if(type=='Seller'){
        await prefs.setInt('isLogin', 1);
        if(res.data!.isRegister==0){
          await Navigator.pushReplacementNamed(context, RoutesName.kycActivity, arguments: '');
        }else{
          await Navigator.pushReplacementNamed(context, RoutesName.homeActivity, arguments: '');
        }
      }else{
        await prefs.setInt('isLogin', 2);
        if(res.data!.isRegister==0){
          await Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.tailorKYC,
                (route) => false, // Removes all previous routes
            arguments: '',
          );
        }else{
          await Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.tailorHome,
                (route) => false, // Removes all previous routes
            arguments: '',
          );;
        }
      }
    } else {
       CommonToast.show(msg: "${res.message}");
    }
  }

  TextEditingController gstNumber = TextEditingController();
   TextEditingController name = TextEditingController();
   TextEditingController otherProduct = TextEditingController();
   TextEditingController address = TextEditingController();
   TextEditingController productName = TextEditingController();
   TextEditingController category = TextEditingController();
   TextEditingController state = TextEditingController();
   TextEditingController city = TextEditingController();
   TextEditingController pinCode = TextEditingController();
   TextEditingController landMark = TextEditingController();
   TextEditingController street = TextEditingController();
   TextEditingController accountNumber = TextEditingController();
   TextEditingController confirmAccountNumber = TextEditingController();
   TextEditingController ifscCode = TextEditingController();
  var kycLoading=false.obs;

  Future<dynamic> kyc(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var emailValue = prefs.getString('email');
    var mobileValue = prefs.getString('mobile');
    await uploadImage();
    kycLoading(true);
    final Map<String, dynamic> body = <String, dynamic>{
      "account_type": 'Seller',
      "email": emailValue,
      "mobile_number": mobileValue,
      "shop_name": name.text,
      "gst_number": gstNumber.text,
      "shop_photo": '${upload[2]}',
      "state": state.text,
      "city": city.text,
      "pincode": pinCode.text,
      "street": street.text,
      "landmark": landMark.text,
      "aadhaar_card": '${upload[0]}',
      "pan_card": '${upload[1]}',
      "product_category": category.text,
      "other_product": otherProduct.text,
      "account_number": accountNumber.text,
      "confirm_account_number": confirmAccountNumber.text,
      "ifsc_code": ifscCode.text,
    };
    SellerKycRes res = await repo.kyc(body: jsonEncode(body));
    kycLoading(false);
    if (res.success == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', '${res.data!.token}');
      await prefs.setInt('isLogin', 1);
      print("setint");
        await Navigator.pushReplacementNamed(context, RoutesName.homeActivity, arguments: '');
    } else {
      CommonToast.show(msg: "${res.message}");
    }
  }

  RxInt kycIndex = 0.obs;

  void changeKycIndex (){
    if(kycIndex.value<=4){
      kycIndex.value=kycIndex.value+1;
    }
  }
  void changeKycIndexback (){
    if(kycIndex.value>=1){
      kycIndex.value=kycIndex.value-1;
    }
  }
  var categoryList = <Fabric>[].obs;
  var categoryLoading = false.obs;

  getCategory() async {
    categoryLoading(true);
    CategoryListRes res = await repo.getCategory();
    categoryLoading(false);
    if(res.success==true){
   categoryList.value=res.fabric!;
    }else{
      categoryList.clear();
    }
  }







var refreshUpload=false.obs;

  Future<void> showdialog(context,{required dynamic picture,dynamic id}){
    return showDialog(
      context: context,
      builder: (context) {
        var sel = 0;
        return StatefulBuilder(
            builder: (BuildContext context, setState){
              return Dialog(
                  insetPadding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 16,
                  child: Container(
                    //  height: 32.00.hp,
                      width: 95.00.wp,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 01.00.hp,
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Please Choose',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 14.00.sp,
                                              color:
                                              const Color(0xff171717),
                                              fontWeight:
                                              FontWeight.w600)),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0, top: 10, right: 0),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(Icons.cancel,size: 25,color: Colors.blueAccent,)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 04.00.hp,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    sel =1;
                                    openCamera(camera: sel==1? false:true, picture: picture);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 15,
                                      right: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color:sel == 1
                                          ? AppColors.primaryColor
                                          : Colors.white,),
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 50,
                                        color:
                                        sel == 1 ? AppColors.primaryColor : Colors.grey[800],
                                      ),
                                      SizedBox(
                                        height: 1.0.hp,
                                      ),
                                      Text(
                                        'Gallery',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 11.00.sp,
                                                color: sel == 1?AppColors.primaryColor: const Color(
                                                    0xff171717),
                                                fontWeight:
                                                FontWeight.w500)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    sel=2;
                                    openCamera(camera: sel==1? false:true,picture: picture);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 15,
                                      right: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color:sel == 2
                                          ? AppColors.primaryColor
                                          : Colors.white,),
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.camera_alt_rounded,
                                        size: 50,
                                        color:
                                        sel == 2 ? AppColors.primaryColor : Colors.grey[800],
                                      ),
                                      SizedBox(
                                        height: 1.3.hp,
                                      ),
                                      Text(
                                        'Camera',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 11.00.sp,
                                                color: sel == 2?AppColors.primaryColor: const Color(
                                                    0xff171717),
                                                fontWeight:
                                                FontWeight.w500)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 03.00.hp,
                          ),
                        ],
                      )));

            }     );
      },
    );
  }
  final ImagePicker _picker = ImagePicker();
  Rx<File> image = File('').obs;
  Rx<File> aadhaarImage = File('').obs;
  Rx<File> panImage = File('').obs;
  Rx<File> storeImage = File('').obs;
  var selectedImages = [].obs;

  List upload = [];
  Future<void> openCamera({required bool camera, required int picture}) async {
    Get.back();
    final pickedFile = await _picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
    );

    if (pickedFile == null) {
      print('No image picked');
      return;
    }

    print('Picked image: ${pickedFile.path}');

    // Compress the picked image
    final compressedFile = await _compressImage(pickedFile);
    if (compressedFile == null) {
      Get.snackbar("Error", "Failed to compress image");
      return;
    }

    print('Compressed image: ${compressedFile.path}');
    final file = File(compressedFile.path); // Convert XFile to File for specific variables

    switch (picture) {
      case 0:
        selectedImages.clear();
        aadhaarImage(file);
        selectedImages.add(compressedFile);
        break;
      case 1:
        panImage(file);
        selectedImages.add(compressedFile);
        break;
      case 2:
        storeImage(file);
        selectedImages.add(compressedFile);
        break;
    case 3:
    TailorController.to.image1(file);
    selectedImages.add(compressedFile);
    break;
    case 4:
    TailorController.to.image2(file);
    selectedImages.add(compressedFile);
    break;
    case 5:
    TailorController.to.image3(file);
    selectedImages.add(compressedFile);
    break;
    case 6:
    TailorController.to.adhar(file);
    selectedImages.add(compressedFile);
    break;
    case 7:
    DesignerController.to.image(file);
    selectedImages.add(compressedFile);
    break;
    case 8:
    DesignerController.to.design(file);
    selectedImages.add(compressedFile);

        image(file);
        selectedImages.clear();
        selectedImages.add(compressedFile);
    }

    refreshUpload(false);
  }

  Future<void> uploadImage() async {
    print('Starting image upload. Selected images: ${selectedImages.length}');
    upload.clear();
    if (selectedImages.isEmpty) {
      print('No images selected for upload');
      throw Exception('No images selected');
    }

    for (var i = 0; i < selectedImages.length; i++) {
      try {
        kycLoading(true);
        print('Uploading image ${i + 1}: ${selectedImages[i].path}');
        var response = await repo.uploadImage(image: selectedImages[i].path);
        if (response != null && response.url != null && response.url!.isNotEmpty) {
          upload.add(response.url);
          print('Uploaded image ${i + 1}: ${response.url}');
        } else {
          print('Upload response is null or missing URL for image ${i + 1}');
          throw Exception('Failed to upload image ${i + 1}: Invalid response');
        }
      } catch (e) {
        print('Error uploading image ${i + 1}: $e');
        rethrow; // Propagate error to caller
      } finally {
        kycLoading(false);
      }
    }
  }

  Future<XFile?> _compressImage(XFile image) async {
    try {
      final File originalFile = File(image.path);
      final tempDir = await getTemporaryDirectory();
      final format = CompressFormat.jpeg;
      final extension = format == CompressFormat.jpeg ? '.jpg' :
      format == CompressFormat.png ? '.png' : '.webp';
      final String targetPath =
          '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}$extension';

      // Compress the image
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        originalFile.path,
        targetPath,
        quality: 85,
        minWidth: 1024,
        minHeight: 1024,
        format: CompressFormat.jpeg,
      );

      if (compressedFile == null) {
        print('Compression failed for image: ${image.path}');
        return null;
      }

      // Check file size
      final fileSize = await compressedFile.length();
      if (fileSize > 2 * 1024 * 1024) {
        // If still over 2MB, reduce quality further
        final reCompressedFile = await FlutterImageCompress.compressAndGetFile(
          originalFile.path,
          targetPath,
          quality: 70,
          minWidth: 800,
          minHeight: 800,
          format: CompressFormat.jpeg,
        );

        if (reCompressedFile == null || await reCompressedFile.length() > 2 * 1024 * 1024) {
          print('Image size still exceeds 2MB after recompression');
          return null;
        }
        return XFile(reCompressedFile.path);
      }

      return XFile(compressedFile.path);
    } catch (e) {
      print('Error compressing image: $e');
      return null;
    }
  }


  Future<void> checkLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int?  isLogin =  prefs.getInt('isLogin');
    switch(isLogin){
      case 0: Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
        const DesignerDashboard(), // Navigate to home if logged in
      ));
      case 1: Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
         Dashboard(), // Navigate to login if not logged in
      ));
      case 2:   Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
         TailorDashboard(), // Navigate to login if not logged in
      ));
      default:
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
          const Login(), // Navigate to login if not logged in
        ));
    }
  }
  void showLogOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: Get.height * 0.22,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Logout',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 19.00.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  'Are you sure you want to log out ?',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 11.00.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        width: Get.width / 3.3,
                        alignment: Alignment.center,
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.00.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 3.3,
                      child: InkWell(
                        onTap: () async {
                          await logOut();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: Get.width / 3.3,
                          alignment: Alignment.center,
                          child: Text(
                            'Logout',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 13.00.sp,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    DesignerController.to.tabSelected.value = 0;
    HomeController.to.setTab(0);
    TailorController.to.setTab(0);
    Get.offAll(() => const Login());
  }

}
