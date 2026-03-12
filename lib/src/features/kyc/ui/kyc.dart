import 'package:aadaiz_seller/src/res/components/common_toast.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/features/kyc/ui/bank.dart';
import 'package:aadaiz_seller/src/features/kyc/ui/gst.dart';
import 'package:aadaiz_seller/src/features/kyc/ui/shipping.dart';
import 'package:aadaiz_seller/src/features/kyc/ui/store.dart';
import 'package:aadaiz_seller/src/features/kyc/ui/verification.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/res/components/loading_button.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

import '../../seller/ui/profile/controller/location_controller.dart';

class Kyc extends StatefulWidget {
  const Kyc({super.key});

  @override
  State<Kyc> createState() => _KycState();
}

class _KycState extends State<Kyc> {
  final List<Widget> _kycForms = <Widget>[
    const Gst(),
    const Verification(),
    const Store(),
    const Shipping(),
    const Bank()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthController.to.kycIndex.value=0;
  }
  final LocationController locationController = LocationController.to;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
            leading: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.013),
                child: InkWell(
                    onTap: () =>
             AuthController.to.kycIndex.value!=0?
                     AuthController.to.changeKycIndexback():
                        Navigator.pop(context),
                    child: SvgPicture.asset('assets/images/back.svg'))),
            centerTitle: true,
            forceMaterialTransparency: true,
            title: InkWell(
              onTap: (){
                AuthController.to.logOut();
              },
              child: Text('KYC',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                      fontSize: 20.sp)),
            )),
        body: SingleChildScrollView(
            child: Obx(
          () => Column(children: <Widget>[
            SizedBox(
                height: screenHeight * 0.1,
                child: EasyStepper(
                    enableStepTapping: false,
                    defaultStepBorderType: BorderType.normal,
                    internalPadding: 0,
                    lineStyle: LineStyle(
                        lineType: LineType.normal,
                        defaultLineColor:
                            AppColors.blackColor.withOpacity(0.3)),
                    activeStepTextColor: AppColors.kycTextColor,
                    finishedStepTextColor: AppColors.kycTextColor,
                    showLoadingAnimation: false,
                    stepRadius: 18,
                    showStepBorder: false,
                    activeStep: 0,
                    steps: <EasyStep>[
                      EasyStep(
                          customStep: CircleAvatar(
                              radius: 18,
                              backgroundColor:
                                  AuthController.to.kycIndex.value >= 0
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor.withOpacity(0.3),
                              child: AuthController.to.kycIndex.value >= 0
                                  ? SvgPicture.asset(
                                      'assets/images/completed.svg')
                                  : CircleAvatar(
                                      backgroundColor: AppColors.whiteColor,
                                      radius: 16,
                                      child: Center(
                                          child: Text('1',
                                              style: GoogleFonts.dmSans())))),
                          customTitle: Text('GST\nNumber',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(fontSize: 11.sp))),
                      EasyStep(
                          customTitle: Text('Verification',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(fontSize: 11.sp)),
                          customStep: CircleAvatar(
                              radius: 18,
                              backgroundColor:
                                  AuthController.to.kycIndex.value >= 1
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor.withOpacity(0.3),
                              child: AuthController.to.kycIndex.value >= 1
                                  ? SvgPicture.asset(
                                      'assets/images/completed.svg')
                                  : CircleAvatar(
                                      backgroundColor: AppColors.whiteColor,
                                      radius: 16,
                                      child: Center(
                                          child: Text('2',
                                              style: GoogleFonts.dmSans()))))),
                      EasyStep(
                          customTitle: Text('Store\nName',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(fontSize: 11.sp)),
                          customStep: CircleAvatar(
                              radius: 18,
                              backgroundColor:
                                  AuthController.to.kycIndex.value >= 2
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor.withOpacity(0.3),
                              child: AuthController.to.kycIndex.value >= 2
                                  ? SvgPicture.asset(
                                      'assets/images/completed.svg')
                                  : CircleAvatar(
                                      backgroundColor: AppColors.whiteColor,
                                      radius: 16,
                                      child: Center(
                                          child: Text('3',
                                              style: GoogleFonts.dmSans()))))),
                      EasyStep(
                          customTitle: Text('Shipping Address',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(fontSize: 11.sp)),
                          customStep: CircleAvatar(
                              radius: 18,
                              backgroundColor:
                                  AuthController.to.kycIndex.value >= 3
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor.withOpacity(0.3),
                              child: AuthController.to.kycIndex.value >= 3
                                  ? SvgPicture.asset(
                                      'assets/images/completed.svg')
                                  : CircleAvatar(
                                      backgroundColor: AppColors.whiteColor,
                                      radius: 16,
                                      child: Center(
                                          child: Text('4',
                                              style: GoogleFonts.dmSans()))))),
                      EasyStep(
                          customTitle: Text('Bank\nDetails',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(fontSize: 11.sp)),
                          customStep: CircleAvatar(
                              radius: 18,
                              backgroundColor:
                                  AuthController.to.kycIndex.value >= 4
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor.withOpacity(0.3),
                              child: AuthController.to.kycIndex.value >= 4
                                  ? SvgPicture.asset(
                                      'assets/images/completed.svg')
                                  : CircleAvatar(
                                      backgroundColor: AppColors.whiteColor,
                                      radius: 16,
                                      child: Center(
                                          child: Text('5',
                                              style: GoogleFonts.dmSans())))))
                    ])),

            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.08,
                    horizontal: screenWidth * 0.05),
                child: Container(
                    constraints: BoxConstraints(minHeight: screenHeight / 2),
                    child: _kycForms[AuthController.to.kycIndex.value])),
            //     :
            // Padding(
            //         padding: EdgeInsets.symmetric(
            //             vertical: screenHeight * 0.08,
            //             horizontal: screenWidth * 0.05),
            //         child: Container(
            //             constraints: BoxConstraints(minHeight: screenHeight / 2),
            //             child: _kycForms[0])),
            LoadingButton(
              loading: AuthController.to.kycLoading.value,
                title: 'Next',
                onPressed: () {
                  final index = AuthController.to.kycIndex.value;
                  if (index == 0) {
                    if (AuthController.to.gstNumber.text.trim().isEmpty) {
                      CommonToast.show(msg: 'Please enter GST Number');
                      return;
                    }


                    final gstNumber = AuthController.to.gstNumber.text.trim();
                    final cleanGST = gstNumber.replaceAll(RegExp(r'\s+'), '').toUpperCase();


                    final gstRegex = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');

                    if (!gstRegex.hasMatch(cleanGST)) {
                      CommonToast.show(msg: 'Invalid GST Number format');
                      return;
                    }


                    final stateCode = int.tryParse(cleanGST.substring(0, 2));
                    if (stateCode == null || stateCode < 1 || stateCode > 37) {
                      CommonToast.show(msg: 'Invalid State Code in GST');
                      return;
                    }
                  }

                  else if (index == 1) {
                    if (AuthController.to.aadhaarImage.value.path.isEmpty) {
                      CommonToast.show(msg:"Please upload Aadhaar card photo");
                      return;
                    }

                    if (AuthController.to.panImage.value.path.isEmpty) {
                      CommonToast.show(msg:"Please upload PAN card photo");
                      return;
                    }



                  }
                 else if (index == 2) {
                   if (AuthController.to.name.text.trim().isEmpty) {
                     CommonToast.show(msg:"Please enter shop name");
                     return;
                   }
                   if (AuthController.to.address.text.trim().isEmpty) {
                     CommonToast.show(msg:"Please enter shop address");
                     return;
                   }
                   if (AuthController.to.category.text.trim().isEmpty && AuthController.to.otherProduct.text.trim().isEmpty) {
                     CommonToast.show(msg:"Please enter category name");
                     return;
                   }


                   if (AuthController.to.storeImage.value.path.isEmpty) {
                     CommonToast.show(msg:"Please upload Shop photo");
                     return;
                   }



                 }
                 else if (index == 3) {
                   if (locationController.selectedCountry.value== null  ) {
                     CommonToast.show(msg:"Please choose Country");
                     return;
                   }
                   if (locationController.selectedState.value== null  ) {
                     CommonToast.show(msg:"Please choose state");
                     return;
                   }
                   if (locationController.selectedCity.value== null ) {
                     CommonToast.show(msg:"Please Choose city name");
                     return;
                   }
                   String street = AuthController.to.street.text.trim();

                   if (street.isEmpty) {
                     CommonToast.show(msg: "Please enter street details");
                     return;
                   }

                   if (street.length < 100) {
                     CommonToast.show(msg: "Street address must be at least 100 characters");
                     return;
                   }

                   if (!RegExp(r'\d').hasMatch(street)) {
                     CommonToast.show(msg: "Street must contain door number and street name");
                     return;
                   }
                   if (AuthController.to.pinCode.text.trim().isEmpty) {
                     CommonToast.show(msg:"Please enter pincode address");
                     return;
                   }

                   if (AuthController.to.landMark.text.trim().isEmpty ) {
                     CommonToast.show(msg:"Please enter Landmark name");
                     return;
                   }







                 }


                  if (index == 4) {
                    if(AuthController.to.bankName.text.trim().isEmpty) {
                      CommonToast.show(msg:"Please enter Bank Name");
                      return;
                    }
                    if (AuthController.to.accountNumber.text.trim().isEmpty) {
                      CommonToast.show(msg:"Please enter Account number");
                      return;
                    }
                    if (AuthController.to.confirmAccountNumber.text.trim().isEmpty) {
                      CommonToast.show(msg:"Please enter confirm Account number");
                      return;
                    }
                    if (AuthController.to.confirmAccountNumber.text!=AuthController.to.accountNumber.text) {
                      CommonToast.show(msg:"Please enter confirm Account number same as Account number");
                      return;
                    }
                    if (AuthController.to.ifscCode.text.trim().isEmpty ) {
                      CommonToast.show(msg:"Please enter IFSC code");
                      return;
                    }

                    AuthController.to.kyc(context);
                  } else {
                    AuthController.to.changeKycIndex();
                  }
                }
,

                btnWidth: screenWidth / 1.2,
                btnHeight: screenHeight * 0.07),
            Utils.columnSpacer(height: screenHeight * 0.05)
          ]),
        )));
  }


}
