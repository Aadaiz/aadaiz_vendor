import 'package:aadaiz_seller/src/res/components/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../res/colors/app_colors.dart';
import '../../../../../res/components/common_textfiled.dart';
import '../controller/profile_controller.dart';
import '../model/profile_model.dart';

class EditAddress extends StatefulWidget {
  final Datum   data;
  const EditAddress({super.key, required this.data});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final ProfileController controller = Get.find<ProfileController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fullNameController.text=widget.data.name!;
     controller.mobileNumberController.text=widget.data.mobile!;
    controller.addressController.text= widget.data.address!;
     controller.cityController.text=widget.data.city!;
     controller.landmarkController.text=widget.data.landmark!;
     controller.stateController.text=widget.data.state!;
    controller.zipCodeController.text= widget.data.pincode.toString();
    controller.countryController.text= widget.data.country!;
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
          'Adding Shipping Address',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            CustomTextField(
              hintText: "Full name",
              controller: controller.fullNameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: "Mobile Number",
              controller: controller.mobileNumberController,

            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: "Address",
              controller: controller.addressController,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: "City",
                    controller: controller.cityController,
                  ),
                ),

                Expanded(
                  child: CustomTextField(
                    hintText: "Landmark",
                    controller: controller.landmarkController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: "State/Province/Region",
              controller: controller.stateController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: "Zip Code (Postal Code)",
              controller: controller.zipCodeController,

            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: "Country",
              controller: controller.countryController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Obx(()=>
          CommonButton(
            isLoading: controller.isLoading.value,
            ontap: (){
              controller.saveAddress(widget.data.id,'seller');

            },

            text: "SAVE ADDRESS",
            height: Get.height * 0.05,

          ),
        ),
      ),
    );
  }
}