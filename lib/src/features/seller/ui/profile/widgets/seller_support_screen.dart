import 'package:aadaiz_seller/src/features/seller/ui/profile/controller/profile_controller.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/widgets/support_cart.dart';

import '../../../../../res/colors/app_colors.dart';
import '../../../../../res/components/common_button.dart';
import 'create_support.dart';

class SellerSupportScreen extends StatefulWidget {
  const SellerSupportScreen({super.key});

  @override
  State<SellerSupportScreen> createState() => _SellerSupportScreenState();
}

class _SellerSupportScreenState extends State<SellerSupportScreen> {
  List<String> titleList = ['All', 'Pending', 'Closed'];
  int _index = 0;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    ProfileController.to.getSupportList();
  }

  void _onRefresh() async {
    await ProfileController.to.getSupportList( isRefresh: true);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await ProfileController.to.getSupportList( isLoadMore: true);
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
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
          'Seller Support',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          // Tab Bar
          SizedBox(height: 15),
          Container(
            height: 50,
            width: screenWidth,
            padding: EdgeInsets.only(left: 27, right: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(titleList.length, (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _index = index;
                      ProfileController.to.getSupportList( isRefresh: true);
                    });
                    _refreshController.requestRefresh();
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          titleList[index],
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            color: _index == index
                                ? AppColors.primaryColor
                                : AppColors.greyTextColor.withOpacity(0.7),
                            fontWeight: _index == index
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (_index == index)
                        Container(
                          height: 1.5,
                          width: _index == 1
                              ? 75
                              : _index == 2
                              ? 65
                              : 35,
                          color: AppColors.primaryColor,
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
          // Content
          SizedBox(height: 15),
          Expanded(
            child: Obx(
                  () => ProfileController.to.isLoading.value && ProfileController.to.supportList.isEmpty
                  ? Utils.carshimmer(lenght: 5)
                  : ProfileController.to.supportList.isEmpty
                  ? Center(child: Text("No Data"))
                  : SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: ProfileController.to.hasMore.value,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                  itemCount: ProfileController.to.supportList.length,
                  itemBuilder: (context, index) {
                    final data = ProfileController.to.supportList[index];
                    return Column(
                      children: [
                        SupportCart(data: data),
                        SizedBox(height: 16.0),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(() => const CreateSupport());
        },
        child: const Icon(
          Icons.add_circle_rounded,
          size: 40,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}