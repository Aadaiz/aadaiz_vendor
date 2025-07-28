import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/res/components/widgets/overlay_widgets.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

class Gst extends StatefulWidget {
  const Gst({super.key});

  @override
  State<Gst> createState() => _GstState();
}

class _GstState extends State<Gst> {

  @override
  void dispose() {
    super.dispose();
  }
  bool visible =true;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    ScreenUtil.init(context);

    return OverlayWidgets.fullWidthTextField(
        label: RichText(
            text: TextSpan(
                text: 'Enter GST Number',
                style: GoogleFonts.inter(color: AppColors.blackColor),
                children: <InlineSpan>[
              TextSpan(
                  text: ' *',
                  style: GoogleFonts.inter(color: AppColors.starColor))
            ])),
        child: SizedBox(
          height: screenHeight * 0.05,
          child: TextFormField(
            obscureText: visible,
              controller: AuthController.to.gstNumber,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(

                  isDense: true,
                  hintText: 'GST Number',
                  hintStyle: GoogleFonts.inter(
                      color: AppColors.hintTextColor, fontSize: 12.sp),
                  suffixIcon: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.016),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            visible=!visible;
                          });
                        },
                        child:visible? Icon(Icons.remove_red_eye_outlined):Icon(Icons.lock),
                      )),
                  fillColor: AppColors.whiteColor,
                  filled: true,
                  border: OutlineInputBorder(


                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: AppColors.textFieldBorderColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: AppColors.textFieldBorderColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: AppColors.textFieldBorderColor)))),
        ));
  }
}
