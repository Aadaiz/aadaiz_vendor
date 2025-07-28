import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';

class LoadingButton extends StatelessWidget {

  final String title;
  final bool loading;
  final VoidCallback onPressed;
  final double btnWidth;
  final double btnHeight;
  final double txtFontSize;
  final Color bgColor;
  final dynamic fontweight;
  final double radius;
  final double verticalheight;

  const LoadingButton({
    super.key,
    required this.title,
    this.loading = false,
    required this.onPressed,
    required this.btnWidth,
    this.btnHeight = 30,
    this.txtFontSize = 16,
    this.bgColor = AppColors.primaryColor
    ,this.fontweight=FontWeight.bold , this.radius=8,this.verticalheight=8
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
        onTap: onPressed,
        child: Container(
            padding: const EdgeInsets.only(
                left: 8,
                right: 5
            ),
            height: btnHeight,
            width: btnWidth,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(radius)
            ),
            child: Padding(
                padding:  EdgeInsets.symmetric(
                    vertical: verticalheight
                ),
                child: Center(
                    child: loading ?
                    LoadingAnimationWidget.horizontalRotatingDots(
                        color: AppColors.whiteColor,
                        size: btnHeight / 1.5
                    ) :
                    Text(
                        title,
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: fontweight,
                            fontSize: txtFontSize
                        ),
                        textAlign: TextAlign.center
                    )
                )
            )
        )
    );

  }

}