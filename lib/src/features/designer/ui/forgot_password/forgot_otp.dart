

import 'package:aadaiz_seller/src/features/designer/controller/designer_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/designer/ui/forgot_password/forgot_create_new.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../../res/components/common_button.dart';
import '../../../../utils/form_validation.dart';
import '../../../../utils/utils.dart';

class ForgotOtp extends StatefulWidget {
  const ForgotOtp({super.key, required this.email});
  final String email;
  @override
  State<ForgotOtp> createState() => _ForgotOtpState();
}

class _ForgotOtpState extends State<ForgotOtp> {
  final OtpFieldController _otpController = OtpFieldController();
  String otp='';
  @override
  void initState() {
    DesignerController.to.verifyOtpLoading(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: AppColors.blackColor,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Check your email',
                        style: GoogleFonts.dmSans(
                          fontSize: 17.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Utils.columnSpacer(height: screenHeight * 0.01),
                  Text(
                    'We sent a reset link to ${widget.email ?? ""} '
                    'enter 5 digit code that mentioned in the email',
                    style: GoogleFonts.dmSans(
                      fontSize: 14.sp,
                      color: AppColors.greyTextColor.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Utils.columnSpacer(height: screenHeight * 0.05),
            Center(
              child: OTPTextField(
                controller: _otpController,
                length: 5,
                outlineBorderRadius: 4,
                width: screenWidth - 100,
                fieldWidth: screenWidth * 0.11,
                fieldStyle: FieldStyle.box,
                inputFormatter: <TextInputFormatter>[
                  FormValidation.allowedIntegers,
                  FormValidation.ignoreDots,
                ],
                style: const TextStyle(fontWeight: FontWeight.bold),
                otpFieldStyle: OtpFieldStyle(
                  focusBorderColor: AppColors.textFieldBorderColor,
                  enabledBorderColor: AppColors.textFieldBorderColor,
                  borderColor: AppColors.textFieldBorderColor,
                ),
                onCompleted: (String val) {
                  DesignerController.to.verifyOtp(context, widget.email, val);
                  otp=val;
                },
              ),
            ),
            Utils.columnSpacer(height: screenHeight * 0.05),
            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  DesignerController.to.verifyOtp(context, widget.email, otp);
                },
                child: CommonButton(
                  text: 'Verify',
                  width: screenWidth,
                  borderRadius: 8.0,
                  height: 45.0,
                  isLoading: DesignerController.to.verifyOtpLoading.value,
                ),
              ),
            ),
            Utils.columnSpacer(height: screenHeight * 0.01),
            RichText(
              text: TextSpan(
                text: 'Haven’t got the email yet?  ',
                style: GoogleFonts.dmSans(
                  fontSize: 13.sp,
                  color: AppColors.greyTextColor.withOpacity(0.5),
                ),
                children: <InlineSpan>[
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=(){
                  DesignerController.to.sendOtp(context,widget.email);
                  },
                    text: 'Resend Email',
                    style: GoogleFonts.dmSans(
                      fontSize: 13.sp,
                      color: AppColors.blackColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
