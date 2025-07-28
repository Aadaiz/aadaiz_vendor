import 'package:aadaiz_seller/src/features/tailor/controller/tailor_controller.dart';
import 'package:aadaiz_seller/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/colors/app_colors.dart';
import '../../../../res/components/common_button.dart';
import '../../../../res/components/common_toast.dart';
import '../../../../res/components/widgets/custom_appbar.dart';
import '../../model/category_list_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<String> categories = ['Women', 'Girl', 'Men', 'Boys'];
  List<PatternCategory> category = [];
  List<PatternCategory> subCategory = [];

  int selectedCategory = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TailorController.to.selectedCategory.clear();
      TailorController.to.getFilterList();
      category =
      TailorController.to.filterList[selectedCategory].patternCategories!;
    });

  }

  @override
  Widget build(BuildContext context) {
    // final RangeLabels labels =
    //     RangeLabels(_values.start.toString(), _values.end.toString());

    return Scaffold(
      backgroundColor: AppColors.whiteDimColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text(
          'Category',
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
              fontSize: 14.00.sp,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 3.0.hp),
          child: Obx(
            () => TailorController.to.filterListLoading.value
                ? const CommonLoading()
                : TailorController.to.filterList.isEmpty
                ? const CommonEmpty(title: 'Filters')
                : Row(
                    children: [
                      // Sidebar
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.greyTextColor.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        width: Get.width * 0.3,
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            // if (index != 4 ) {
                            //   category = TailorController
                            //       .to
                            //       .filterList
                            //       .value[selectedCategory]
                            //       .patternCategories!;
                            // }

                            return Column(
                              children: [
                                Container(
                                  width: Get.width * 0.3,
                                  color: selectedCategory == index
                                      ? Colors.white
                                      : Colors.grey[200],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedCategory = index;
                                          });
                                          category = TailorController
                                              .to
                                              .filterList[selectedCategory]
                                              .patternCategories!;
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                            horizontal: 8,
                                          ),
                                          child: Text(
                                            categories[index],
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                fontSize: 14.00.sp,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Column(
                        children: [
                          Gap(2.0.hp),
                          SizedBox(
                            height: Get.height * 0.7,
                            width: Get.width * 0.7,
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: category.length,
                              itemBuilder: (context, i) {
                                var data = category[i];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Row(
                                        children: [
                                          Text(
                                            category[i].catName ?? '',
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                fontSize: 14.00.sp,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    data.patternFiltercategories!.isEmpty
                                        ? const SizedBox()
                                        : Wrap(
                                      spacing: 8,
                                            direction: Axis.horizontal,
                                            children: data.patternFiltercategories!.asMap().entries.map((
                                              i,
                                            ) {
                                              bool isSelected = TailorController
                                                  .to
                                                  .selectedCategory
                                                  .contains(i.value);
                                              print('adsfdsa $isSelected');
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (isSelected) {
                                                      TailorController
                                                          .to
                                                          .selectedCategory
                                                          .remove(i.value);
                                                    } else {
                                                      TailorController
                                                          .to
                                                          .selectedCategory
                                                          .add(i.value);
                                                    }
                                                  });
                                                  print(
                                                    'dasfdas ${TailorController.to.selectedCategory[0]}',
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(topRight:Radius.circular(0),topLeft:Radius.circular(0),bottomRight: Radius.circular(6),bottomLeft: Radius.circular(6)
                                                          ,
                                                        ),
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? AppColors.starColor
                                                          : Colors.transparent,
                                                      width: 1,
                                                    ),
                                                    color: AppColors.whiteColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset: const Offset(
                                                          2,
                                                          2,
                                                        ),
                                                        blurRadius: 20,
                                                        color: AppColors
                                                            .greyTextColor
                                                            .withOpacity(0.1),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                  BorderRadius.only(topRight:Radius.circular(0),topLeft:Radius.circular(0),bottomRight: Radius.circular(6),bottomLeft: Radius.circular(6)
                                                  ) ,
                                                        child: SizedBox(
                                                          width:
                                                              Get.width * 0.2,
                                                          height:
                                                              Get.width * 0.2,
                                                          child: Image.network(
                                                            '${i.value.image}',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      Text(
                                                        "${i.value.name ?? ''}",
                                                        style: GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                            fontSize: 7.00.sp,
                                                            color: AppColors
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
      bottomNavigationBar:  Padding(

        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                TailorController.to.selectedCategory.clear();
                Get.back();
              },
              child: CommonButton(
                text: 'Cancel',
                width: Get.width * 0.4,
                isLoading: false,
                borderRadius: 8.4,
                isBorder: true,
                height: 45.5,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: CommonButton(
                height: 45.5,
                text: 'Ok',
                width: Get.width * 0.4,
                isLoading: false,
                borderRadius: 8.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
