import 'dart:io';
import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/controller/home_controller.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/res/components/common_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../home/model/home_model.dart';

import 'package:cached_network_image/cached_network_image.dart';




class AddCatalogue extends StatefulWidget {
  final Product? product; // Add product parameter for editing
  const AddCatalogue({super.key, this.product});

  @override
  State<AddCatalogue> createState() => _AddCatalogueState();
}

class _AddCatalogueState extends State<AddCatalogue> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  String? _selectedColor;
  String? _selectedQuantity;
  List<String> _existingImageUrls = []; // Track existing image URLs for editing

  @override
  void initState() {
    super.initState();
    AuthController.to.getCategory();
    HomeController.to.selectedImages.clear(); // Clear previous images
    // Pre-fill fields if editing
    if (widget.product != null) {
      _priceController.text = widget.product!.price;
      _descriptionController.text = widget.product!.description ?? '';
      _selectedCategory = widget.product!.category;
      // Normalize color to match dropdown values (e.g., 'red' -> 'Red')
      final List<dynamic> colorList = ['Red', 'Blue', 'Green', 'Yellow', 'Orange', 'Purple', 'Pink', 'Brown', 'Black', 'White'];
      _selectedColor = colorList.firstWhere(
            (color) => color.toLowerCase() == widget.product!.color.toLowerCase(),
        orElse: () => null,
      );
      _selectedQuantity = widget.product!.meter;
      // Load existing image URLs
      _existingImageUrls = widget.product!.image
          .split(',')
          .map((url) => url.trim())
          .where((url) => url.isNotEmpty)
          .take(3)
          .toList();
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: screenHeight * 0.7,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product != null ? 'Edit Product' : 'Products You willing To Sell *',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => Container(
                  color: AppColors.whiteColor,
                  child: DropdownButtonFormField<String>(
                    dropdownColor: AppColors.whiteColor,
                    value: _selectedCategory,
                    hint: Text('Category'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    items: AuthController.to.categoryList.map<DropdownMenuItem<String>>((category) {
                      return DropdownMenuItem<String>(
                        value: category.catName,
                        child: Text(category.catName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _selectedCategory = value;
                    },
                  ),
                )),
                const SizedBox(height: 8),
                Container(
                  color: AppColors.whiteColor,
                  child: DropdownButtonFormField<String>(
                    dropdownColor: AppColors.whiteColor,
                    value: _selectedColor,
                    hint: Text('Color'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    items: ['Red', 'Blue', 'Green', 'Yellow', 'Orange', 'Purple', 'Pink', 'Brown', 'Black', 'White']
                        .map((String color) {
                      return DropdownMenuItem<String>(
                        value: color,
                        child: Text(color),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _selectedColor = value;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  color: AppColors.whiteColor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          3,
                              (index) => _buildImageUploadButton(context, index),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Price Per Meter",
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.greyTextColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: _priceController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1.0,
                                      ),
                                    ),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        '₹',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Enter Quantity",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.greyTextColor,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE8E5E5),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Text(" Mtr "),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                DropdownButtonFormField<String>(
                                  dropdownColor: AppColors.whiteColor,
                                  value: _selectedQuantity,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1.0,
                                      ),
                                    ),
                                    labelStyle: TextStyle(color: AppColors.greyTextColor),
                                    labelText: 'Enter Quantity',
                                  ),
                                  items: ['5', '10', '15', '20'].map((String quantity) {
                                    return DropdownMenuItem<String>(

                                      value: quantity,
                                      child: Text(quantity),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    _selectedQuantity = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Text(
                      'Product Description',
                      style: GoogleFonts.dmSans(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      ' (Optional)',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyTextColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  color: AppColors.whiteColor,
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(() => CommonButton(
                  width: double.infinity,
                  height: Get.height * 0.045,
                  text: widget.product != null ? "Update" : "Post",
                  isLoading: HomeController.to.isLoading.value,
                  ontap: () {
                    if (widget.product != null) {
                      // Edit product
                      HomeController.to.editProduct(
                        id: widget.product!.id.toString(),
                        category: _selectedCategory ?? '',
                        color: _selectedColor ?? '',
                        price: _priceController.text,
                        quantity: _selectedQuantity ?? '',
                        description: _descriptionController.text,
                        existingImageUrls: _existingImageUrls, // Pass existing URLs
                      );
                    } else {
                      // Add product
                      HomeController.to.product(
                        category: _selectedCategory ?? '',
                        color: _selectedColor ?? '',
                        price: _priceController.text,
                        quantity: _selectedQuantity ?? '',
                        description: _descriptionController.text,
                      );
                    }
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadButton(BuildContext context, int index) {
    return Expanded(
      child: GestureDetector(

        onTap: () async {
          final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            if (HomeController.to.selectedImages.length > index) {
              HomeController.to.selectedImages[index] = pickedFile;
            } else {
              HomeController.to.selectedImages.add(pickedFile);
            }
            setState(() {});
          }
        },
        child: Container(
          height: 115,
          padding: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 5,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Obx(() => DottedBorder(
            color: AppColors.brown,
            strokeWidth: 1.6,
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            dashPattern: const [4, 2],
            child: Center(
              child: HomeController.to.selectedImages.length > index
                  ? Image.file(
                File(HomeController.to.selectedImages[index].path),
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              )
                  : _existingImageUrls.length > index && widget.product != null
                  ? CachedNetworkImage(
                imageUrl: _existingImageUrls[index],
                fit: BoxFit.cover,
                height: 100,
                width: 100,
                errorWidget: (context, url, error) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      size: 30,
                      color: AppColors.greyTextColor,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Image Load Error',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: AppColors.greyTextColor.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                placeholder: (context, url) => Center(
                  child: Transform.scale(
                    scale: 0.5,
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud_upload,
                    size: 30,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Picture Of Product',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: AppColors.greyTextColor.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

}