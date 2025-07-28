import 'package:aadaiz_seller/src/res/components/common_toast.dart';
import 'package:aadaiz_seller/src/utils/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/colors/app_colors.dart';
import '../profile/bloc/designer_profile_bloc.dart';
import 'designer_notification.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = DesignerProfileBloc();
    bloc.add(FetchProfileEvent());
    return Row(
      children: [
        BlocConsumer<DesignerProfileBloc, DesignerProfileState>(
          bloc: bloc,
          listener: (context, state) {
          },
          builder: (context, state) {
            switch(state.runtimeType){
              case  DesignerProfileLoadingState:
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonLoading(height: 5.0.hp,)
                  ],
                );
              case DesignerProfileSuccessState:
                state as DesignerProfileSuccessState;
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[200],
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: '${state.designerProfile!.avatarUrl}',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          placeholder: (BuildContext context,
                              String url) => const CircularProgressIndicator(),
                          errorWidget: (BuildContext context, String url,
                              Object error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning',
                          style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.greyTextColor.withOpacity(0.5),
                                  fontWeight: FontWeight.w400)),
                        ),
                        Text(
                          state.designerProfile!.name??'',
                          style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ],
                );
              default:    return  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonLoading(height: 5.0.hp,)
                ],
              );
            }
          }),

        const Spacer(),
        InkWell(
          onTap: () {
            Get.to(() => const DesignerNotification());
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/images/notification.svg'),
          ),
        ),
      ],
    );
  }
}