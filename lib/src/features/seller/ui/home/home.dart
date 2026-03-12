import 'package:aadaiz_seller/src/features/auth/kyc_status_screen.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/notification_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:aadaiz_seller/src/features/seller/ui/home/completed.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/orders.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/pickup.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/selling.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/shipping.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/track_order.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';
import '../../../../res/colors/app_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<String> tabTitles = [
    'Selling',
    'Orders',
    'Shipping',
    'Pickup',
    'Track Order',
    'Completed',
  ];

  final List<Widget> tabContents = const [
    Selling(),
    Orders(),
    ShippingScreen(),
    Pickedup(),
    TrackOrder(),
    Completed(),
  ];

  Future<void> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('gettoken${prefs.getString('token')}');
  }

  @override
  void initState() {
    super.initState();
    get();
  }

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
        title: Image.asset(
          'assets/images/aadaiz_image.png',
          height: screenHeight * 0.055,
        ),
        centerTitle: false,
        actions: <Widget>[
          InkWell(onTap: (){
            Get.to(()=>NotificationListScreen());
          }, child: SvgPicture.asset('assets/images/notification.svg')),
          Utils.rowSpacer(width: screenWidth * 0.05),
        ],
      ),
      body: Column(
        children: <Widget>[
          Utils.columnSpacer(height: screenHeight * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 45,
              width: screenWidth,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(
                  color: AppColors.greyTextColor.withOpacity(0.5),
                ),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: tabTitles.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.greyTextColor.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          tabTitles[index],
                          style: GoogleFonts.dmSans(
                            fontSize: 14.sp,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Utils.columnSpacer(height: screenHeight * 0.03),
          Expanded(
            child: tabContents[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
