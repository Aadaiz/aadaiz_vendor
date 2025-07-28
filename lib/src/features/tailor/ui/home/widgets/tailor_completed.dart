import 'package:flutter/cupertino.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/home/widgets/tailor_order_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:aadaiz_seller/src/features/tailor/ui/home/widgets/tailor_order_card.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

import '../controller/home_order_controller.dart';

class TailorCompleted extends StatefulWidget {
  const TailorCompleted({super.key});

  @override
  State<TailorCompleted> createState() => _TailorCompletedState();
}

class _TailorCompletedState extends State<TailorCompleted> {
  final TailorOrderController controller = TailorOrderController.to;

  // @override
  // void initState() {
  //   super.initState();
  //   // Fetch initial data for 'completed' type
  //   controller.getorderlist(type: 'completed', isRefresh: true);
  // }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Obx(() {
      return SizedBox(
        height: screenHeight * 0.702,
        child: SmartRefresher(
          controller: controller.refreshControllerforCompleted,
          enablePullDown: true,
          enablePullUp: controller.nextPageUrl.value.isNotEmpty,
          onRefresh: () => controller.getorderlist(type: 'completed', isRefresh: true),
          onLoading: () => controller.getorderlist(type: 'completed', isLoadMore: true),
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
            padding: const EdgeInsets.only(bottom: 50),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final order = controller.orderlist[index];
              return TailorOrderCard(
                buttonText2: 'Completed',
                type: 7,
                order: order,
              );
            },
          ),
        ),
      );
    });
  }
}
