import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';

class CustomWidgets{

  static Widget kycCompletionDialog({required double screenHeight, required double screenWidth, required BuildContext context}){

    ScreenUtil.init(context);

     return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)
        ),
        child: Container(
            height: screenHeight / 3,
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.03
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/images/verification_done.svg'
                  ),
                  Text(
                    'KYC Completed',
                    style: GoogleFonts.dmSans(
                      fontSize: 13.sp,
                      color: AppColors.blackTextColor
                    )
                  ),
                  Text(
                    'Thanks for submitting your document we’ll verify it and\ncomplete your KYC as soon as possible',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400
                    )
                  )
                ]
            )
        )
    );

  }

}