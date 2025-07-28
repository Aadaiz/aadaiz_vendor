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

class ForgotCreateNewPassword extends StatefulWidget {
  const ForgotCreateNewPassword({
    super.key,
    required this.email,
    required this.otp,
  });
  final String email;
  final String otp;
  @override
  State<ForgotCreateNewPassword> createState() =>
      _ForgotCreateNewPasswordState();
}

class _ForgotCreateNewPasswordState extends State<ForgotCreateNewPassword> {
  final FocusNode password = FocusNode();
  final FocusNode confirm = FocusNode();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool _obscured = false;
  bool _obscuredConfirm = false;
  @override
  void initState() {
    DesignerController.to.updateOtpLoading(false);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    password.dispose();
    confirm.dispose();
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
                        'Set a new password',
                        style: GoogleFonts.dmSans(
                          fontSize: 17.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Create a new password. Ensure it differs from previous ones for security',
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
              child: Column(
                children: [
                  OverlayWidgets.fullWidthTextField(
                    label: Text(
                      'Password',
                      style: GoogleFonts.inter(color: AppColors.blackColor),
                    ),
                    child: SizedBox(
                      height: screenHeight * 0.05,
                      child: TextFormField(
                        obscureText: _obscured,
                        focusNode: password,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: GoogleFonts.inter(
                            color: AppColors.hintTextColor,
                            fontSize: 12.sp,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _obscured = !_obscured;
                              });
                            },
                            child: Icon(
                              _obscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
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
                  OverlayWidgets.fullWidthTextField(
                    label: Text(
                      'Confirm Password',
                      style: GoogleFonts.inter(color: AppColors.blackColor),
                    ),
                    child: SizedBox(
                      height: screenHeight * 0.05,
                      child: TextFormField(
                        obscureText: _obscuredConfirm,
                        focusNode: confirm,
                        controller: confirmPassword,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: GoogleFonts.inter(
                            color: AppColors.hintTextColor,
                            fontSize: 12.sp,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _obscuredConfirm = !_obscuredConfirm;
                              });
                            },
                            child: Icon(
                              _obscuredConfirm
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  DesignerController.to.updatePasswordForgot(
                    context,
                    widget.email,
                    widget.otp,
                    passwordController.text,
                    confirmPassword.text,
                  );
                },
                child: CommonButton(
                  text: 'Update Password',
                  width: screenWidth,
                  borderRadius: 8.0,
                  height: 45.0,
                  isLoading: DesignerController.to.updateOtpLoading.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
