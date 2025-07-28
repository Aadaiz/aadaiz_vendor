import 'package:aadaiz_seller/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../colors/app_colors.dart';

class CommonButton extends StatefulWidget {
  const CommonButton(
      {super.key,
      required this.text,
      this.isBorder = false,
      this.width,
      this.borderRadius,
      this.height, this.isLoading=false,   this.ontap});
  final String text;
  final bool? isBorder;
  final dynamic width;
  final dynamic height;
  final dynamic borderRadius;
  final dynamic isLoading;

  final VoidCallback? ontap;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        height: widget.height ?? 30,
        width: widget.width ?? screenWidth * 0.4,
        decoration: BoxDecoration(
            color: widget.isBorder == true
                ? Colors.transparent
                : AppColors.primaryColor,
            border: Border.all(
                color: widget.isBorder == false
                    ? Colors.transparent
                    : AppColors.primaryColor),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0)),
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Center(
          child:
           widget.isLoading?
          SizedBox(
            height: 03.00.hp,
            width: 5.00.hp,
            child: LoadingAnimationWidget.horizontalRotatingDots(
              color: AppColors.whiteColor,
              size: 5.00.hp,
            ),
          )
          :Text(
            widget.text,
            style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    fontSize: 15,
                    color: widget.isBorder == true
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}
