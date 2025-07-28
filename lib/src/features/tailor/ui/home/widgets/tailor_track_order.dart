import 'package:flutter/cupertino.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/home/widgets/tailor_order_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:aadaiz_seller/src/features/tailor/ui/home/widgets/tailor_order_card.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

import '../../../../../res/colors/app_colors.dart' show AppColors;
import '../controller/home_order_controller.dart';

class TailorTrackOrder extends StatefulWidget {
  const TailorTrackOrder({super.key});

  @override
  State<TailorTrackOrder> createState() => _TailorTrackOrderState();
}

class _TailorTrackOrderState extends State<TailorTrackOrder> {
  final TailorOrderController controller = TailorOrderController.to;


  var current_index=1;
  List order_category =['Received Orders','Send Orders'];

  var type=4;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 35,
                child: ListView.builder(
                    padding: EdgeInsets.only(left: 12),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount:order_category.length ,
                    itemBuilder: (context,index){
                      return

                        GestureDetector(
                          onTap: (){
                            setState(() {
                              current_index = index;
                              if (current_index == 0) {
                                type = 0;
                                controller.getorderlist(type: 'placed', isRefresh: true);
                              } else {
                                type = 4;
                                controller.getorderlist(type: 'track', isRefresh: true);
                              }
                            });

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(


                              decoration: BoxDecoration(
                                  color:current_index==index? AppColors.primaryColor:Colors.transparent,
                                  borderRadius: BorderRadius.circular(3),
                                  border:Border.all(color:current_index==index? Colors.transparent:AppColors.primaryColor)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(6,6,6,6),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  order_category[index] ,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color:current_index==index?  AppColors.whiteColor:AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );}
                ),
              ),
            ),

          ],
        ),
        SizedBox(height: 10,),
        Obx(() {
          return SizedBox(
            height: screenHeight * 0.702,
            child: SmartRefresher(
              controller: controller.refreshControllerforTrack,
              enablePullDown: true,
              enablePullUp: controller.nextPageUrl.value.isNotEmpty,
              onRefresh: () => controller.getorderlist(type: 'track', isRefresh: true),
              onLoading: () => controller.getorderlist(type: 'track', isLoadMore: true),
              child:controller.isLoading.value
                  ? Utils.carshimmer(lenght: 6)
                  : controller.orderlist.isEmpty
                  ? Center(
                child: Image.asset(
                  'assets/dashboard/empty.png',
                  height: screenHeight * 0.4,
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.orderlist.length,
                padding: const EdgeInsets.only(bottom: 16),
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final order = controller.orderlist[index];
                  return TailorOrderCard(
                    buttonText2: current_index == 0 ? '' : 'Track Order',
                    type: type,
                    order: order,
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }
}
