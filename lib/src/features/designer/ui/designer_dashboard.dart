
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/designer/ui/profile/designer_profile.dart';
import 'package:aadaiz_seller/src/features/designer/ui/widgets/sos_scree.dart';

import '../../../res/colors/app_colors.dart';
import '../../../utils/utils.dart';
import '../controller/designer_controller.dart';
import 'designer_home/designer_home_screeen.dart';
import 'designer_scheduled/designer_scheduled.dart';


class DesignerDashboard extends StatefulWidget {
  const DesignerDashboard({super.key});

  @override
  State<DesignerDashboard> createState() => _DesignerDashboardState();
}

class _DesignerDashboardState extends State<DesignerDashboard> {
  List icon = <Map<String, String>>[
    {'icon': 'assets/dashboard/home.svg', 'text': 'Home'},
    {'icon': 'assets/dashboard/sos.svg', 'text': 'SOS'},
    {'icon': 'assets/dashboard/sch.svg', 'text': 'Schedule'},
    {'icon': 'assets/dashboard/profile.svg', 'text': 'Profile'},
  ];

  List<Widget> screens = <Widget>[
    const DesignerHome(),
    const SosScreen(),
    const DesignerScheduled(),
    const DesignerProfile(),
  ];
  

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    ScreenUtil.init(context);
    return Obx(()=>
     PopScope(
        onPopInvoked: (bool didPop){
          if(DesignerController.to.tabSelected.value==0){
            print('object');
            // Get.to(()=> TrackOrderScreen());
          }else{
            print('object else');
          }
          // return Navigator.pop(context);
        },
        child:   Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
            child: Column(
              children: [
                Expanded(child: screens[DesignerController.to.tabSelected.value])
              ],
            )),
        bottomNavigationBar: Container(
          height: screenHeight * 0.07,
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 1))
              ]
          ),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: icon.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    if(index!=4){
                      setState(() {
                        DesignerController.to.tabSelected.value=index;
                      });
                    }else{
                    }
                  },
                  child: SizedBox(
                    width: screenWidth * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        index!=1?
                        SvgPicture.asset(
                          icon[index]['icon'],
                          height: 20.00,
                          width: 20.00,
                          color: DesignerController.to.tabSelected.value==index
                              ? AppColors.primaryColor:
      
                          AppColors.blackColor.withOpacity(0.5),
                          fit: BoxFit.contain,
                        ): SvgPicture.asset(
                          icon[index]['icon'],
                          height: 20.00,
                          width: 20.00,
                          fit: BoxFit.contain,
                        ),
                        // Image.asset(
                        //   icon[index]['icon'],
                        //   height: 16.00,
                        //   width: 16.00,
                        //   color: DesignerController.to.tabSelected.value==index
                        //       ? AppColors.primaryColor:
                        //   AppColors.blackColor.withOpacity(0.5),
                        //   fit: BoxFit.contain,
                        // ),
                        Text(icon[index]['text'],
                            style: GoogleFonts.dmSans(
                                textStyle:  TextStyle(
                                    fontSize: 11.00,
                                    color: DesignerController.to.tabSelected.value==index ? AppColors.primaryColor:
                                    AppColors.blackColor.withOpacity(0.5),
                                    fontWeight: FontWeight.w400))),
                        //const Gap(4)
                      ],
                    ),
                  ),
                );
              }),
        ),
      )
      ),
    );
  }
}
