import 'dart:io';
import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/controller/home_controller.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/res/components/common_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../res/components/common_toast.dart';
import '../home/model/home_model.dart';

import 'package:cached_network_image/cached_network_image.dart';




class AddCatalogue extends StatefulWidget {
  final Product? product; // Add product parameter for editing
  const AddCatalogue({super.key, this.product});

  @override
  State<AddCatalogue> createState() => _AddCatalogueState();
}

class _AddCatalogueState extends State<AddCatalogue> {
  HomeController controller = Get.find<HomeController>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _selectedQuantity = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _coupon = TextEditingController();
  final TextEditingController _hsnCode = TextEditingController();
  final TextEditingController _selectedCategory = TextEditingController();
  final TextEditingController _selectedSubCategory = TextEditingController();
  final TextEditingController _couponTitleController = TextEditingController();
  final TextEditingController _couponDescriptionController = TextEditingController();
  final TextEditingController _couponDiscountController = TextEditingController();
  final TextEditingController _couponValidFromController = TextEditingController();
  final TextEditingController _couponValidToController = TextEditingController();

  String? _selectedColor;
  String? _selectedCouponType;
  bool _showCouponFields = false;

  List<String> _existingImageUrls = [];

  @override
  void initState() {
    super.initState();
    AuthController.to.getCategory();
    HomeController.to.selectedImages.clear();
    if (widget.product != null) {
      _priceController.text = widget.product!.price;
      _descriptionController.text = widget.product!.description ?? '';
      _selectedCategory.text = widget.product!.category;
      _selectedColor = widget.product!.color;
      _selectedQuantity.text = widget.product!.meter;
      _existingImageUrls = widget.product!.image
          .split(',')
          .map((url) => url.trim())
          .where((url) => url.isNotEmpty)
          .take(3)
          .toList();
      if (widget.product!.coupon != null) {
        _coupon.text = widget.product!.coupon!.couponCode ?? '';
        _selectedCouponType = widget.product!.coupon!.couponType;
        _couponTitleController.text = widget.product!.coupon!.title ?? '';

        _couponDescriptionController.text = widget.product!.coupon!.description ?? '';
        _couponDiscountController.text = widget.product!.coupon!.discount ?? '';
        _couponValidFromController.text = widget.product!.coupon!.validFrom ?? '';
        _couponValidToController.text = widget.product!.coupon!.validTo ?? '';
      }
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _descriptionController.dispose();
    _coupon.dispose();
    _couponTitleController.dispose();
    _couponDescriptionController.dispose();
    _couponDiscountController.dispose();
    _couponValidFromController.dispose();
    _couponValidToController.dispose();
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
                Container(
                  color: AppColors.whiteColor,
                  child: TextFormField(
                    controller: _selectedCategory,
                    decoration: InputDecoration(
                      hintText: 'Category',
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
                  ),
                ),
                const SizedBox(height: 8),  Container(
                  color: AppColors.whiteColor,
                  child: TextFormField(
                    controller: _selectedSubCategory,
                    decoration: InputDecoration(
                      hintText: 'Sub Category',
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
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  color: AppColors.whiteColor,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Pick a color'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: _selectedColor != null
                                    ? _parseColor(_selectedColor!)
                                    : Colors.red,
                                onColorChanged: (Color color) {
                                  setState(() {
                                    _selectedColor = colorToHex(color);
                                  });
                                },
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedColor != null ? 'Color Selected' : 'Color',
                            style: GoogleFonts.dmSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (_selectedColor != null)
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: _parseColor(_selectedColor!),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.grey),
                              ),
                            ),
                        ],
                      ),
                    ),
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
                                TextFormField(
                                  controller: _selectedQuantity,
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
                                  ),
                                  keyboardType: TextInputType.number,
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
                Row(
                  children: <Widget>[
                    Text(
                      'Add Coupon',
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
                    controller: _coupon,
                    maxLines: 1,
                    onChanged: (value) {
                      setState(() {
                        _showCouponFields = value.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Coupon Code',
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
                if (_showCouponFields||_coupon.text.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    color: AppColors.whiteColor,
                    child: DropdownButtonFormField<String>(
                      value: _selectedCouponType,
                      hint: Text('Select Coupon Type'),
                      items: ['percentage', 'flat'].map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCouponType = value;
                        });
                      },
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    color: AppColors.whiteColor,
                    child: TextFormField(
                      controller: _couponTitleController,
                      decoration: InputDecoration(
                        hintText: 'Coupon Title',
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
                  Container(
                    color: AppColors.whiteColor,
                    child: TextFormField(
                      controller: _couponDescriptionController,
                      decoration: InputDecoration(
                        hintText: 'Coupon Description',
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
                  Container(
                    color: AppColors.whiteColor,
                    child: TextFormField(
                      controller: _couponDiscountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Discount Value',
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: AppColors.whiteColor,
                          child: TextFormField(
                            controller: _couponValidFromController,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _couponValidFromController.text =
                                      pickedDate.toIso8601String().split('T').first;
                                  if (_couponValidToController.text.isNotEmpty) {
                                    DateTime validToDate = DateTime.parse(_couponValidToController.text);
                                    if (validToDate.isBefore(pickedDate)) {
                                      _couponValidToController.clear();
                                    }
                                  }
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Valid From',
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
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          color: AppColors.whiteColor,
                          child: TextFormField(
                            controller: _couponValidToController,
                            readOnly: true,
                            onTap: () async {
                              if (_couponValidFromController.text.isEmpty) {
                                CommonToast.show(msg: "Please select Valid From date first");
                                return;
                              }

                              DateTime fromDate = DateTime.parse(_couponValidFromController.text);
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: fromDate.isAfter(DateTime.now()) ? fromDate : DateTime.now(),
                                firstDate: fromDate,
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _couponValidToController.text =
                                      pickedDate.toIso8601String().split('T').first;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Valid To',
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
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 16),
                Text(
                  'Hsn Code',
                  style: GoogleFonts.dmSans(fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10,),
                Container(
                  color: AppColors.whiteColor,
                  child: TextFormField(
                    controller: _hsnCode,
                    maxLines: 1,

                    decoration: InputDecoration(
                      hintText: 'Hsn Code',
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
                  isLoading: widget.product != null ? HomeController.to.isProductEditLoading.value : HomeController.to.isProductAddLoading.value,
                  ontap: () {
                    if (!_validateFields()) {
                      return;
                    }

                    Map<String, dynamic>? couponData;
                    if (_coupon.text.isNotEmpty) {
                      couponData = {
                        'title': _couponTitleController.text,
                        'description': _couponDescriptionController.text,
                        'coupon_code': _coupon.text,
                        'coupon_type': _selectedCouponType,
                        'discount': _couponDiscountController.text,
                        'valid_from': _couponValidFromController.text,
                        'valid_to': _couponValidToController.text,
                      };
                    }

                    if (widget.product != null) {
                      HomeController.to.editProduct(
                        id: widget.product!.id.toString(),
                        category: _selectedCategory.text,
                        subCategory: _selectedSubCategory.text,
                        color: _selectedColor ?? '',
                        price: _priceController.text,
                        quantity: _selectedQuantity.text,
                        description: _descriptionController.text,
                        existingImageUrls: _existingImageUrls,
                        coupon: couponData ?? {},
                        hsnCode: _hsnCode.text,
                      );
                    } else {
                      HomeController.to.product(
                        category: _selectedCategory.text,
                        subCategory: _selectedSubCategory.text,
                        color: _selectedColor ?? '',
                        price: _priceController.text,
                        quantity: _selectedQuantity.text,
                        description: _descriptionController.text,
                        coupon: couponData ?? {},
                        hsnCode: _hsnCode.text,
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

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  Color _parseColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
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

  bool _validateFields() {
    if (_selectedCategory.text.isEmpty) {
      CommonToast.show(msg: "Please enter Category name");
      return false;
    }
    if (_selectedSubCategory.text.isEmpty) {
      CommonToast.show(msg: "Please enter Sub Category name");}

    if (_selectedColor == null || _selectedColor!.isEmpty) {
      CommonToast.show(msg: "Please select a Color");
      return false;
    }

    if (_priceController.text.isEmpty) {
      CommonToast.show(msg: "Please enter Price Per Meter");
      return false;
    }

    final priceValue = double.tryParse(_priceController.text);
    if (priceValue == null || priceValue <= 0) {
      CommonToast.show(msg: "Please enter a valid Price");
      return false;
    }

    if (_selectedQuantity.text.isEmpty) {
      CommonToast.show(msg: "Please select Quantity");
      return false;
    }

    if (widget.product == null) {
      if (HomeController.to.selectedImages.isEmpty) {
        CommonToast.show(msg: "Please upload at least one product image");
        return false;
      }
    } else {
      final hasExistingImages = _existingImageUrls.isNotEmpty;
      final hasNewImages = HomeController.to.selectedImages.isNotEmpty;
      if (!hasExistingImages && !hasNewImages) {
        CommonToast.show(msg: "Please upload at least one product image");
        return false;
      }
    }

    if (_coupon.text.isNotEmpty) {
      if (_selectedCouponType == null) {
        CommonToast.show(msg: "Please select coupon type");
        return false;
      }
      if (_couponTitleController.text.isEmpty) {
        CommonToast.show(msg: "Please enter coupon title");
        return false;
      }
      if (_couponDescriptionController.text.isEmpty) {
        CommonToast.show(msg: "Please enter coupon description");
        return false;
      }
      if (_couponDiscountController.text.isEmpty) {
        CommonToast.show(msg: "Please enter discount value");
        return false;
      }
      if (_couponValidFromController.text.isEmpty) {
        CommonToast.show(msg: "Please select valid from date");
        return false;
      }
      if (_couponValidToController.text.isEmpty) {
        CommonToast.show(msg: "Please select valid to date");
        return false;
      }
    }
    if(_hsnCode.text.isEmpty) {
      CommonToast.show(msg: "Please enter Hsn Code");
      return false;
    }

    return true;
  }
}