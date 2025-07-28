import 'package:aadaiz_seller/src/features/designer/controller/designer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/res/components/common_button.dart';

import '../../../res/colors/app_colors.dart';
import '../../../res/components/widgets/overlay_widgets.dart';
import '../../../utils/utils.dart';
import 'forgot_password/forgot_mail.dart';

class DesignerLogin extends StatefulWidget {
  const DesignerLogin({super.key});

  @override
  State<DesignerLogin> createState() => _DesignerLoginState();
}

class _DesignerLoginState extends State<DesignerLogin> {
  final FocusNode mailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscured = false;
  final loginFormKey = GlobalKey<FormState>();
  bool isEmpty = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DesignerController.to.signUpLoading(false);
  }

  @override
  void dispose() {
    super.dispose();
    mailFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Form(
          key: loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Utils.columnSpacer(height: screenHeight * 0.1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Hi, Welcome Back! 👋',
                  style: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      fontSize: 25,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Start Managing Your task faster & better',
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                      fontSize: 12,
                      color: AppColors.greyTextColor.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    OverlayWidgets.fullWidthTextField(
                      label: Text(
                        'Enter Your Company Email',
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
                          onFieldSubmitted: (String val) =>
                              Utils.fieldFocusChange(
                                context: context,
                                currentFocus: mailFocus,
                                nextFocus: passwordFocus,
                              ),
                          validator: (data) {
                            if (data == '' || data == null) {
                              setState(() {
                                isEmpty = true;
                              });
                            } else {
                              setState(() {
                                isEmpty = false;
                              });
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    OverlayWidgets.fullWidthTextField(
                      label: Text(
                        'Enter Your Password',
                        style: GoogleFonts.inter(color: AppColors.blackColor),
                      ),
                      child: SizedBox(
                        height: screenHeight * 0.05,
                        child: TextFormField(
                          obscureText: _obscured,
                          focusNode: passwordFocus,
                          controller: password,
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => const ForgotMail());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Forget Password ?',
                              style: GoogleFonts.dmSans(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.starColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Utils.columnSpacer(height: screenHeight * 0.3),
                    InkWell(
                      onTap: () {
                        if (loginFormKey.currentState!.validate()) {
                          if (!DesignerController.to.signUpLoading.value) {
                            DesignerController.to.designerLogin(
                              mail.text,
                              password.text,
                              context,
                            );
                          }
                        }
                      },
                      child: Obx(
                        () => CommonButton(
                          text: 'Login',
                          width: screenWidth,
                          borderRadius: 8.0,
                          height: 45.0,
                          isLoading: DesignerController.to.signUpLoading.value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
