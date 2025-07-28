import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/res/components/loading_button.dart';
import 'package:aadaiz_seller/src/res/components/widgets/overlay_widgets.dart';
import 'package:aadaiz_seller/src/utils/form_validation.dart';
import 'package:aadaiz_seller/src/utils/routes/routes_name.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

class TailorLogin extends StatefulWidget {
  const TailorLogin({super.key});

  @override
  State<TailorLogin> createState() => _TailorLoginState();
}

class _TailorLoginState extends State<TailorLogin> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();

  @override
  void dispose() {

    super.dispose();
    _email.dispose();
    _mobile.dispose();
    _emailFocus.dispose();
    _mobileFocus.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    ScreenUtil.init(context);

    return Obx(()=>
      Column(
          children: <Widget>[
            OverlayWidgets.fullWidthTextField(
                label: Text(
                    'Email address',
                    style: GoogleFonts.inter(
                        color: AppColors.blackColor
                    )
                ),
                child: TextFormField(
                    controller: AuthController.to.email,
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: 'helloworld@gmail.com',
                        hintStyle: GoogleFonts.inter(
                            color: AppColors.hintTextColor,
                            fontSize: 12.sp
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
                        )
                    ),
                    onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                        context: context,
                        currentFocus: _emailFocus,
                        nextFocus: _mobileFocus
                    )
                )
            ),
            OverlayWidgets.fullWidthTextField(
                label: Text(
                    'Phone Number',
                    style: GoogleFonts.inter(
                        color: AppColors.blackColor
                    )
                ),
                child: TextFormField(
                    controller: AuthController.to.mobile,
                    focusNode: _mobileFocus,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FormValidation.allowedIntegers,
                      FormValidation.ignoreDots
                    ],
                    decoration: InputDecoration(
                        isDense: true,
                        fillColor: AppColors.whiteColor,
                        filled: true,
                        hintText: '+91   123 456 7890',
                        hintStyle: GoogleFonts.inter(
                            color: AppColors.hintTextColor,
                            fontSize: 12.sp
                        ),
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
                        )
                    ),
                    onFieldSubmitted: (String val){

                      _emailFocus.unfocus();
                      _mobileFocus.unfocus();

                    }
                )
            ),
            Utils.columnSpacer(
                height: screenHeight * 0.07
            ),
            LoadingButton(
                title: 'Continue',
                loading: AuthController.to.signUpLoading.value,
                onPressed: (){
                  AuthController.to.signUp(type: 'Tailer');
                },
                btnWidth: screenWidth / 1.2,
                btnHeight: screenHeight * 0.07
            )
          ]
      ),
    );

  }

}