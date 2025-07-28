import 'package:aadaiz_seller/src/features/seller/ui/home/controller/home_controller.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/profile.dart';
import 'package:aadaiz_seller/src/features/seller/ui/sell/add_catalogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/colors/app_colors.dart';
import '../../../utils/utils.dart';

import 'dashboard/dashboard_screen.dart';
import 'home/home.dart';

class Dashboard extends StatelessWidget {
  final HomeController controller =Get.put(HomeController());

  Dashboard({super.key});

  final List<Map<String, String>> icon = [
    {'icon': 'assets/dashboard/home.svg', 'text': 'Home'},
    {'icon': 'assets/images/plusb.svg', 'text': 'Sell'},
    {'icon': 'assets/dashboard/dashboard.svg', 'text': 'Dashboard'},
    {'icon': 'assets/dashboard/profile.svg', 'text': 'Profile'},
  ];

  final List<Widget> screens = [
    Home(),
    const SizedBox(),
    DashboardScreen(),
    Profile(),
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
            itemCount: icon.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (index == 1) {
                    addCatalogueBottomSheet(context);
                  } else {
                    controller.setTab(index);
                  }
                },
                child: SizedBox(
                  width: screenWidth * 0.25,
                  child: Obx(() {
                    final isSelected = controller.selectedIndex.value == index;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          icon[index]['icon']!,
                          height: 16,
                          width: 16,
                          color: (isSelected )
                              ? AppColors.primaryColor
                              :index==1?AppColors.primaryColor: AppColors.blackColor.withOpacity(0.5),
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
        )

    );
  }

  void addCatalogueBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: AppColors.whiteDimColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (_) => const AddCatalogue(),
    );
  }
}

