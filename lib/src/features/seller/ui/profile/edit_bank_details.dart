import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/colors/app_colors.dart';
import '../../../../res/components/common_toast.dart';
import '../../../../res/components/loading_button.dart';
import '../../../../res/components/widgets/overlay_widgets.dart';
import '../../../../utils/utils.dart';
import '../../../auth/controller/auth_controller.dart';
import 'controller/profile_controller.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/model/profile_details_model.dart';

class BankEdit extends StatefulWidget {
  final Data data;

  const BankEdit({super.key, required this.data});

  @override
  State<BankEdit> createState() => _BankEditState();
}

class _BankEditState extends State<BankEdit> {
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _accountFocus = FocusNode();
  final FocusNode _confirmAccountNumberFocus = FocusNode();
  final FocusNode _ifscCodeFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _nameFocus.dispose();
    _accountFocus.dispose();
    _confirmAccountNumberFocus.dispose();
    _ifscCodeFocus.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    AuthController.to.bankName.text = widget.data.bankName ?? "";
    AuthController.to.accountNumber.text = widget.data.accountNumber ?? "";
    AuthController.to.confirmAccountNumber.text =
        widget.data.confirmAccountNumber ?? "";
    AuthController.to.ifscCode.text = widget.data.ifscCode ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
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
        forceMaterialTransparency: true,
        title: Text(
          'Your Bank Details',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03),
        children: <Widget>[
          OverlayWidgets.fullWidthTextField(
            label: RichText(
              text: TextSpan(
                text: 'Bank Name',
                style: GoogleFonts.inter(color: AppColors.blackColor),
                children: <InlineSpan>[
                  TextSpan(
                    text: ' *',
                    style: GoogleFonts.inter(color: AppColors.starColor),
                  ),
                ],
              ),
            ),
            child: SizedBox(
              height: screenHeight * 0.05,
              child: TextFormField(
                focusNode: _nameFocus,

                controller: AuthController.to.bankName,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Bank Name',
                  hintStyle: GoogleFonts.inter(
                    color: AppColors.hintTextColor,
                    fontSize: 12.sp,
                  ),
                  fillColor: AppColors.whiteColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                ),
                onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                  context: context,
                  currentFocus: _nameFocus,
                  nextFocus: _confirmAccountNumberFocus,
                ),
              ),
            ),
          ),
          OverlayWidgets.fullWidthTextField(
            label: RichText(
              text: TextSpan(
                text: 'Account Number',
                style: GoogleFonts.inter(color: AppColors.blackColor),
                children: <InlineSpan>[
                  TextSpan(
                    text: ' *',
                    style: GoogleFonts.inter(color: AppColors.starColor),
                  ),
                ],
              ),
            ),
            child: SizedBox(
              height: screenHeight * 0.05,
              child: TextFormField(
                focusNode: _accountFocus,
                controller: AuthController.to.accountNumber,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Account Number',
                  hintStyle: GoogleFonts.inter(
                    color: AppColors.hintTextColor,
                    fontSize: 12.sp,
                  ),
                  fillColor: AppColors.whiteColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                ),
                onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                  context: context,
                  currentFocus: _accountFocus,
                  nextFocus: _confirmAccountNumberFocus,
                ),
              ),
            ),
          ),
          OverlayWidgets.fullWidthTextField(
            label: RichText(
              text: TextSpan(
                text: 'Confirm Account Number *',
                style: GoogleFonts.inter(color: AppColors.blackColor),
                children: <InlineSpan>[
                  TextSpan(
                    text: ' *',
                    style: GoogleFonts.inter(color: AppColors.starColor),
                  ),
                ],
              ),
            ),
            child: SizedBox(
              height: screenHeight * 0.05,
              child: TextFormField(
                focusNode: _confirmAccountNumberFocus,
                controller: AuthController.to.confirmAccountNumber,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Confirm Account Number',
                  hintStyle: GoogleFonts.inter(
                    color: AppColors.hintTextColor,
                    fontSize: 12.sp,
                  ),
                  fillColor: AppColors.whiteColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                ),
                onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                  context: context,
                  currentFocus: _confirmAccountNumberFocus,
                  nextFocus: _ifscCodeFocus,
                ),
              ),
            ),
          ),
          OverlayWidgets.fullWidthTextField(
            label: RichText(
              text: TextSpan(
                text: 'IFSC Code',
                style: GoogleFonts.inter(color: AppColors.blackColor),
                children: <InlineSpan>[
                  TextSpan(
                    text: ' *',
                    style: GoogleFonts.inter(color: AppColors.starColor),
                  ),
                ],
              ),
            ),
            child: SizedBox(
              height: screenHeight * 0.05,
              child: TextFormField(
                focusNode: _ifscCodeFocus,
                controller: AuthController.to.ifscCode,

                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'IFSC Code',
                  hintStyle: GoogleFonts.inter(
                    color: AppColors.hintTextColor,
                    fontSize: 12.sp,
                  ),
                  fillColor: AppColors.whiteColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Utils.columnSpacer(height: screenHeight * 0.07),
          Obx(()=>
           LoadingButton(
              title: 'Save',
              loading: ProfileController.to.isLoadingupdate.value,
              onPressed: () {
                if (AuthController.to.bankName.text.trim().isEmpty) {
                  CommonToast.show(msg: "Please enter Bank Name");
                  return;
                }
                if (AuthController.to.accountNumber.text.trim().isEmpty) {
                  CommonToast.show(msg: "Please enter Account number");
                  return;
                }
                if (AuthController.to.confirmAccountNumber.text.trim().isEmpty) {
                  CommonToast.show(msg: "Please enter confirm Account number");
                  return;
                }
                if (AuthController.to.confirmAccountNumber.text !=
                    AuthController.to.accountNumber.text) {
                  CommonToast.show(
                    msg:
                        "Please enter confirm Account number same as Account number",
                  );
                  return;
                }
                if (AuthController.to.ifscCode.text.trim().isEmpty) {
                  CommonToast.show(msg: "Please enter IFSC code");
                  return;
                }
                ProfileController.to.UpdateProfile();
              },
              btnWidth: screenWidth / 1.2,
              btnHeight: screenHeight * 0.055,
            ),
          ),
        ],
      ),
    );
  }
}
