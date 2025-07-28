import 'dart:io';

import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/res/components/loading_button.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/home/model/home_order_model.dart'
    show Datum;
import 'package:image_picker/image_picker.dart';

import '../../../../../res/components/common_toast.dart';
import '../controller/home_order_controller.dart';

class OrderStatusScreen extends StatefulWidget {
  final Datum order;
  const OrderStatusScreen({super.key, required this.order});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    final TextStyle labelStyle = GoogleFonts.dmSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );

    final TextStyle chipTextStyle = GoogleFonts.dmSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    );

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text('Pickup', style: GoogleFonts.dmSans()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order ID : ${widget.order.orderId}",
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyTextColor,
                ),
              ),
              const SizedBox(height: 24),

              // Material Received
              _buildStatusRow(
                material_status: widget.order.materialStatus,
                id: widget.order.id,
                icon: 'assets/images/track1.jpeg',
                label: "Material Received",
                chipText: "Received",
                isDone:
                    (widget.order.materialStatus == 'received' ||
                        widget.order.materialStatus == 'stitching' ||
                        widget.order.materialStatus == 'completed')
                    ? true
                    : false,
              ),
              const SizedBox(height: 40),

              // In Progress
              _buildStatusRow(
                material_status: widget.order.materialStatus,
                id: widget.order.id,
                icon: 'assets/images/track2.jpeg',
                label: "In Progress",
                chipText: "Stitching",
                isDone:
                    (widget.order.materialStatus == 'stitching' ||
                        widget.order.materialStatus == 'completed')
                    ? true
                    : false,
              ),
              const SizedBox(height: 40),

              // Completed
              _buildStatusRow(
                material_status: widget.order.materialStatus,
                id: widget.order.id,
                icon: 'assets/images/track3.jpeg',
                label: "Completed",
                chipText: "Completed",
                isDone: widget.order.materialStatus == 'completed'
                    ? true
                    : false,
                isCompleted: true,
              ),
              const SizedBox(height: 42),

              // Disabled Button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.order.materialStatus == 'completed'
                      ? AppColors.starColor
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Center(
                  child: Text(
                    "Ready To Dispatch",
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusRow({
    required dynamic material_status,
    required dynamic id,
    required String icon,
    required String label,
    required String chipText,
    required bool isDone,
    bool? isCompleted,
  }) {
    return Builder(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(icon, height: 25, width: 25),
                const SizedBox(width: 13),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '03 Mar 2024, 04:25 PM',
                      style: GoogleFonts.dmSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            isCompleted == true
                ? GestureDetector(
                    onTap: () {
                      if (!isDone) {
                        if ((material_status != '' ||
                                material_status != null) &&
                            (material_status == 'stitching')) {
                          showDialog(
                            context: context,
                            builder: (_) => UploadDialog(id: id),
                          );
                        } else {
                          CommonToast.show(
                            msg: "Update Stitching Status First",
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDone
                            ? AppColors.primaryColor.withAlpha(75)
                            : AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        spacing: 4,
                        children: [
                          Text(
                            chipText,
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      if (label == "Material Received" && !isDone) {
                        TailorOrderController.to.updatedOrderstatus(
                          id: id,
                          status: "pickup",
                          type: 3,
                          material_status: 'received',
                        );
                        Get.back();
                      } else if (label == "In Progress" && !isDone) {
                        if (material_status != '' || material_status != null) {
                          TailorOrderController.to.updatedOrderstatus(
                            id: id,
                            status: "pickup",
                            type: 3,
                            material_status: 'stitching',
                          );
                          Get.back();
                        } else {
                          CommonToast.show(msg: "Update Received Status First");
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDone
                              ? AppColors.primaryColor.withOpacity(0.3)
                              : AppColors.primaryColor,
                        ),
                      ),
                      child: Text(
                        chipText,
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: isDone
                              ? AppColors.primaryColor.withOpacity(0.3)
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}

class UploadDialog extends StatefulWidget {
  final dynamic id;
  const UploadDialog({super.key, required this.id});
  @override
  State<UploadDialog> createState() => _UploadDialogState();
}

class _UploadDialogState extends State<UploadDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(14),
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        margin: EdgeInsets.all(0),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 13),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              dashPattern: [6, 3],
              color: Colors.grey.withAlpha(95),
              child: Obx(
                () => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: TailorOrderController.to.selectedImages.isNotEmpty
                      ? Image.file(
                          File(
                            TailorOrderController.to.selectedImages.first.path,
                          ),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                final pickedFile = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  TailorOrderController.to.selectedImages.add(
                                    pickedFile,
                                  );

                                  setState(
                                    () {},
                                  ); // Refresh UI to show new image
                                }
                              },
                              child: Image.asset(
                                "assets/images/upload.png",
                                width: 43,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Click to Upload",
                              style: GoogleFonts.dmSans(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "(Max. File size: 1 MB)",
                              style: GoogleFonts.dmSans(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => LoadingButton(
                loading:
                    TailorOrderController.to.isLoadingStatusById[widget.id],
                title: 'Upload Image',
                onPressed: () {
                  TailorOrderController.to.updatedOrderstatus(
                    id: widget.id,
                    status: "pickup",
                    type: 3,
                    material_status: 'completed',
                  );
                },
                btnWidth: double.infinity,
                btnHeight: 40,
                fontweight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
