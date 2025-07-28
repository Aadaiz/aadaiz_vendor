import 'dart:io';

import 'package:aadaiz_seller/src/features/tailor/controller/tailor_controller.dart';
import 'package:aadaiz_seller/src/features/tailor/model/category_list_model.dart';
import 'package:aadaiz_seller/src/res/components/common_toast.dart';
import 'package:aadaiz_seller/src/utils/responsive.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../res/components/common_button.dart';
import '../../../auth/controller/auth_controller.dart';
import 'add_location.dart';
import 'bank_details.dart';
import 'category_screen.dart';

class TailorKycScreen extends StatefulWidget {
  const TailorKycScreen({super.key, this.mob});
  final dynamic mob;
  @override
  State<TailorKycScreen> createState() => _TailorKycScreenState();
}
class _TailorKycScreenState extends State<TailorKycScreen> {
  String? selectedExpertIn;
  bool _validateFields() {
    if (TailorController.to.selectedCategory.isEmpty) {
      CommonToast.show(msg: "Please select at least one category");
      return false;

    }
    if (TailorController.to.selectedCategoriesWithPrice.isEmpty) {
      CommonToast.show(msg: "Please choose price");
      return false;
    }
    if (selectedExpertIn == null) {
      CommonToast.show(msg: "Please select Expert In option");
      return false;
    }
    if (TailorController.to.image1.value.path.isEmpty) {
      CommonToast.show(msg: "Please upload Picture of Product");
      return false;
    }
    if (TailorController.to.image2.value.path.isEmpty) {
      CommonToast.show(msg: "Please upload Front View image");
      return false;
    }
    if (TailorController.to.image3.value.path.isEmpty) {
      CommonToast.show(msg: "Please upload Back View image");
      return false;
    }
    if (TailorController.to.adhar.value.path.isEmpty) {
      CommonToast.show(msg: "Please upload Aadhaar or Pan Card ");
      return false;

    }
    if (TailorController.to.no.text.isEmpty) {
      CommonToast.show(msg: "Please enter House number");
      return false;
    }
    if (TailorController.to.st.text.isEmpty) {
      CommonToast.show(msg: "Please enter street");
      return false;
    }
    if (TailorController.to.pin.text.isEmpty) {
      CommonToast.show(msg: "Please enter pincode");
      return false;
    }
    if (TailorController.to.city.text.isEmpty) {
      CommonToast.show(msg: "Please enter city");
      return false;
    }
    if (TailorController.to.land.text.isEmpty) {
      CommonToast.show(msg: "Please enter landmark");
      return false;
    }
    // Assuming location is required - check if location is added
    // Note: Location validation might need adjustment based on how location is stored

    return true;
  }

  File image = File('');
  File image1 = File('');
  File image2 = File('');
  void _addCategory(PatternFiltercategory category, index) {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: Text("Enter price for ${category.name}"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(hintText: "Enter price"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final price = controller.text;
                if (price != '') {
                  setState(() {
                    TailorController.to.selectedCategory[index].price = price;
                    TailorController.to.selectedCategoriesWithPrice[category
                            .id!] =
                        price;
                  });
                  print(
                    'dsafdasf ${TailorController.to.selectedCategoriesWithPrice}',
                  );
                }
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
  TextEditingController mobile = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobile.text = widget.mob??"";
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Obx(
              () => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Join With Aadaiz\n',
                              style: GoogleFonts.dmSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'start Your ',
                              style: GoogleFonts.dmSans(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'Journey!',
                              style: GoogleFonts.dmSans(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/tm.png',
                        height: 75,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),

                  InkWell(
                    onTap: () {
                      Get.to(() => const CategoryScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.greyTextColor.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const SizedBox(height: 16.0),
                  if(TailorController.to.selectedCategory.isNotEmpty)
                  SizedBox(
                    height: Get.height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: TailorController.to.selectedCategory.length,
                      itemBuilder: (context, index) {
                        final PatternFiltercategory data = TailorController.to.selectedCategory[index];
                        return _buildCard(data, index);
                      },
                    ),
                  ),
                  SizedBox(height: 15,),

                  Row(
                    children: [
                      Text(
                        'Expert In',
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyTextColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 50,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        labelText: 'Expert in',
                        labelStyle: GoogleFonts.dmSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        suffixIcon: const Icon(Icons.arrow_forward_ios),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                        DropdownMenuItem(
                          value: 'Female ',
                          child: Text('Female'),
                        ),
                      ],
                      onChanged: (value) { setState(() {
                        selectedExpertIn = value as String?;
                      });},
                      icon: const Icon(
                        Icons.arrow_downward,
                        size: 0,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'What You Done For !',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.blackColor.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            AuthController.to.showdialog(context, picture: 3);
                          },
                          child: TailorController.to.image1.value.path != ''
                              ? Container(
                                  width: screenWidth * 0.25,
                                  height: screenWidth * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(
                                          TailorController.to.image1.value.path,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : uploadPictureWidget(
                                  'Picture Of Product',
                                  screenWidth,
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            AuthController.to.showdialog(context, picture: 4);
                          },
                          child: TailorController.to.image2.value.path != ''
                              ? Container(
                                  width: screenWidth * 0.25,
                                  height: screenWidth * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(
                                          TailorController.to.image2.value.path,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : uploadPictureWidget('Front View', screenWidth),
                        ),
                        GestureDetector(
                          onTap: () {
                            AuthController.to.showdialog(context, picture: 5);
                          },
                          child: TailorController.to.image3.value.path != ''
                              ? Container(
                                  width: screenWidth * 0.25,
                                  height: screenWidth * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(
                                          TailorController.to.image3.value.path,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : uploadPictureWidget('Back View', screenWidth),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    height: 50,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        labelText: 'Aadhaar Card',
                        labelStyle: GoogleFonts.dmSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        suffixIcon: const Icon(Icons.arrow_forward_ios),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryColor.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      items: const <DropdownMenuItem<String>>[
                        DropdownMenuItem(
                          value: 'Option 1',
                          child: Text('Aadhaar Card'),
                        ),
                        DropdownMenuItem(
                          value: 'Option 2',
                          child: Text('Pan Card'),
                        ),
                      ],
                      onChanged: (value) {},
                      icon: const Icon(
                        Icons.arrow_downward,
                        size: 0,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  DottedBorder(
                    color: AppColors.greyTextColor.withOpacity(0.5),
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    strokeWidth: 1,
                    dashPattern: const [5, 3],
                    child: SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: GestureDetector(
                        onTap: () {
                          AuthController.to.showdialog(context, picture: 6);
                        },
                        child: Center(
                          child: TailorController.to.adhar.value.path != ''
                              ? Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(
                                          TailorController.to.adhar.value.path,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Upload aadhaar card front photo',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      child: Text(
                                        'Upload +',
                                        style: GoogleFonts.dmSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24.0),
                  InkWell(
                    onTap: () {
                      Get.to(() => const AddLocation());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.greyTextColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add Location',
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
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'Phone Number',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: AuthController.to.mobile,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor.withOpacity(0.5),
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      prefixText: '+91  ',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16.0),
                  InkWell(
                    onTap: () {
                      if (_validateFields()) {
                        Get.to(() => BankDetails(mob: AuthController.to.mobile.text));
                      }
                    },
                    child: CommonButton(
                      text: 'Continue',
                      borderRadius: 8.0,
                      width: screenWidth * 0.9,
                      height: 50.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadPictureWidget(String text, width) {
    final double screenWidth = width;
    return SizedBox(
      width: screenWidth * 0.25,
      height: screenWidth * 0.25,
      child: DottedBorder(
        color: Colors.brown,
        strokeWidth: 1.5,
        dashPattern: const [8, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud_upload,
                size: 30,
                color: AppColors.primaryColor,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.greyTextColor.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(PatternFiltercategory data, index) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Column(
        children: [
          Container(
            width: Get.width * 0.25,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(2, 2),
                  blurRadius: 20,
                  color: AppColors.greyTextColor.withOpacity(0.1),
                ),
              ],
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: Get.width * 0.25,
                        height: Get.width * 0.25,
                        child: Image.network(
                          "${data.image}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "${data.name}",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                          fontSize: 7.00.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          ),
          Gap(8),
          GestureDetector(
            onTap: () {
              _addCategory(data, index);
            },
            child: Container(
              width: Get.width * 0.25,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.greyTextColor.withOpacity(0.5),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( data.price!=null? '${data.price}':
                    'Update Price',
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                    ),
                  ),

                  const Icon(Icons.keyboard_arrow_right_rounded, size: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
