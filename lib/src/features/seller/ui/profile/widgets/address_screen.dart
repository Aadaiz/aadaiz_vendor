import 'package:aadaiz_seller/src/features/seller/ui/profile/controller/profile_controller.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/widgets/edit_address.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../res/colors/app_colors.dart';

class AddressScreen extends StatefulWidget {
  final String type;
  const AddressScreen({super.key, required this.type});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileController.to.getaddresslist("list", widget.type);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
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
          'Your Address',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Obx(
              () => ProfileController.to.isLoading.value
                  ? Utils.carshimmer(lenght: 4)
                  : ProfileController.to.addresslist.isEmpty
                  ? const Center(child: Text("No Address Available"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: ProfileController.to.addresslist.length,
                      itemBuilder: (context, index) {
                        final data = ProfileController.to.addresslist[index];
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
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
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              data.name ?? '',
                                              style: GoogleFonts.dmSans(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              data.address ?? '',
                                              style: GoogleFonts.dmSans(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      TextButton(
                                        onPressed: () {
                                          Get.to(
                                            () => EditAddress(data: data),
                                          )!.then((Object? value) {
                                            ProfileController.to.getaddresslist(
                                              "list",
                                              widget.type,
                                            );
                                          });
                                        },

                                        child: Text(
                                          'Edit',
                                          style: GoogleFonts.dmSans(
                                            fontSize: 16,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: true,
                                        onChanged: (bool? value) {},
                                        activeColor: Colors.red,
                                      ),
                                      Text(
                                        'Use as the shipping address',
                                        style: GoogleFonts.dmSans(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
