import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {

  final List<String> _ddList = <String>['Aadhaar Card', 'Ration Card'];
  final List<String> _ddListPan = <String>['Pan Card', 'Ration Card'];

  @override
  Widget build(BuildContext context) {
print('imageava${AuthController.to.aadhaarImage.value.path}');
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    ScreenUtil.init(context);

    return Column(
      children: <Widget>[

          SizedBox(
            height: screenHeight * 0.077,
            child: DropdownButtonFormField<String>(
              padding: EdgeInsets.zero,
                isExpanded: true,
                borderRadius: BorderRadius.circular(18),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.textFieldBorderColor
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.textFieldBorderColor
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.textFieldBorderColor
                      )
                  )
                ),
                hint: RichText(
                    text: TextSpan(
                        text: _ddList.first,
                        style: GoogleFonts.dmSans(
                            color: AppColors.blackColor,
                            fontSize: 14.sp
                        ),
                        children: const <InlineSpan>[
                          TextSpan(
                              text: ' *',
                              style: TextStyle(
                                  color: AppColors.ddStarColor
                              )
                          )
                        ]
                    )
                ),
                icon: SvgPicture.asset(
                  'assets/images/ic_dd.svg'
                ),
                items: _ddList.map<DropdownMenuItem<String>>((String val){

                  return DropdownMenuItem<String>(
                      value: val,
                      child: RichText(
                          text: TextSpan(
                            text: val,
                            style: GoogleFonts.dmSans(
                              color: AppColors.blackColor,
                                fontSize: 15.sp
                            ),
                            children: const <InlineSpan>[
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: AppColors.ddStarColor
                                )
                              )
                            ]
                          )
                      )
                  );

                }).toList(),
                onChanged: (String? val){}
            )
          ),

        Utils.columnSpacer(
            height: screenHeight * 0.05
        ),
        Obx(()=> DottedBorder(
              color: AppColors.greyTextColor,
            borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              child: SizedBox(
                height: screenHeight * 0.16,
                width: double.infinity,
                child:
                AuthController.to.aadhaarImage.value.path!=''?
                    Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                    image: DecorationImage(image: FileImage(File(AuthController.to.aadhaarImage.value.path)))
                    ),
                    ):
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Upload Aadhaar card front photo',
                      style: GoogleFonts.dmSans(
                        color: AppColors.greyTextColor,
                        fontSize: 11.sp
                      )
                    ),
                    Utils.columnSpacer(
                        height: screenHeight * 0.03
                    ),
                    InkWell(
                      onTap: (){
                        AuthController.to.showdialog(context,picture: 0);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all()
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.005,
                          horizontal: screenWidth * 0.05
                        ),
                        child: Text(
                          'Upload +',
                          style: GoogleFonts.dmSans(
                            fontSize: 11.sp,
                            color: AppColors.blackColor
                          )
                        )
                      ),
                    )
                  ]
                )
              )
          ),
        ),
        Utils.columnSpacer(
            height: screenHeight * 0.05
        ),
        SizedBox(
            height: screenHeight * 0.077,
            child: DropdownButtonFormField<String>(
                padding: EdgeInsets.zero,
                isExpanded: true,
                borderRadius: BorderRadius.circular(18),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.textFieldBorderColor
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.textFieldBorderColor
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.textFieldBorderColor
                        )
                    )
                ),
                hint: RichText(
                    text: TextSpan(
                        text: _ddListPan.first,
                        style: GoogleFonts.dmSans(
                            color: AppColors.blackColor,
                            fontSize: 14.sp
                        ),
                        children: const <InlineSpan>[
                          TextSpan(
                              text: ' *',
                              style: TextStyle(
                                  color: AppColors.ddStarColor
                              )
                          )
                        ]
                    )
                ),
                icon: SvgPicture.asset(
                    'assets/images/ic_dd.svg'
                ),
                items: _ddListPan.map<DropdownMenuItem<String>>((String val){

                  return DropdownMenuItem<String>(
                      value: val,
                      child: RichText(
                          text: TextSpan(
                              text: val,
                              style: GoogleFonts.dmSans(
                                  color: AppColors.blackColor,
                                  fontSize: 15.sp
                              ),
                              children: const <InlineSpan>[
                                TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                        color: AppColors.ddStarColor
                                    )
                                )
                              ]
                          )
                      )
                  );

                }).toList(),
                onChanged: (String? val){}
            )
        ),
        Utils.columnSpacer(
            height: screenHeight * 0.05
        ),
        Obx(()=>
           DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              child: SizedBox(
                  height: screenHeight * 0.16,
                  width: double.infinity,
                  child:AuthController.to.panImage.value.path!=''?
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: FileImage(File(AuthController.to.panImage.value.path)))
                    ),
                  ):
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            'Upload Pan card front photo',
                            style: GoogleFonts.dmSans(
                                color: AppColors.greyTextColor,
                                fontSize: 11.sp
                            )
                        ),
                        Utils.columnSpacer(
                            height: screenHeight * 0.03
                        ),
                        InkWell(
                          onTap: (){
                            AuthController.to.showdialog(context,picture: 1);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all()
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.005,
                                  horizontal: screenWidth * 0.05
                              ),
                              child: Text(
                                  'Upload +',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 11.sp,
                                      color: AppColors.blackColor
                                  )
                              )
                          ),
                        )
                      ]
                  )
              )
          ),
        )
      ]
    );

  }

}