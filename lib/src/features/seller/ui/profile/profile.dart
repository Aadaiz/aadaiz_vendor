import 'dart:io';

import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/controller/home_controller.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/repository/home_repository.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/controller/profile_controller.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/widgets/address_screen.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/widgets/payment_history_screen.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/widgets/seller_support_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../res/colors/app_colors.dart';
import '../../../auth/ui/login/login.dart';
import '../../../designer/controller/designer_controller.dart';
import '../../../tailor/ui/kyc/category_screen.dart';
import 'edit_bank_details.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, this.isTailor = false});
  final bool? isTailor;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  bool isEditName =false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.013),
          child: InkWell(
            onTap: () {
              HomeController.to.setTab(0);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: AppColors.blackColor,
            ),
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        actions: [
          GestureDetector(
            onTap: () {
              _focusNode.unfocus();


              ProfileController.to.UpdateProfile();

              setState(() {
                isEditName=false;
              });
            },
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.all(16),
                child: ProfileController.to.isLoadingupdate.value
                    ? SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primaryColor,
                        ),
                      )
                    :  (ProfileController.to.tempImage.value != null || isEditName==true)? Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                        size: 30,
                      ):SizedBox.shrink(),
              ),
            ),
          ),
        ],
        title: Text(
          'Profile',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: Obx(
        () => ProfileController.to.isLoading.value
            ? Utils.carshimmer(lenght: 5)
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.withAlpha(20),
                          child: ClipOval(
                            child: Obx(() {
                              final controller = ProfileController.to;

                              String imageUrl = controller.profiledetail.isNotEmpty
                                  ? (controller.profiledetail.first.shopPhoto ?? '')
                                  : '';

                              String name = controller.profiledetail.isNotEmpty
                                  ? (controller.profiledetail.first.shopName ?? '')
                                  : '';

                              String initials = name.isNotEmpty
                                  ? name.trim().split(' ').map((e) => e[0]).take(2).join().toUpperCase()
                                  : '';


                              if (controller.tempImage.value != null) {
                                return Image.file(
                                  controller.tempImage.value!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                );
                              }


                              if (imageUrl.isNotEmpty) {
                                return CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Center(
                                    child: Text(
                                      initials,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }


                              return Center(
                                child: Text(
                                  initials,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 12,
                            child: InkWell(
                              onTap: () async {
                                final pickedFile =
                                await ImagePicker().pickImage(source: ImageSource.gallery);

                                if (pickedFile != null) {
                                  ProfileController.to.tempImage.value = File(pickedFile.path);
                                  HomeController.to.selectedImages.add(pickedFile);
                                }
                              },
                              child: Image.asset('assets/images/eid.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      ProfileController.to.profiledetail.isNotEmpty
                          ? ProfileController.to.profiledetail.first.shopName ??
                                'No Shop Name'
                          : 'No Shop Name',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    widget.isTailor == true
                        ? Column(
                            children: [
                              const SizedBox(height: 16.0),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const CategoryScreen());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: AppColors.greyTextColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Select Category',
                                          style: GoogleFonts.dmSans(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          size: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: TextField(
                        onChanged: (value){
                          setState(() {
                            isEditName=true;
                          });
                        },
                         focusNode: _focusNode,
                        cursorColor: AppColors.greyTextColor.withAlpha(50),
                        readOnly: ProfileController.to.enable == true
                            ? false
                            : true,
                        controller: ProfileController.to.shopname
                          ..text = ProfileController.to.shopname.text.isEmpty
                              ? (ProfileController.to.profiledetail.isNotEmpty
                                    ? ProfileController
                                              .to
                                              .profiledetail
                                              .first
                                              .shopName ??
                                          ''
                                    : '')
                              : ProfileController.to.shopname.text,

                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                ProfileController.to.enable = true;
                              });

                              Future.delayed(const Duration(milliseconds: 100), () {
                                _focusNode.requestFocus();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/eid.png',
                                width: Get.width * 0.01,
                              ),
                            ),
                          ),

                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.greyTextColor.withAlpha(50),
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const AddressScreen(type: 'seller'));
                      },
                      child: textWidget(
                        isAddress: true,
                        image: 'assets/images/ad.png',
                        trailing: Icons.arrow_forward_ios,
                        title: 'Your Address',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const PaymentHistoryScreen());
                      },
                      child: textWidget(
                        leading: Icons.history,
                        trailing: Icons.arrow_forward_ios,
                        title: 'Payment History',
                      ),
                    ), InkWell(
                      onTap: () {
                        Get.to(() =>  BankEdit(data:ProfileController.to.profiledetail.first));
                      },
                      child: textWidget(
                        leading: Icons.comment_bank,
                        trailing: Icons.arrow_forward_ios,
                        title: 'Bank Details',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const AddressScreen(type: 'seller'));
                      },
                      child: textWidget(
                        isAddress: true,
                        image: 'assets/images/lock.png',
                        trailing: Icons.arrow_forward_ios,
                        title: 'Privacy Policy',
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: AppColors.primaryColor,
                      ),
                      title: Text(
                        'Delete Account',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const SellerSupportScreen());
                      },
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/help.png',
                          height: 20,
                        ),
                        title: Text(
                          'Help Centre',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        AuthController.to.showLogOut(context);
                      },
                      child: ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: Text(
                          'Log Out',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            color: AppColors.starColor,
                            fontSize: 15,
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

  Widget textWidget({
    IconData? leading,
    required IconData trailing,
    required String title,
    bool? isAddress = false,
    String? image,
  }) {
    return ListTile(
      leading: isAddress == true
          ? Image.asset('$image', color: AppColors.primaryColor, height: 20)
          : Icon(leading, color: AppColors.primaryColor),
      title: Text(
        title,
        style: GoogleFonts.dmSans(
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor,
          fontSize: 15,
        ),
      ),
      trailing: Icon(trailing, color: AppColors.primaryColor),
    );
  }
}
