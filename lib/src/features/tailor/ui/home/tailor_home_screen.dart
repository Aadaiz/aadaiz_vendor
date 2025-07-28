

import 'package:aadaiz_seller/src/features/tailor/ui/home/widgets/tailor_completed.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/home/widgets/tailor_orders.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/home/widgets/tailor_pickup.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/home/widgets/tailor_track_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/colors/app_colors.dart';
import '../../../../utils/utils.dart';
import 'controller/home_order_controller.dart';

class TailorHome extends StatefulWidget {
  const TailorHome({super.key});

  @override
  State<TailorHome> createState() => _TailorHomeState();
}

class _TailorHomeState extends State<TailorHome> {
  final TailorOrderController controller = TailorOrderController.to;
  List<String> tabs = ['Assigned Order', 'Pick Up', 'Track Order', 'Completed Order'];
  List<Widget> screens = const <Widget>[
    TailorOrders(),
    TailorPickup(),
    TailorTrackOrder(),
    TailorCompleted(),
  ];
  int selected = 0;
  bool isSwitched = false;
  // final ScrollController _scrollController = ScrollController(); // Added ScrollController
  //
  // @override
  // void dispose() {
  //   _scrollController.dispose(); // Dispose the controller to prevent memory leaks
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        surfaceTintColor: AppColors.whiteColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(
            'assets/images/aadaiz_image.png',
            height: screenHeight * 0.053,
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isSwitched ? 'ORDER ON' : 'ORDER OFF',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                Transform.scale(
                  scale: 0.69,
                  child: Switch(
                    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.greenAccent.shade400,
                    inactiveTrackColor: Colors.grey.shade300,
                    inactiveThumbColor: Colors.white,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
          Utils.rowSpacer(width: screenWidth * 0.05),
          SvgPicture.asset('assets/images/notification.svg'),
          Utils.rowSpacer(width: screenWidth * 0.05),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Utils.columnSpacer(height: screenHeight * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: SizedBox(
                height: 30,
                child: ListView.separated(
                  // controller: _scrollController, // Attach ScrollController
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: tabs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                        // Scroll to left end for any tab click
                        // final double tabWidth = 125; // Width of each tab container
                        // final double separatorWidth = 16; // Width of separator
                        // final double scrollOffset = (tabWidth + separatorWidth) * index;
                        // _scrollController.animateTo(
                        //   scrollOffset,
                        //   duration: Duration(milliseconds: 300),
                        //   curve: Curves.easeInOut,
                        // );
                        // Fetch data for the selected tab
                        String type;
                        switch (index) {
                          case 0:
                            type = 'placed';
                            break;
                          case 1:
                            type = 'pickup';
                            break;
                          case 2:
                            type = 'track';
                            break;
                          case 3:
                            type = 'completed';
                            break;
                          default:
                            type = 'placed';
                        }
                        controller.getorderlist(type: type, isRefresh: true);
                      },
                      child: Container(
                        width: 125,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: selected != index
                              ? AppColors.whiteColor
                              : AppColors.starColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          tabs[index],
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: selected != index
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 16);
                  },
                ),
              ),
            ),
            Utils.columnSpacer(height: screenHeight * 0.027),
            Expanded(
              child: SizedBox(
                height: screenHeight * 0.8,
                child: screens[selected],
              ),
            ),
          ],
        ),
      ),
    );
  }
}