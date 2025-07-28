
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors/app_colors.dart';


class CustomizeAppBar extends StatelessWidget {
  const CustomizeAppBar({super.key, this.text});
  final dynamic text;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios_new_rounded,size: 25,color: AppColors.primaryColor,)
            ),
          ],
        ),
        const Spacer(),
        Text(
          '$text',
          style: GoogleFonts.dmSans(
              textStyle: const TextStyle(
                  fontSize: 18.00,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w400)),
        ),
        const Spacer(),
      ],
    );
  }
}
