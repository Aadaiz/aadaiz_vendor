import 'package:aadaiz_seller/src/features/tailor/ui/home/widgets/tailor_confirm_order.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/home/widgets/tailor_orders.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/home/widgets/tailor_track_order.dart';
import 'package:aadaiz_seller/src/res/components/loading_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../res/colors/app_colors.dart';
import '../../../../../res/components/common_button.dart';
import '../../../../../utils/utils.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/home/model/home_order_model.dart'
    show Datum;

import '../controller/home_order_controller.dart';
import 'TailorTrackScreen.dart';

class TailorOrderCard extends StatefulWidget {
   TailorOrderCard({
    super.key,
    this.type,
    required this.buttonText2,
    required this.order,
  });
   dynamic type;
  final String buttonText2;
  final Datum order;

  @override
  State<TailorOrderCard> createState() => _TailorOrderCardState();
}

class _TailorOrderCardState extends State<TailorOrderCard> {
  String downloadText() {
    switch (widget.type) {
      case 0:
        return 'Dress & Measurement';
      case 3:
        return 'Dress & Measurement Sheet';
      case 4:
        return 'Dress & Measurement Sheet';
      default:
        return 'Dress & Measurement';
    }
  }

  double titleWidth() {
    switch (widget.type) {
      case 0:
        return 0.35;
      case 3:
        return 0.4;
      case 4:
        return 0.4;
      case 7:
        return 0.5;
      default:
        return 0.24;
    }
  }

  bool isShow() {
    switch (widget.type) {
      case 0:
        return false;
      case 3:
        return false;
      case 4:
        return true;
      case 7:
        return false;
      default:
        return false;
    }
  }

  final TailorOrderController controller = TailorOrderController.to;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        children: [
          Column(
            children: [
              // if(widget.buttonText2=='Track Order')

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
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              width: widget.type == 0 ? 55 : screenWidth * 0.18,
                              height: widget.type == 0 ? 55 : screenWidth * 0.2,
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
                              imageUrl: (widget.order.pattern!.imageUrl!),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    SizedBox(
                                      // width: screenWidth*titleWidth(),
                                      child: Text(
                                        widget.order.pattern!.title ?? '',
                                        maxLines: 3,
                                        style: GoogleFonts.dmSans(
                                          textStyle: const TextStyle(
                                            fontSize: 20,
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),

                                    widget.type == 0
                                        ? Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                4,
                                              ),
                                              color: AppColors.greyTextColor
                                                  .withOpacity(0.1),
                                            ),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/down.png',
                                                  height: 12,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  downloadText(),
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors.blackColor,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : widget.type == 4 || widget.type == 3
                                        ? Expanded(
                                            child: detailsText1(
                                              width: screenWidth * 0.1,
                                              title: 'Order ID :',
                                              value: "#${widget.order.orderId}",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                                const SizedBox(height: 3.50),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Mini Vado Odelle Dress',
                                        style: GoogleFonts.dmSans(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.greyTextColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.50),
                                widget.type == 7
                                    ? Row(
                                        children: [
                                          Text(
                                            'Delivered Date 26 May 2024',
                                            style: GoogleFonts.dmSans(
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                color: AppColors.starColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : widget.type == 3 || widget.type == 4
                                    ? Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                4,
                                              ),
                                              color: AppColors.greyTextColor
                                                  .withOpacity(0.1),
                                            ),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/down.png',
                                                  height: 12,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  downloadText(),
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors.blackColor,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          // Expand/Collapse Arrow
                        ],
                      ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      widget.type == 7 || widget.type == 4
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: detailsText(
                                title: 'Payment Status : ',
                                value: ' Successful ',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                width: screenWidth * 0.5,
                              ),
                            )
                          : const SizedBox(),
                      if (widget.type != 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 5),
                          child: Obx(()=>
                           LoadingButton(
                              loading: TailorOrderController.to.isLoadingStatusById[widget.order.id]??false,
                              radius: 3,
                            fontweight: FontWeight.w400,txtFontSize: 14,
                            verticalheight: 6,
                              onPressed: (){
                                switch (widget.type) {
                                  case 4:
                                    Get.to(() => Tailortrackscreen(order:widget.order));
                                    break;
                                  case 3:
                                    Get.to(() => OrderStatusScreen(order:widget.order));
                                    break;
                                  case 7:
                                    TailorOrderController.to.updatedOrderstatus(
                                      id: widget.order.id,
                                      status: "completed",
                                      type: 7,
                                      material_status: '',
                                    );
                                    break;
                                  default:

                                    break;
                                }
                              },
                              title: widget.buttonText2,
                              bgColor: AppColors.primaryColor,
                              btnHeight: 30.0,
                              btnWidth: screenWidth,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Utils.columnSpacer(height: screenHeight * 0.01),
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
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: width,
              child: Row(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        fontSize: fontSize,
                        color: AppColors.greyTextColor.withOpacity(0.5),
                        fontWeight: fontWeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget detailsText1({
    required String title,
    required String value,
    required FontWeight fontWeight,
    required double fontSize,
    required dynamic width,
  }) {
    return SizedBox(
      width: width,
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                fontSize: 12,
                color: AppColors.greyTextColor.withOpacity(0.5),
                fontWeight: FontWeight.w400,
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
    );
  }
}
