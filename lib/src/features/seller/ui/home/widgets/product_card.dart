import 'dart:developer';

import 'package:aadaiz_seller/src/features/seller/ui/home/model/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart'
as cs; // Alias for carousel_slider
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../res/colors/app_colors.dart';
import '../../../../../res/components/common_button.dart';
import '../../../../../utils/utils.dart';
import '../../sell/add_catalogue.dart';
import '../controller/home_controller.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    // Split comma-separated image URLs into a list
    final List<dynamic> imageUrls = data.image
        .split(',')
        .map((url) => url.trim())
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(4),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: SizedBox(
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.2,
                          child: cs.CarouselSlider(
                            options: cs.CarouselOptions(
                              height: screenWidth * 0.2,
                              viewportFraction: 1.0,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              enlargeCenterPage: false,
                            ),
                            items: imageUrls.map((imageUrl) {
                              return CachedNetworkImage(
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2,
                                fit: BoxFit.cover,
                                imageUrl: imageUrl,
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                      'assets/images/mat.png',
                                      width: screenWidth * 0.2,
                                      height: screenWidth * 0.2,
                                      fit: BoxFit.fill,
                                    ),
                                progressIndicatorBuilder:
                                    (context, url, progress) => Container(
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
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 15,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    data.category,
                                    style: GoogleFonts.dmSans(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.greyTextColor.withOpacity(
                                      0.15,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: Center(
                                      child: Text(
                                        data.status??'',
                                        style: GoogleFonts.dmSans(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 1.50),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: _parseColor(data.color),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.grey),
                                  ),

                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '₹${data.price}',
                              style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                  fontSize: 17,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonButton(
                        text: 'Edit',
                        isBorder: true,
                        ontap: () {
                          // Open bottom sheet with product data for editing
                          addCatalogueBottomSheet(context, product: data);
                        },
                      ),
                      CommonButton(
                        text: 'Delete Ad',
                        ontap: () {
                          HomeController.to.deleteProduct(
                            data.id.toString(),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Utils.columnSpacer(height: screenHeight * 0.03),
        ],
      ),
    );
  }
}

void addCatalogueBottomSheet(BuildContext context, {Product? product}) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    backgroundColor: AppColors.whiteDimColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (BuildContext context) {
      return AddCatalogue(product: product);
    },
  );

}
Color _parseColor(String hexColor) {
  hexColor = hexColor.replaceAll('#', '');
  log(hexColor);
  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
    log(hexColor);
  }
 var color=Color(int.parse(hexColor, radix: 16));
  log(color.toString());
  return color;

}