import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/features/tailor/controller/tailor_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/widgets/address_screen.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/widgets/payment_history_screen.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/widgets/seller_support_screen.dart';

import '../../../../res/colors/app_colors.dart';
import '../../../auth/ui/login/login.dart';
import '../../../seller/ui/profile/controller/profile_controller.dart';
import '../../../tailor/ui/kyc/category_screen.dart';


class TailorProfile extends StatefulWidget {
  const TailorProfile({super.key});

  @override
  State<TailorProfile> createState() => _TailorProfileState();
}

class _TailorProfileState extends State<TailorProfile> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteDimColor,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.013),
          child: InkWell(
            onTap: () {
              TailorController.to.setTab(0);
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
        actions: [
          GestureDetector(
            onTap: () {
              // if (!DesignerController.to.updateLoading.value) {
              ProfileController.to.UpdateProfile();
              // }
            },
            child: Obx(()=>
                Padding(
                  padding: const EdgeInsets.all(16),
                  child:ProfileController.to.isLoadingupdate.value?SizedBox(width: 15,height: 15, child: CircularProgressIndicator(strokeWidth: 2,color: AppColors.primaryColor,)) :Icon(
                    Icons.check,
                    color:
                    AppColors.primaryColor
                    ,
                    size: 30,
                  ),
                ),
            ),
          ),
        ],
        title: Text(
          'Profile',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: 'https://via.placeholder.com/150',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (BuildContext context, String url) => const CircularProgressIndicator(),
                      errorWidget: (BuildContext context, String url, Object error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12,
                    child: Icon(
                      Icons.edit,
                      size: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
                'Veronica',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor,
                    fontSize : 20
                )
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const SizedBox(height: 16.0),
                InkWell(
                  onTap: (){
                    Get.to(()=>const CategoryScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(

                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(6),
                          border: Border.all(color: AppColors.greyTextColor.withOpacity(0.5))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Select Category',
                              style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blackColor)
                          ),
                          const Icon(Icons.keyboard_arrow_right_rounded,size: 25,)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),


            InkWell(
                onTap: (){
                  Get.to(()=>AddressScreen(type:'tailor'));
                },
                child: textWidget(isAddress: true,image:'assets/images/ad.png', trailing: Icons.arrow_forward_ios, title: 'Your Address')),
            InkWell(
                onTap: (){
                  Get.to(()=> const PaymentHistoryScreen());
                },child: textWidget(leading: Icons.history, trailing: Icons.arrow_forward_ios, title: 'Payment History')),
            InkWell(
                onTap: (){
                  Get.to(()=> AddressScreen(type:'tailor'));
                },child: textWidget(isAddress: true,image:'assets/images/lock.png', trailing: Icons.arrow_forward_ios, title: 'Privacy Policy')),
            ListTile(
              leading: const Icon(Icons.settings,
                color: AppColors.primaryColor,),
              title: Text('Delete Account',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                      fontSize : 15
                  )),
            ),
            InkWell(
              onTap: (){
                Get.to(()=> const SellerSupportScreen());
              },
              child: ListTile(
                leading: Image.asset('assets/images/help.png',
                  height: 20,),
                title: Text('Help Centre',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                        fontSize : 15
                    )),
              ),
            ),
            InkWell(
              onTap: (){
                AuthController.to.showLogOut(context);
              },
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: Text(
                    'Log Out',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        color: AppColors.starColor,
                        fontSize : 15
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget textWidget({ IconData? leading,
    required IconData trailing, required String title,bool? isAddress=false,String? image}){
    return  ListTile(
      leading:isAddress==true?Image.asset('$image',
        color: AppColors.primaryColor,
        height: 20,): Icon(leading,
        color: AppColors.primaryColor,),
      title: Text(title,
          style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
              fontSize : 15
          )
      ),
      trailing: Icon(trailing,color: AppColors.primaryColor,),
    );
  }
}
