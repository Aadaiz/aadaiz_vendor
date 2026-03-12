import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/res/components/widgets/overlay_widgets.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
bool isCategory= false;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _ddFocus = FocusNode();
  final FocusNode _productNameFocus = FocusNode();
  final FocusNode _categoryFocus = FocusNode();
  final FocusNode _shopDDFocus = FocusNode();
//  final List<String> _ddList = <String>['Category', 'List'];
  final List<String> _ddListShop = <String>['Shop Photo', 'Product Photo'];

  @override
  void dispose() {
    _nameFocus.dispose();
    _addressFocus.dispose();
    _ddFocus.dispose();
    _productNameFocus.dispose();
    _shopDDFocus.dispose();
    _categoryFocus.dispose();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
      await AuthController.to.getCategory();
    });

  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    ScreenUtil.init(context);

    return Column(
      children: <Widget>[
        OverlayWidgets.fullWidthTextField(
            label: Text(
               'Enter Shop Name',
              style: GoogleFonts.inter(
                  color: AppColors.blackColor
              )
            ),
            child: SizedBox(
              height: screenHeight * 0.05,
              child: TextFormField(
                focusNode: _nameFocus,
                  controller:  AuthController.to.name,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      hintText: 'Store Name',
                      hintStyle: GoogleFonts.inter(
                          color: AppColors.hintTextColor,
                          fontSize: 12.sp
                      ),
                      fillColor: AppColors.whiteColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColors.textFieldBorderColor
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColors.textFieldBorderColor
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColors.textFieldBorderColor
                          )
                      )
                  ),
                  onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                      context: context,
                      currentFocus: _nameFocus,
                      nextFocus: _addressFocus
                  )
              )
            )
        ),
        OverlayWidgets.fullWidthTextField(
            label: Text(
                'Shop Address',
                style: GoogleFonts.inter(
                    color: AppColors.blackColor
                )
            ),
            child: SizedBox(
              height: screenHeight * 0.05,
              child: TextFormField(
                  focusNode: _addressFocus,
                  controller:  AuthController.to.address,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Store Address',
                      hintStyle: GoogleFonts.inter(
                          color: AppColors.hintTextColor,
                          fontSize: 12.sp
                      ),
                      fillColor: AppColors.whiteColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColors.textFieldBorderColor
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColors.textFieldBorderColor
                          )
                      ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: AppColors.textFieldBorderColor
                        )
                    )
                  ),
                  onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                      context: context,
                      currentFocus: _addressFocus,
                      nextFocus: _ddFocus
                  )
              )
            )
        ),
        OverlayWidgets.fullWidthTextField(
            label: RichText(
                text: TextSpan(
                    text: 'Products You willing To Sell ',
                    style: GoogleFonts.inter(
                        color: AppColors.blackColor
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                          text: '*',
                          style: GoogleFonts.inter(
                              color: AppColors.ddStarColor
                          )
                      )
                    ]
                )
            ),
            child: InkWell(
              child: SizedBox(
                  height: screenHeight * 0.05,
                  child: TextFormField(
                      onTap: (){
                        // setState(() {
                        //   isCategory =!isCategory;
                        // });
                      },
                      readOnly: false,
                      focusNode: _productNameFocus,
                      controller:  AuthController.to.category,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        // suffixIcon: const Icon(Icons.keyboard_arrow_down,size: 25,color: AppColors.primaryColor,),
                          hintText: 'Category',
                          hintStyle: GoogleFonts.inter(
                              color: AppColors.hintTextColor,
                              fontSize: 12.sp
                          ),
                          fillColor: AppColors.whiteColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldBorderColor
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldBorderColor
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldBorderColor
                              )
                          )
                      ),
                      onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                          context: context,
                          currentFocus: _nameFocus,
                          nextFocus: _addressFocus
                      )
                  )
              ),
            )
        ),
        isCategory?
        Container(
          width: screenWidth*0.85,
          height: screenHeight*0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey)
          ),
          child: ListView.separated(
            separatorBuilder: ( context,  index) => const Divider(),
              shrinkWrap: true,
              itemCount: AuthController.to.categoryList.value.length,
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              itemBuilder: (context,index){
                var data = AuthController.to.categoryList.value[index];
                return  InkWell(
                  onTap: (){
                    setState(() {
                      isCategory=!isCategory;
                    });
                    AuthController.to.category.text = data.catName??'';
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('${data.catName??''}',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: 14.00.sp,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400
                            )
                        )),
                  ),
                );
              }),
        )
            :const SizedBox(),
        Utils.columnSpacer(
            height: screenHeight * 0.01
        ),
        // OverlayWidgets.fullWidthTextField(
        //   isHeight: true,
        //     label: RichText(
        //         text: TextSpan(
        //             text: 'Can’t Find Category ? ',
        //             style: GoogleFonts.inter(
        //                 color: AppColors.blackColor
        //             ),
        //             children: <InlineSpan>[
        //               TextSpan(
        //                   text: 'Write Here',
        //                   style: GoogleFonts.inter(
        //                       color: AppColors.inkColor
        //                   )
        //               )
        //             ]
        //         )
        //     ),
        //     child: SizedBox(
        //         height: screenHeight * 0.08,
        //         child: TextFormField(
        //           maxLines: null,
        //             textAlignVertical: TextAlignVertical.top,
        //             focusNode: _categoryFocus,
        //             controller:  AuthController.to.otherProduct,
        //             expands: true,
        //             keyboardType: TextInputType.multiline,
        //             textInputAction: TextInputAction.next,
        //             textCapitalization: TextCapitalization.words,
        //             decoration: InputDecoration(
        //                 isDense: true,
        //                 hintText: 'Write Product Name',
        //                 hintStyle: GoogleFonts.inter(
        //                     color: AppColors.hintTextColor,
        //                     fontSize: 12.sp
        //                 ),
        //                 fillColor: AppColors.whiteColor,
        //                 filled: true,
        //                 border: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(8),
        //                     borderSide: const BorderSide(
        //                         color: AppColors.textFieldBorderColor
        //                     )
        //                 ),
        //                 enabledBorder: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(8),
        //                     borderSide: const BorderSide(
        //                         color: AppColors.textFieldBorderColor
        //                     )
        //                 ),
        //                 focusedBorder: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(8),
        //                     borderSide: const BorderSide(
        //                         color: AppColors.textFieldBorderColor
        //                     )
        //                 )
        //             ),
        //             onFieldSubmitted: (String val) => Utils.fieldFocusChange(
        //                 context: context,
        //                 currentFocus: _categoryFocus,
        //                 nextFocus: _shopDDFocus
        //             )
        //         )
        //     )
        // ),
        Utils.columnSpacer(
            height: screenHeight * 0.01
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 5
          ),
          child: SizedBox(
              height: screenHeight * 0.077,
              child: DropdownButtonFormField<String>(
                focusNode: _shopDDFocus,
                  padding: EdgeInsets.zero,
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(18),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldBorderColor
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldBorderColor
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldBorderColor
                          )
                      )
                  ),
                  hint: RichText(
                      text: TextSpan(
                          text: _ddListShop.first,
                          style: GoogleFonts.dmSans(
                              color: AppColors.blackColor,
                              fontSize: 14.sp
                          ),
                          children: const <InlineSpan>[
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                    color: AppColors.ddStarColor
                                )
                            )
                          ]
                      )
                  ),
                  icon: SvgPicture.asset(
                      'assets/images/ic_dd.svg'
                  ),
                  items: _ddListShop.map<DropdownMenuItem<String>>((String val){

                    return DropdownMenuItem<String>(
                        value: val,
                        child: RichText(
                            text: TextSpan(
                                text: val,
                                style: GoogleFonts.dmSans(
                                    color: AppColors.blackColor,
                                    fontSize: 15.sp
                                ),
                                children: const <InlineSpan>[
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          color: AppColors.ddStarColor
                                      )
                                  )
                                ]
                            )
                        )
                    );

                  }).toList(),
                  onChanged: (String? val){}
              )
          ),
        ),
        Utils.columnSpacer(
            height: screenHeight * 0.05
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 8,
              right: 5
          ),
          child: Obx(()=>
           DottedBorder(
              color: AppColors.greyTextColor,
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                child: SizedBox(
                    height: screenHeight * 0.16,
                    width: double.infinity,
                    child:  AuthController.to.storeImage.value.path!=''?
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: FileImage(
                              File(AuthController.to.storeImage.value.path)))
                      ),
                    ): Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              'Upload your shop photo',
                              style: GoogleFonts.dmSans(
                                  color: AppColors.greyTextColor,
                                  fontSize: 11.sp
                              )
                          ),
                          Utils.columnSpacer(
                              height: screenHeight * 0.03
                          ),
                          InkWell(
                            onTap: (){
                              AuthController.to.showdialog(context, picture: 2);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all()
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.005,
                                    horizontal: screenWidth * 0.05
                                ),
                                child: Text(
                                    'Upload +',
                                    style: GoogleFonts.dmSans(
                                        fontSize: 11.sp,
                                        color: AppColors.blackColor
                                    )
                                )
                            ),
                          ),

                        ]
                    )
                )
            ),
          ),
        )
      ]
    );

  }

}

