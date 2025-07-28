import 'package:aadaiz_seller/src/features/designer/controller/designer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../res/colors/app_colors.dart';
import '../../../../../res/components/common_button.dart';
import '../../../../auth/controller/auth_controller.dart';

class MeetingCard extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final String date;
  final String time;
  final int type;
  final String? meetingUrl;
  final dynamic id;
  const MeetingCard({
    super.key,
    required this.name,
    required this.location,
    required this.date,
    required this.time,
    required this.type,
    this.meetingUrl,
    required this.image, this.id,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(image),
                    radius: 24.0,
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.dmSans(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        location,
                        style: GoogleFonts.dmSans(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  type == 0
                      ? InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  insetPadding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 16,
                                  child: ViewDetailDialog(url: meetingUrl, image: image, name: name, location: location, date: date, time:time,),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
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
                            child: const Center(child: Text('View details')),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Completed',
                              style: GoogleFonts.dmSans(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              if(type==0) ...[

                Divider(color: AppColors.greyTextColor.withOpacity(0.2)),
              ],
              const SizedBox(height: 8.0),
              const SizedBox(height: 8.0),
              Text(
                'Booking Information',
                style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 16.0),
                  const SizedBox(width: 4.0),
                  Text(
                    date,
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  const Icon(Icons.access_time, size: 16.0),
                  const SizedBox(width: 4.0),
                  Text(
                    time,
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              type == 2
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16.0),
                        Divider(color: AppColors.greyTextColor),
                        //const SizedBox(height: 16.0),
                        Text(
                          'Session Start & End Time',
                          style: GoogleFonts.dmSans(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '$time',
                          style: GoogleFonts.dmSans(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 16.0),
              type == 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            DesignerController.to.cancelAppointment(id);
                          },
                          child: CommonButton(
                            text: 'cancel',
                            isBorder: true,
                            borderRadius: 8.0,
                            width: screenWidth * 0.38,
                            height: 35.0,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            attendMeeting(meetingUrl);
                          },
                          child: CommonButton(
                            text: 'Join Meeting',
                            borderRadius: 8.0,
                            width: screenWidth * 0.38,
                            height: 35.0,
                          ),
                        ),
                      ],
                    )
                  : type == 2
                  ? Column(
                      children: [
                        // Container(
                        //   padding: const EdgeInsets.all(12),
                        //   decoration: BoxDecoration(
                        //     color: AppColors.whiteColor,
                        //     borderRadius: BorderRadius.circular(8),
                        //     boxShadow: <BoxShadow>[
                        //       BoxShadow(
                        //         color: AppColors.blackColor.withOpacity(0.1),
                        //         blurRadius: 10,
                        //         offset: const Offset(0, 2),
                        //       ),
                        //     ],
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       Image.asset(
                        //         'assets/images/pencil.png',
                        //         height: 20,
                        //       ),
                        //       const SizedBox(width: 16),
                        //       Text(
                        //         'Measurement Sheet',
                        //         style: GoogleFonts.dmSans(
                        //           textStyle: const TextStyle(
                        //             fontSize: 12,
                        //             color: AppColors.blackColor,
                        //             fontWeight: FontWeight.w400,
                        //           ),
                        //         ),
                        //       ),
                        //       const Spacer(),
                        //       Image.asset('assets/images/down.png', height: 20),
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async{
                            AuthController.to.showdialog(
                              context,
                              picture: 8,
                            id: id
                            );

                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.greyTextColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/up.png', height: 20),
                                const SizedBox(width: 16),
                                Text(
                                  'Upload Design',
                                  style: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

void attendMeeting(String? meetingUrl) async {
  final Uri url = Uri.parse("$meetingUrl");
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class ViewDetailDialog extends StatelessWidget {
  const ViewDetailDialog({super.key, this.url, required this.image, required this.name, required this.location, required this.date, required this.time});
  final String image;
  final String name;
  final String location;
  final String date;
  final String time;
  final String? url;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.png'),
                radius: 24.0,
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name',
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    '$location',
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(color: AppColors.greyTextColor.withOpacity(0.2)),
          detailsText('Date Submitted', '$date'),
          const SizedBox(height: 16),
          detailsText('Category ', 'Online Consulting'),
          const SizedBox(height: 16),
          detailsText('Consult Timings', '$time'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: CommonButton(
                  text: 'cancel',
                  isBorder: true,
                  borderRadius: 8.0,
                  width: screenWidth * 0.38,
                  height: 35.0,
                ),
              ),
              InkWell(
                onTap: () {
                  attendMeeting(url);
                },
                child: CommonButton(
                  text: 'Join Meeting',
                  borderRadius: 8.0,
                  width: screenWidth * 0.38,
                  height: 35.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget detailsText(title, value) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.dmSans(
            textStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.dmSans(
            textStyle: const TextStyle(
              fontSize: 14,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
