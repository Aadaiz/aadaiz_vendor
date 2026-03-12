import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/res/components/widgets/overlay_widgets.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

class Gst extends StatefulWidget {
  final ValueChanged<bool>? onValidationChanged;
  const Gst({super.key, this.onValidationChanged});

  @override
  State<Gst> createState() => _GstState();
}

class _GstState extends State<Gst> {
  bool visible = true;
  String? errorText;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    // Add listener to validate on text change
    AuthController.to.gstNumber.addListener(_validateGST);
  }

  @override
  void dispose() {
    AuthController.to.gstNumber.removeListener(_validateGST);
    super.dispose();
  }

  void _validateGST() {
    final gstNumber = AuthController.to.gstNumber.text.trim();
    String? newErrorText;

    if (gstNumber.isEmpty) {
      newErrorText = null;
      isValid = false;
    } else {
      // Remove all spaces and convert to uppercase
      final cleanGST = gstNumber.replaceAll(RegExp(r'\s+'), '').toUpperCase();

      // Basic GST validation regex (15 characters, alphanumeric)
      final gstRegex = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');

      if (!gstRegex.hasMatch(cleanGST)) {
        newErrorText = 'Invalid GST Number format';
        isValid = false;
      } else if (!_verifyGSTChecksum(cleanGST)) {
        newErrorText = 'Invalid GST Number';
        isValid = false;
      } else {
        newErrorText = null;
        isValid = true;
      }
    }

    if (mounted) {
      setState(() {
        errorText = newErrorText;
      });
      widget.onValidationChanged?.call(isValid);
    }
  }

  // GST checksum verification (basic implementation)
  bool _verifyGSTChecksum(String gstNumber) {
    if (gstNumber.length != 15) return false;

    // GST structure: 99AAAAA9999A9Z9
    // 99: State code
    // AAAAA: PAN number (first 5 chars)
    // 9999: Entity number
    // A: PAN check digit
    // 9: Registration type
    // Z: Default value
    // 9: Checksum digit

    // Extract PAN from GST
    final pan = gstNumber.substring(2, 7);

    // PAN validation regex
    final panRegex = RegExp(r'^[A-Z]{3}[ABCFGHLJPTF]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}$');

    // The 10th character in GST should match the 5th character in PAN
    if (gstNumber[9] != pan[4]) {
      return false;
    }

    // Additional validation can be added here
    // This is a basic check - for production, consider using a proper GST validation API

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    ScreenUtil.init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OverlayWidgets.fullWidthTextField(
          label: RichText(
            text: TextSpan(
                text: 'Enter GST Number',
                style: GoogleFonts.inter(color: AppColors.blackColor),
                children: <InlineSpan>[
                  TextSpan(
                      text: ' *',
                      style: GoogleFonts.inter(color: AppColors.starColor)
                  )
                ]
            ),
          ),
          child: SizedBox(
            height: screenHeight * 0.05,
            child: TextFormField(
              obscureText: visible,
              controller: AuthController.to.gstNumber,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.characters,
              maxLength: 15,
              onChanged: (value) {
                // Format GST as user types
                _formatGSTNumber(value);
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: 'E.g., 22AAAAA0000A1Z5',
                hintStyle: GoogleFonts.inter(
                    color: AppColors.hintTextColor,
                    fontSize: 12.sp
                ),
                counterText: '',
                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.016),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                    child: visible
                        ? Icon(Icons.remove_red_eye_outlined, size: 18.sp)
                        : Icon(Icons.lock, size: 18.sp),
                  ),
                ),
                fillColor: AppColors.whiteColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.textFieldBorderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: errorText != null ? Colors.red : AppColors.textFieldBorderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: errorText != null ? Colors.red : AppColors.textFieldBorderColor,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 12.w),
            child: Text(
              errorText!,
              style: GoogleFonts.inter(
                color: Colors.red,
                fontSize: 11.sp,
              ),
            ),
          ),
        if (isValid)
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 12.w),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 14.sp),
                SizedBox(width: 4.w),
                Text(
                  'Valid GST Number',
                  style: GoogleFonts.inter(
                    color: Colors.green,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 8.h),
        Text(
          'Format: 22AAAAA0000A1Z5 (15 characters)\n'
              '• First 2 digits: State code\n'
              '• Next 10 characters: PAN number\n'
              '• Last 3 characters: Registration details',
          style: GoogleFonts.inter(
            color: AppColors.greyTextColor,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }

  void _formatGSTNumber(String value) {

    final cleanValue = value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toUpperCase();


    AuthController.to.gstNumber.removeListener(_validateGST);
    AuthController.to.gstNumber.value = TextEditingValue(
      text: cleanValue,
      selection: TextSelection.collapsed(offset: cleanValue.length),
    );
    AuthController.to.gstNumber.addListener(_validateGST);


    _validateGST();
  }
}