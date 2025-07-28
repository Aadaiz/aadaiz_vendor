import 'package:aadaiz_seller/src/features/tailor/controller/tailor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';

import '../../../../res/components/common_button.dart';
import '../../../../utils/routes/routes.dart';
import '../../../../utils/routes/routes_name.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key, required this.mob});
final String mob;
  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(()=>
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'One Last ',
                    style: GoogleFonts.dmSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'Step',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                textWidget(title: 'Account Number'),
                const SizedBox(height: 16),
                SizedBox(
                  height: 65,
                  child: TextFormField(
                    maxLength: 18,
                    keyboardType: TextInputType.phone,
                    controller: TailorController.to.acc,
                    decoration: InputDecoration(
                      hintText: 'Account Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.5), width: 1.5),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                textWidget(title: 'Confirm Account Number'),
                const SizedBox(height: 16),
                SizedBox(
                  height: 65,
                  child: TextFormField(
                    maxLength: 18,
                    keyboardType: TextInputType.phone,
                    controller: TailorController.to.conacc,
                    decoration: InputDecoration(
                      hintText: 'Confirm Account Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.5), width: 1.5),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                textWidget(title: 'IFSC',isReq: false),
                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: TailorController.to.ifsc,
                    decoration: InputDecoration(
                      hintText: 'IFSC Code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.5), width: 1.5),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                    onTap: () async {

                     TailorController.to.tailorKyc(context);
                    },
                    child: CommonButton(
                      isLoading: TailorController.to.tailorLoading.value,
                      text:'Finish',borderRadius: 8.0,width: screenWidth*0.9,height: 50.0,)
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget textWidget({required String title,  bool? isReq=true}){
    return     RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
          TextSpan(
              text: ' *',
              style: GoogleFonts.dmSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: isReq==true? AppColors.starColor:Colors.transparent)
          ),
        ],
      ),
    );
  }
}
