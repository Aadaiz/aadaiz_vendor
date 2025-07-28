import 'dart:io';

import 'package:aadaiz_seller/src/features/designer/controller/designer_controller.dart';
import 'package:aadaiz_seller/src/features/designer/ui/profile/bloc/designer_profile_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/designer/ui/profile/password_manager.dart';
import '../../../../res/colors/app_colors.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../../auth/ui/login/login.dart';

class DesignerProfile extends StatefulWidget {
  const DesignerProfile({super.key});

  @override
  State<DesignerProfile> createState() => _DesignerProfileState();
}

class _DesignerProfileState extends State<DesignerProfile> {
  final bloc = DesignerProfileBloc();

  String email = '';
  String image = '';
  @override
  void initState() {
    bloc.add(FetchProfileEvent());
    DesignerController.to.updateLoading(false);
    DesignerController.to.image.value=File('');
    super.initState();
  }

  final FocusNode passwordFocus = FocusNode();
  TextEditingController password = TextEditingController();
  bool _obscured = true;
  @override
  void dispose() {
    super.dispose();
    passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return  Obx(()=>
      Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: InkWell(
            onTap: () {
              DesignerController.to.tabSelected.value=0;
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 24,
              color: AppColors.blackColor,
            ),
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Profile',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            fontSize: 20,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
             // if (!DesignerController.to.updateLoading.value) {
                DesignerController.to.uploadProfile(password.text, email,image);
             // }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                Icons.check,
                color: !DesignerController.to.updateLoading.value
                    ? AppColors.primaryColor
                    : AppColors.greyTextColor,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<DesignerProfileBloc, DesignerProfileState>(
          bloc: bloc,
          builder: (context, state) {
            switch (state.runtimeType) {
              case DesignerProfileLoadingState:
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: AppColors.primaryColor),
                  ],
                );
              case DesignerProfileSuccessState:
                state as DesignerProfileSuccessState;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Obx(()=>
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: DesignerController.to.image.value.path != '' ?
                              CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(DesignerController.to.image.value))
                                  : CachedNetworkImage(
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                        radius: 50,
                                        backgroundImage: imageProvider),
                                errorWidget: (context, url, error) =>
                                   Container(
                                       width: 100,
                                       height: 100,
                                       decoration: BoxDecoration(
                                         color: AppColors.greyTextColor.withOpacity(0.5),
                                         shape: BoxShape.circle,
                                       ),
                                       child: Icon(Icons.error)),
                                progressIndicatorBuilder:
                                    (context, url, progress) => CircleAvatar(
                                  radius: 50,
                                  child: Center(
                                      child: Transform.scale(
                                        scale: 0.5,
                                        child: CircularProgressIndicator(
                                          color: Colors.grey,
                                          strokeWidth: 2,
                                          value: progress.progress,
                                        ),
                                      )),
                                ),
                                imageUrl: '${state.designerProfile!.avatarUrl}',
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                AuthController.to.showdialog(
                                  context,
                                  picture: 7,
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 12,
                                child: Image.asset('assets/images/eid.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.designerProfile!.name ?? '',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: screenHeight * 0.05,
                        child: TextFormField(
                          focusNode: passwordFocus,
                          readOnly: _obscured,
                          controller: password,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            hintText: 'User Name',
                            hintStyle: GoogleFonts.inter(
                              color: AppColors.hintTextColor,
                              fontSize: 12.sp,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _obscured = !_obscured;
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/eid.png',
                                  height: 8,
                                  width: 8,
                                ),
                              ),
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
                      const SizedBox(height: 16.0),
                      InkWell(
                        onTap: () {
                          Get.to(() => const PasswordManager());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: AppColors.greyTextColor.withOpacity(
                                    0.1,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Password Manager',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          AuthController.to.showLogOut(context);
                        },
                        child: ListTile(
                          leading: const Icon(Icons.logout, color: Colors.red),
                          title: Text(
                            'Log Out',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              color: AppColors.starColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ));
              default:
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: AppColors.primaryColor),
                  ],
                );
            }
          },
          listener: (BuildContext context, DesignerProfileState state) {
            if (state is DesignerProfileSuccessState) {
              password.text = state.designerProfile!.name ?? "";
              email = state.designerProfile!.email ?? "";
              image = state.designerProfile!.avatarUrl ?? "";
            }
          },
        ),
      ),
    ));
  }

  Widget textWidget({
    IconData? leading,
    required IconData trailing,
    required String title,
    bool? isAddress = false,
    String? image,
  }) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.dmSans(
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor,
          fontSize: 15,
        ),
      ),
      trailing: Icon(trailing, color: AppColors.primaryColor),
    );
  }
}
