import 'package:aadaiz_seller/src/features/seller/ui/home/controller/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../res/colors/app_colors.dart';
import '../../../../../utils/utils.dart';
import '../model/home_model.dart';
import 'package:carousel_slider/carousel_slider.dart'
    as cs; // Alias for carousel_slider

class CommonCardWidget extends StatefulWidget {
  final Product data;

  const CommonCardWidget({super.key, required this.data});
  @override
  State<CommonCardWidget> createState() => _CommonCardWidgetState();
}
class _CommonCardWidgetState extends State<CommonCardWidget> {
  final List<String> stockStatus = ['In Stock', 'Out Of Stock'];
  late String selectedStatus; // Make it a state variable

  @override
  void initState() {
    super.initState();
    // Initialize selectedStatus based on widget.data or default to 'Out Of Stock'
    selectedStatus = widget.data.stockStatus == 'in_stock' ? 'In Stock' : 'Out Of Stock';
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<String> imageUrls = widget.data.image
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
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.data.category,
                                    style: GoogleFonts.dmSans(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  '₹${widget.data.price}',
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: const TextStyle(
                                      height: 1,
                                      fontSize: 20,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 4),
                                      Text(
                                        widget.data.color,
                                        style: GoogleFonts.dmSans(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.greyTextColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            height: 25,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.red[600],
                                              borderRadius:
                                              BorderRadius.circular(4),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: selectedStatus,
                                                dropdownColor: Colors.red[600],
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.white,
                                                ),
                                                items: stockStatus.map((
                                                    String value,
                                                    ) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      selectedStatus = value;
                                                    });
                                                    // Call API to update stock status
                                                    HomeController.to
                                                        .updateStockStatus(
                                                      widget.data.id.toString(),
                                                      value == 'In Stock'
                                                          ? 'in_stock'
                                                          : 'out_of_stock',
                                                    );
                                                  }
                                                },
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // Call API to delete product
                                              HomeController.to.deleteProduct(
                                                widget.data.id.toString(),
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 15, top: 10),
                                              width: 100,
                                              height: 26,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  color: Color(0xFFF2F2F2),
                                                  border: Border.all(
                                                      color: AppColors
                                                          .textFieldBorderColor)),
                                              child: Center(child: Text("Remove")),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
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
