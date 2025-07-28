import 'dart:io';

import 'package:aadaiz_seller/src/features/seller/ui/profile/controller/profile_controller.dart';
import 'package:aadaiz_seller/src/res/components/common_toast.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../res/colors/app_colors.dart';
import '../../../../../res/components/common_button.dart';
import '../../../../auth/controller/auth_controller.dart';

class CreateSupport extends StatefulWidget {
  const CreateSupport({super.key});

  @override
  State<CreateSupport> createState() => _CreateSupportState();
}

class _CreateSupportState extends State<CreateSupport> {
  final AuthController _authController = Get.find<AuthController>();
  final ImagePicker _picker = ImagePicker();
  Future _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _authController.image.value = File(image.path);
        _authController.selectedImages.clear();
        _authController.selectedImages.add(File(image.path));

      });

    }
  }

  void _removeImage() {
    setState(() {
      _authController.image.value = File('');
      _authController.selectedImages.clear();

    });

  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Your Problem',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: ProfileController.to.problem,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.0),
                ),
              ),
              style: GoogleFonts.dmSans(),
            ),
            const SizedBox(height: 16),
            Text(
              'Description',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: ProfileController.to.descriptionsupport,
              maxLines: 4,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.0),
                ),
              ),
              style: GoogleFonts.dmSans(),
            ),
            const SizedBox(height: 16),
            Text(
              'Attachment',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _authController.image.value.path.isEmpty
                ? GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Add your photos',
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.file(
                    _authController.image.value,
                    fit: BoxFit.contain,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: _removeImage,
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.blackColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CommonButton(
              ontap: (){Get.back();},
              text: 'Cancel',
              isBorder: true,
              height: Get.height * 0.05,
            ),
            Obx(()=>
             CommonButton(
                isLoading: AuthController.to.kycLoading.value,
                ontap: () {
                  if (ProfileController.to.problem.text.isEmpty &&
                      ProfileController.to.descriptionsupport.text.isEmpty) {
                    CommonToast.show(msg: "Please Enter all fields");
                  } else if (_authController.image.value.path.isEmpty) {
                    CommonToast.show(msg: "Please Add image");
                  } else {
                    ProfileController.to.createsupport();
                  }
                },

                text: 'Create Ticket',
                height: Get.height * 0.05,
              ),
            ),
          ],
        ),
      ),
    );
  }
}