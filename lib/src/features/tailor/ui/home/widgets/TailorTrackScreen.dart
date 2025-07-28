import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/utils.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/home/model/home_order_model.dart'
    show Datum;

class Tailortrackscreen extends StatefulWidget {
  final Datum order;
  const Tailortrackscreen({super.key, required this.order});

  @override
  State<Tailortrackscreen> createState() => _TailortrackscreenState();
}

class _TailortrackscreenState extends State<Tailortrackscreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteDimColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,

        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.013),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: AppColors.blackColor,
            ),
          ),
        ),
        centerTitle: true,

        title: Text(
          'Track Order',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tracking ID : #${widget.order.orderId}',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
              ),
              Utils.columnSpacer(height: screenHeight * 0.02),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    buildTimelineItem(
                      iconPath: 'assets/images/track1.jpeg',
                      title: 'Pick Up',
                      date: '03 Mar 2024, 04:25 PM',
                      isActive: true,
                      isLast: false,
                    ),
                    buildTimelineItem(
                      iconPath: 'assets/images/track2.jpeg',
                      title: 'In Progress',
                      date: '03 Mar 2024, 04:25 PM',
                      isActive: widget.order.trackingStatus == 'progress'
                          ? true
                          : false,
                      isLast: false,
                    ),
                    buildTimelineItem(
                      iconPath: 'assets/images/track3.jpeg',
                      title: 'Delivered',
                      date: '07 Mar 2024',
                      isActive: widget.order.trackingStatus == 'delivered'
                          ? true
                          : false,
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimelineItem({
    required String iconPath,
    required String title,
    required String date,
    required bool isActive,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side: Circle + line
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children: [
              // Outer circle with active color
              isActive
                  ? Image.asset(
                      "assets/images/active.png",
                      width: 23,
                      height: 23,
                    )
                  :widget.order.trackingStatus=='delivered'? Stack(
                    children: [
                        Image.asset(
                          "assets/images/inactive.png",
                          width: 23,
                          height: 23,
                        ),
                      Positioned(top: 5,left: 5,  child: Icon(Icons.check,size: 12,color: AppColors.whiteColor,))
                      ],
                  ):Image.asset(
                "assets/images/inactive.png",
                width: 23,
                height: 23,
              ),
              if (!isLast)
                Dash(
                  direction: Axis.vertical,
                  length: 65,
                  dashLength: 4,
                  dashColor: Color(0xFFD3D3D3),
                ),
            ],
          ),
        ),
        SizedBox(width: 16),
        // Right side: Icon + text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset(iconPath, height: 20, width: 20),
                SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Text(
              date,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
