import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../res/colors/app_colors.dart';
import '../../../../../res/components/common_button.dart';

class CreateAddress extends StatelessWidget {
  const CreateAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          'Create Address',
          style: GoogleFonts.dmSans(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Your Name',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
              ),
              style: GoogleFonts.dmSans(),
            ),
            const SizedBox(height: 16),
            Text(
              'Address',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Address',
              ),
              style: GoogleFonts.dmSans(),
            ),
            const SizedBox(height: 16),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CommonButton(text:'Cancel',isBorder: true,),
                CommonButton(text:'Add Ticket'),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
