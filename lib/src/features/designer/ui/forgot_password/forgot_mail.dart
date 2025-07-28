import 'package:aadaiz_seller/src/features/designer/controller/designer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';

import '../../../../res/components/common_button.dart';
import '../../../../res/components/widgets/overlay_widgets.dart';
import '../../../../utils/routes/routes_name.dart';
import '../../../../utils/utils.dart';

class ForgotMail extends StatefulWidget {
  const ForgotMail({super.key});

  @override
  State<ForgotMail> createState() => _ForgotMailState();
}

class _ForgotMailState extends State<ForgotMail> {
  final FocusNode mailFocus = FocusNode();
  TextEditingController mail = TextEditingController();
  final bool _obscured = false;
  @override
  void dispose() {
    super.dispose();
    mailFocus.dispose();
  }
  @override
  void initState() {
    DesignerController.to.sendOtpLoading(false);
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
                        'Forgot password',
                        style: GoogleFonts.dmSans(
                          fontSize: 17.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Please enter your email to reset the password',
                    style: GoogleFonts.dmSans(
                      fontSize: 14.sp,
                      color: AppColors.greyTextColor.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OverlayWidgets.fullWidthTextField(
                label: Text(
                  'Your Email',
                  style: GoogleFonts.inter(color: AppColors.blackColor),
                ),
                child: SizedBox(
                  height: screenHeight * 0.05,
                  child: TextFormField(
                    focusNode: mailFocus,
                    controller: mail,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: GoogleFonts.inter(
                        color: AppColors.hintTextColor,
                        fontSize: 12.sp,
                      ),
                      fillColor: AppColors.whiteColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.textFieldBorderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.textFieldBorderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.textFieldBorderColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  DesignerController.to.sendOtp(context, mail.text);
                },
                child: CommonButton(
                  text: 'Reset Password',
                  width: screenWidth,
                  borderRadius: 8.0,
                  height: 45.0,
                  isLoading: DesignerController.to.sendOtpLoading.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
