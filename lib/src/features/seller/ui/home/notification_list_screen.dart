import 'package:aadaiz_seller/src/features/seller/ui/profile/controller/profile_controller.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/widgets/payment_history_card.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../res/colors/app_colors.dart';
import 'controller/home_controller.dart';



class NotificationListScreen extends StatefulWidget {


  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  final HomeController _controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
       //_controller.getNotificationList(isRefresh: true);
    // });
  }

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
          'Notification',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _controller.refreshNotification,

        onRefresh: () {
          _controller.getNotificationList(isRefresh: true);
        },

        onLoading: () {
          _controller.getNotificationList();
        },

        child: GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.isLoading.value) {
              return Utils.carshimmer(lenght: 5);
            } else if (controller.notificationList.isEmpty) {
              return const Center(child: Text("No Data"));
            } else {
              return Column(
                children: [
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.notificationList.length,
                      itemBuilder: (context, index) {
                        final data = controller.notificationList[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child:CommonHistoryItem(
                                title: data.title ?? '',
                                message: data.message ?? '',
                                date: DateFormat('dd/MM/yyyy').format(DateTime.parse(data.createdAt.toString())),
                                icon: Icons.notifications,
                                isNotification: true,
                              )
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}