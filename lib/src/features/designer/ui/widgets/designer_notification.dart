import 'package:aadaiz_seller/src/features/designer/controller/designer_controller.dart';
import 'package:aadaiz_seller/src/features/designer/ui/profile/bloc/designer_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../res/colors/app_colors.dart';
import '../../../../utils/utils.dart';

class DesignerNotification extends StatefulWidget {
  const DesignerNotification({super.key});

  @override
  State<DesignerNotification> createState() => _DesignerNotificationState();
}

class _DesignerNotificationState extends State<DesignerNotification> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: true,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: AppColors.blackColor,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Notification',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                color: AppColors.blackColor,
                fontSize: 20,
              ),
            ),
            SizedBox(width: screenWidth * 0.1),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.8,
              child: SmartRefresher(
                controller: _refreshController,
                physics: const AlwaysScrollableScrollPhysics(),
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () async {
                  final result = await DesignerController.to.getNotifications(
                    isRefresh: true,
                  );
                  if (result) {
                    _refreshController.refreshCompleted();
                  } else {
                    _refreshController.refreshFailed();
                  }
                },
                onLoading: () async {
                  final result = await DesignerController.to.getNotifications();
                  if (DesignerController.to.notificationCurrentPage.value >=
                      DesignerController.to.notificationTotalPages.value) {
                    _refreshController.loadNoData();
                  } else {
                    if (result) {
                      _refreshController.loadComplete();
                    } else {
                      _refreshController.loadFailed();
                    }
                  }
                },
                child: Obx(
                  () => ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: DesignerController.to.notificationList.length,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (BuildContext context, int index) {
                      final data =
                          DesignerController.to.notificationList[index];
                      return Column(
                        children: [
                          data.entityType != 'appointment'
                              ? NotificationCard(
                                  icon: Icons.check_circle,
                                  iconColor: Colors.green,
                                  title: '${data.title ?? ''}',
                                  description: '${data.message ?? ''}',
                                  time: 'Just Now',
                                )
                              : NotificationCardWithAvatar(
                                  avatarImage:
                                      'assets/avatar.png', // Replace with actual path to avatar image
                                  name: 'Veronica',
                                  location: 'Chennai',
                                  title: 'Appointment Scheduled!',
                                  description:
                                      '05 May 2024 Appointment Scheduled Successfully',
                                  time: 'Just Now',
                                ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 16.0);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget NotificationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required String time,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24.0),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        time,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyTextColor.withOpacity(0.5),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget NotificationCardWithAvatar({
    required String avatarImage,
    required String name,
    required String location,
    required String title,
    required String description,
    required String time,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(avatarImage),
                radius: 24.0,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    time,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyTextColor.withOpacity(0.5),
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                location,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyTextColor.withOpacity(0.5),
                  fontSize: 10,
                ),
              ),
            ),
            Text(
              title,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
                fontSize: 13,
              ),
            ),
            Text(
              description,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                color: AppColors.blackColor,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
