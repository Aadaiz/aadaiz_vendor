import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/res/components/widgets/overlay_widgets.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

class Bank extends StatefulWidget {
  const Bank({super.key});

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {


  final FocusNode _accountFocus = FocusNode();
  final FocusNode _confirmAccountNumberFocus = FocusNode();
  final FocusNode _ifscCodeFocus = FocusNode();

  @override
  void dispose() {

    super.dispose();
    _accountFocus.dispose();
    _confirmAccountNumberFocus.dispose();
    _ifscCodeFocus.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    ScreenUtil.init(context);

    return Column(
      children: <Widget>[
        OverlayWidgets.fullWidthTextField(
            label: RichText(
                text: TextSpan(
                    text: 'Account Number',
                    style: GoogleFonts.inter(
                        color: AppColors.blackColor
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                          text: ' *',
                          style: GoogleFonts.inter(
                              color: AppColors.starColor
                          )
                      )
                    ]
                )
            ),
            child: SizedBox(
              height: screenHeight * 0.05,
              child: TextFormField(
                focusNode: _accountFocus,
                  controller: AuthController.to.accountNumber,                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Account Number',
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
                      currentFocus: _accountFocus,
                      nextFocus: _confirmAccountNumberFocus
                  )
              )
            )
        ),
        OverlayWidgets.fullWidthTextField(
            label: RichText(
                text: TextSpan(
                    text: 'Confirm Account Number *',
                    style: GoogleFonts.inter(
                        color: AppColors.blackColor
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                          text: ' *',
                          style: GoogleFonts.inter(
                              color: AppColors.starColor
                          )
                      )
                    ]
                )
            ),
            child: SizedBox(
              height: screenHeight * 0.05,
              child: TextFormField(
                  focusNode: _confirmAccountNumberFocus,
                  controller: AuthController.to.confirmAccountNumber,                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Confirm Account Number',
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
                      currentFocus: _confirmAccountNumberFocus,
                      nextFocus: _ifscCodeFocus
                  )
              )
            )
        ),
        OverlayWidgets.fullWidthTextField(
            label: RichText(
                text: TextSpan(
                    text: 'IFSC Code',
                    style: GoogleFonts.inter(
                        color: AppColors.blackColor
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                          text: ' *',
                          style: GoogleFonts.inter(
                              color: AppColors.starColor
                          )
                      )
                    ]
                )
            ),
            child: SizedBox(
                height: screenHeight * 0.05,
                child: TextFormField(
                    focusNode: _ifscCodeFocus,
                    controller: AuthController.to.ifscCode,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: 'IFSC Code',
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
                    )
                )
            )
        )
      ]
    );

  }

}