import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/res/components/loading_button.dart';
import 'package:aadaiz_seller/src/utils/form_validation.dart';
import 'package:aadaiz_seller/src/utils/routes/routes_name.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpAuth extends StatefulWidget {

  final String phoneNumber;
  final String type;

  const OtpAuth({super.key, required this.phoneNumber, required this.type});

  @override
  State<OtpAuth> createState() => _OtpAuthState();
}

class _OtpAuthState extends State<OtpAuth> {
String otp='';
  late Timer _timer;
  bool showResend=false;
  int _secondsRemaining = 60;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_secondsRemaining == 1) {
        timer.cancel();
        setState(() {
          showResend = true;
        });
        print('Timer reached 1 second!');
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AuthController.to.verifyLoading(false); // ✅ safe
    });
    startTimer();
  }

  final OtpFieldController _otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.022
          ),
          child: InkWell(
            onTap: ()=> Navigator.pushNamed(context, RoutesName.loginActivity),
            child: SvgPicture.asset(
              'assets/images/back.svg'
            )
          )
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.055
          ),
          child: Obx(()=>
             Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Utils.columnSpacer(
                      height: screenHeight * 0.03
                  ),
                  Text(
                      'Enter code',
                      style: GoogleFonts.dmSans(
                          fontSize: 16.sp,
                          color: AppColors.primaryColor
                      )
                  ),
                  Utils.columnSpacer(
                      height: screenHeight * 0.01
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'We’ve sent an SMS with an activation code to\nyour phone ',
                          style: GoogleFonts.dmSans(
                              fontSize: 13.sp,
                              color: AppColors.primaryColor
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                                text: widget.phoneNumber,
                                style: GoogleFonts.dmSans(
                                    fontSize: 13.sp,
                                    color: AppColors.blackColor.withOpacity(0.7)
                                )
                            )
                          ]
                      )
                  ),
                  Utils.columnSpacer(
                      height: screenHeight * 0.066
                  ),
                  Center(
                      child: OTPTextField(
                          controller: _otpController,
                          length: 6,
                          outlineBorderRadius: 4,
                          width: screenWidth - 100,
                          fieldWidth: screenWidth * 0.11,
                          fieldStyle: FieldStyle.box,
                          inputFormatter: <TextInputFormatter>[
                            FormValidation.allowedIntegers,
                            FormValidation.ignoreDots
                          ],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          otpFieldStyle: OtpFieldStyle(
                              focusBorderColor: AppColors.textFieldBorderColor,
                              enabledBorderColor: AppColors.textFieldBorderColor,
                              borderColor: AppColors.textFieldBorderColor
                          ),
                          onCompleted: (String val){
                            setState(() {
                              otp=val;
                            });
                          }
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.018
                      ),
                      child: Center(
                          child: showResend?
                          RichText(
                              text: TextSpan(
                                  text: 'I didn’t receive a code? ',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 13.sp,
                                      color: AppColors.primaryColor
                                  ),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: 'Resend',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 13.sp,
                                            color: AppColors.blackColor.withOpacity(0.7)
                                        ),
                                        recognizer: TapGestureRecognizer()..onTap = () {
                                          _timer.cancel();
                                          setState(() {
                                            _secondsRemaining = 60;
                                            showResend = false;
                                            AuthController.to.verifyLoading(false);
                                          });
                                          AuthController.to.signUp(type: 'Seller');
                                          startTimer();
                                        }
                                    )
                                  ]
                              )
                          ):
                          Countdown(
                            seconds: 60,
                            build: (BuildContext context, double time){

                              return RichText(
                                  text: TextSpan(
                                      text: 'Send code again  ',
                                      style: GoogleFonts.dmSans(
                                          fontSize: 13.sp,
                                          color: AppColors.primaryColor
                                      ),
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: '00.${time.toInt()}',
                                            style: GoogleFonts.dmSans(
                                                fontSize: 13.sp,
                                                color: AppColors.blackColor.withOpacity(0.7)
                                            )
                                        )
                                      ]
                                  )
                              );

                            },
                            //    onFinished: ()=> context.read<SmsCubit>().otpCountdownTimeout()
                          )
                      )
                  ),
                  Utils.columnSpacer(
                      height: screenHeight * 0.22
                  ),

                  LoadingButton(
                      title: 'Verify',
                      loading: AuthController.to.verifyLoading.value,
                      onPressed: (){
                        AuthController.to.verifyOtp(context,otp,widget.type);
                      },
                      btnWidth: screenWidth / 1.1,
                      btnHeight: screenHeight * 0.07
                  ),
                ]
            ),
          )
        )
      )
    );

  }

}