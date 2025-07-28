import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/utils/utils.dart'; // Adjust import based on your project structure


import '../../../../res/colors/app_colors.dart' show AppColors;
import '../../controller/tailor_controller.dart';
import '../dashboard_widget/tailor_dashboard_screen.dart';
import '../home/tailor_home_screen.dart';
import '../profile/tailor_profile.dart'; // Adjust import

class TailorDashboard extends StatelessWidget {
  final TailorController controller = Get.put(TailorController());

  TailorDashboard({super.key});

  final List<Map<String, String>> icon = [
    {'icon': 'assets/dashboard/home.svg', 'text': 'Home'},
    {'icon': 'assets/dashboard/dashboard.svg', 'text': 'Dashboard'},

    {'icon': 'assets/dashboard/profile.svg', 'text': 'Profile'},
  ];

  final List<Widget> screens = [
    const TailorHome(),
    const TailorDashboardScreen(),

    const TailorProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = Utils.getActivityScreenHeight(context);
    final screenWidth = Utils.getActivityScreenWidth(context);
    ScreenUtil.init(context);

    return Scaffold(
      body: Obx(() {
        final tab = controller.selectedIndex.value;
        return IndexedStack(
          index: tab,
          children: screens,
        );
      }),
      bottomNavigationBar: Container(
        height: screenHeight * 0.07,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: icon.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                controller.setTab(index);
              },
              child: SizedBox(
                width: screenWidth * 0.333333, // Adjusted for 3 tabs
                child: Obx(() {
                  final isSelected = controller.selectedIndex.value == index;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        icon[index]['icon']!,
                        height: 16,
                        width: 16,
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.blackColor.withOpacity(0.5),
                      ),
                      Text(
                        icon[index]['text']!,
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.blackColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}