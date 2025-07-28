import 'package:aadaiz_seller/src/features/seller/ui/home/controller/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/widgets/track_order_screen.dart';

import '../../../../../res/colors/app_colors.dart';
import '../../../../../res/components/common_button.dart';
import '../../../../../utils/utils.dart';

import 'package:aadaiz_seller/src/features/seller/ui/home/model/SellerOrder_model.dart'
    show Datum;

class OrderCard extends StatelessWidget {
  OrderCard({
    super.key,
    this.type,
    required this.buttonText1,
    required this.buttonText2,
    this.data,
  });
  final dynamic type;
  final String buttonText1;
  final String buttonText2;
  Datum? data;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          width: screenWidth * 0.13,
                          height: screenWidth * 0.13,
                          fit: BoxFit.cover,
                          errorWidget:
                              (
                                BuildContext context,
                                String url,
                                Object error,
                              ) => Image.asset(
                                'assets/images/mat.png',
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2,
                                fit: BoxFit.fill,
                              ),
                          progressIndicatorBuilder:
                              (
                                BuildContext context,
                                String url,
                                DownloadProgress progress,
                              ) => Container(
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2,
                                color: Colors.black,
                                child: Center(
                                  child: Transform.scale(
                                    scale: 0.5,
                                    child: CircularProgressIndicator(
                                      color: Colors.grey,
                                      strokeWidth: 2,
                                      value: progress.progress,
                                    ),
                                  ),
                                ),
                              ),
                          imageUrl: (data?.products!.image ?? ''),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    data?.products!.category ?? '',
                                    style: GoogleFonts.dmSans(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.50),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Order Date ${data!.orderDate ?? ''}',
                                    style: GoogleFonts.dmSans(
                                      textStyle: const TextStyle(
                                        fontSize: 10,
                                        color: AppColors.greyTextColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Expand/Collapse Arrow
                    ],
                  ),
                  const SizedBox(height: 16),
                  detailsText(
                    width: screenWidth * 0.3,
                    title: 'Order ID',
                    value: ':   #${data!.orderId ?? ''}',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  detailsText(
                    width: screenWidth * 0.3,
                    title: 'Qnt',
                    value: ':   ${data!.quantity ?? ''}Unit',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  detailsText(
                    width: screenWidth * 0.3,
                    title: 'Price',
                    value: ':   ₹${data!.products!.price ?? ''}',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  type != 3
                      ? detailsText(
                          width: screenWidth * 0.3,
                          title: 'Payment Mode',
                          value: ':   Cash On Delivery',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        )
                      : detailsText(
                          width: screenWidth * 0.3,
                          title: 'Payment Status',
                          value: ':   Completed',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                  type != 0 && type != 3
                      ? detailsText(
                          width: screenWidth * 0.3,
                          title: 'Tracking ID',
                          value: ':   #123456',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        )
                      : const SizedBox(),
                  const SizedBox(height: 16),
                  type != 0 && type != 3
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Order Date ${data!.orderDate ?? ''}',
                                  style: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.starColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        )
                      : const SizedBox(),
                  type == 2||type==3
                      ? Obx(()=>
                         CommonButton(
                           isLoading: HomeController.to.isLoadingStatusById[data?.id.toString()] ?? false,
                              text: '${buttonText2}',
                              ontap: (){
                             if(type==2){
                             if (data?.id != null) {
                                HomeController.to.updatedOrderstatus(
                                  id: data!.id.toString(),
                                  status: type == 2
                                      ? 'track'

                                      : '',
                                  type: type,
                                );
                              } }else{Get.to(()=> TrackOrderScreen(data:data ));}},
                              width: screenWidth,
                            ),
                      )

                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CommonButton(text: buttonText1, isBorder: true),
                            Obx(()=>
                              CommonButton(
                                text: buttonText2,
        isLoading: HomeController.to.isLoadingStatusById[data?.id.toString()] ?? false,
        ontap: () {
          if (data?.id != null) {
            HomeController.to.updatedOrderstatus(
              id: data!.id.toString(),
              status: type == 0
                  ? 'shipping'
                  : type == 1
                  ? 'pickup'
                  : type == 2
                  ? 'track'
                  : type == 4
                  ? 'completed'
                  : '',
              type: type,
            );
          } },
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
          Utils.columnSpacer(height: screenHeight * 0.001),
        ],
      ),
    );
  }

  Widget detailsText({
    required String title,
    required String value,
    required FontWeight fontWeight,
    required double fontSize,
    required dynamic width,
  }) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: width,
              child: Text(
                title,
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                    fontSize: 12,
                    color: AppColors.greyTextColor.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Text(
              value,
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                  fontSize: fontSize,
                  color: AppColors.greyTextColor.withOpacity(0.5),
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
