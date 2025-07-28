import 'package:aadaiz_seller/src/features/designer/controller/designer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';

import '../../../../res/components/common_button.dart';
import '../../../../res/components/widgets/overlay_widgets.dart';
import '../../../../utils/utils.dart';

class PasswordManager extends StatefulWidget {
  const PasswordManager({super.key});

  @override
  State<PasswordManager> createState() => _PasswordManagerState();
}

class _PasswordManagerState extends State<PasswordManager> {
  final FocusNode passwordFocus = FocusNode();
  TextEditingController password = TextEditingController();

  final FocusNode passwordf = FocusNode();
  final FocusNode confirm = FocusNode();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool _obscured = false;
  bool _obscuredConfirm = false;
  bool _obscuredN = false;
  @override
  void dispose() {
    super.dispose();
    passwordFocus.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading:  InkWell(
          onTap: (){
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: AppColors.blackColor,),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Password Manager',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor,
                    fontSize : 20
                )),
            SizedBox(width: screenWidth*0.1,)
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: OverlayWidgets.fullWidthTextField(
                label: Text(
                    'Password',
                    style: GoogleFonts.inter(
                        color: AppColors.blackColor
                    )
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
                              fontSize: 12.sp
                          ),
                          suffixIcon: InkWell(
                            onTap: (){
                              setState(() {
                                _obscured = !_obscured;
                              });
                            },
                            child: Icon( _obscured? Icons.visibility:Icons.visibility_off,),
                          ),
                          fillColor: AppColors.whiteColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldBorderColor
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldBorderColor
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldBorderColor
                              )
                          )
                      ),
                    )
                )
            ),
          ),
          OverlayWidgets.fullWidthTextField(
            label: Text(
              'New Password',
              style: GoogleFonts.inter(color: AppColors.blackColor),
            ),
            child: SizedBox(
              height: screenHeight * 0.05,
              child: TextFormField(
                obscureText: _obscuredN,
                focusNode: passwordf,
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
                        _obscuredN = !_obscuredN;
                      });
                    },
                    child: Icon(
                      _obscuredN
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
          Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
                onTap: (){
                  DesignerController.to.updateProfilePassword(password.text,passwordController.text,confirmPassword.text);
                },
                child: CommonButton(text: 'Update Password',width: screenWidth,borderRadius: 8.0,height: 45.0,)),
          )

        ],),
      )),
    );
  }
}
