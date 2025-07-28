import 'package:aadaiz_seller/src/features/seller/ui/profile/controller/profile_controller.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/widgets/payment_history_card.dart';

import '../../../../../res/colors/app_colors.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileController.to.getpaymentlist()
;  }

  final int _index = 0;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: AppColors.whiteDimColor,
      appBar:AppBar(
        backgroundColor: AppColors.whiteColor,
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
        title: Text(
          'Payment History',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Expanded(
            child: Obx(()=>
            ProfileController.to.isLoading.value?Utils.carshimmer(lenght: 5):ProfileController.to.paymentlist.isEmpty?Center(child: Text("No Data")):
              ListView.builder(
                itemCount:  ProfileController.to.paymentlist.length,
                itemBuilder: (context, index) {
                  final data =  ProfileController.to.paymentlist[index];
                  return  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                        child: PaymentHistoryItem(
                          title: data.serviceName??'',
                          date: data.paymentDate.toString(),
                          amount: data.amount??'',
                          imageUrl: "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSkCeg0AOADt2ssFwhXKQ9BKx7yc0HdH0MyTU8qN3ASYNzHSRAftn2xUHl2m2NZC7MrE53g2Y17Vpj_eJkmRYK7As8X28gCsk38ik5aVis1",
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
