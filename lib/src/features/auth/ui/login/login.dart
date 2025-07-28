import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/auth/ui/login/seller_login.dart';
import 'package:aadaiz_seller/src/features/auth/ui/login/tailor_login.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {

    super.initState();
    _tabController = TabController(length: 2, vsync: this);

  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    ScreenUtil.init(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(screenWidth*0.05, screenHeight*0.09, screenWidth*0.05, 5),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Image.asset(
                              'assets/images/aadaiz_image.png'
                          ),
                        ),
                        Utils.columnSpacer(
                          height: screenHeight * 0.046
                        ),
                        Text(
                          '  Choose Your account Type',
                          style: GoogleFonts.kaiseiDecol(
                              fontSize : 20.sp
                          )
                        ),
                        Utils.columnSpacer(
                            height: screenHeight * 0.035
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(18),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.blackColor.withOpacity(0.1),
                                    blurRadius: 20,
                                  offset: const Offset(0, 3)
                                )
                              ]
                            ),
                            child: TabBar(
                              controller: _tabController,
                                labelPadding: EdgeInsets.zero,
                                indicatorColor: Colors.transparent,
                                labelColor: AppColors.whiteColor,
                                unselectedLabelColor: AppColors.blackColor,
                                labelStyle: GoogleFonts.dmSans(
                                  fontSize: 14.sp
                                ),
                                indicator: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(18)
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                dividerColor: Colors.transparent,
                                tabs: const <Widget>[
                                  Tab(
                                    child: Text(
                                        'Seller'
                                    )
                                  ),
                                  Tab(
                                      child: Text(
                                          'Tailor'
                                      )
                                  )
                                ]
                            )
                          )
                        ),
                        Utils.columnSpacer(
                            height: screenHeight * 0.03
                        ),
                        AutoScaleTabBarView(
                          controller: _tabController,
                          children: const <Widget>[
                            SellerLogin(),
                            TailorLogin()
                          ]
                        )
                      ]
                  )
                )
            )
        )
      )
    );

  }

}