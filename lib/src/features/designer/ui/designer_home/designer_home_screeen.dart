import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/designer/ui/designer_home/widgets/designer_completed.dart';
import 'package:aadaiz_seller/src/features/designer/ui/designer_home/widgets/scheduled.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

import '../../../../res/colors/app_colors.dart';
import '../widgets/user_header.dart';

class DesignerHome extends StatefulWidget {
  const DesignerHome({super.key});

  @override
  State<DesignerHome> createState() => _DesignerHomeState();
}

class _DesignerHomeState extends State<DesignerHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Widget> tabs = const <Widget>[
    Tab(child: Text('Scheduled',)),
    Tab(child: Text('Completed')),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16),
            child: UserHeader(),
          ),
          Utils.columnSpacer(height: screenHeight * 0.01),
          Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Container(
                  height: 40,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(
                        color: AppColors.greyTextColor.withOpacity(0.5)),
                  ),
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    controller: _tabController,
                    labelPadding: const EdgeInsets.all(8),
                    indicatorPadding: const EdgeInsets.all(6),
                    padding: EdgeInsets.zero,
                    indicatorColor: Colors.transparent,
                    labelColor: AppColors.blackColor,
                    unselectedLabelColor: AppColors.blackColor,
                    labelStyle: GoogleFonts.dmSans(
                        fontSize: 14.sp, color: AppColors.whiteColor),
                    unselectedLabelStyle: GoogleFonts.dmSans(
                      color: AppColors.blackColor,
                      fontSize: 14.sp,
                    ),
                    indicator: BoxDecoration(
                        color: AppColors.greyTextColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4)),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    tabs: tabs,
                  ))),
          Utils.columnSpacer(height: screenHeight * 0.03),
          Expanded(
            child: AutoScaleTabBarView(
                controller: _tabController,
                children:  const <Widget>[
                  Scheduled(),
                  DesignerCompleted(),
                ]),
          ),
        ],
      ),
    );
  }
}
