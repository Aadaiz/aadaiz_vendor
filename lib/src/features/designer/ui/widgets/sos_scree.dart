import 'package:aadaiz_seller/src/features/designer/controller/designer_controller.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';

import '../../../../utils/utils.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(child: Column(
        children: <Widget>[
          Utils.columnSpacer(
              height: screenHeight * 0.2
          ),
          Text('Emergency Help Needed?',
              style: GoogleFonts.dmSans(
                  textStyle:  const TextStyle(
                      fontSize: 25.00,
                      color:
                      AppColors.blackColor,
                      fontWeight: FontWeight.w500))),
          Utils.columnSpacer(
              height: screenHeight * 0.2
          ),
          Center(child: InkWell(
            onLongPress: (){
              DesignerController.to.makePhoneCall();
            },
              child:  AvatarGlow(
                curve: Curves.fastLinearToSlowEaseIn,
                child: Material(
                 // elevation: 5.0,
                  shape: const CircleBorder(),
                  child: Image.asset('assets/images/gsos.png',
                    width: Get.width*0.8,
                  )
                ),
              ),
              ))
        ],
      )),
    );
  }
}
