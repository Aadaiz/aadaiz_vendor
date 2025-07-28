import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import '../../../../res/components/common_button.dart';
import '../../../../utils/utils.dart';
import '../../controller/designer_controller.dart';

class DesignerScheduled extends StatefulWidget {
  const DesignerScheduled({super.key});

  @override
  State<DesignerScheduled> createState() => _DesignerScheduledState();
}

class _DesignerScheduledState extends State<DesignerScheduled> {
  TextEditingController morStart = TextEditingController();
  TextEditingController morEnd = TextEditingController();
  TextEditingController evngStart = TextEditingController();
  TextEditingController evngEnd = TextEditingController();
  bool isChecked = false;
  String slotDate = '';
  String dayOfWeek = '';

  String _convertTo24Hour(String time12Hr) {
    try {
      final cleanedTime = time12Hr
          .replaceAll('\u202F', ' ') // narrow non-breaking space
          .replaceAll('\u00A0', ' ') // regular non-breaking space
          .replaceAll(RegExp(r'\s+'), ' ') // collapse multiple spaces
          .trim();

      final inputFormat = DateFormat.jm(); // handles 12-hour with AM/PM
      final parsedTime = inputFormat.parse(cleanedTime);

      return DateFormat('HH:mm:ss').format(parsedTime);
    } catch (e) {
      print("Time parse error: $e");
      return "00:00:00";
    }
  }

  int selected = 0;
  List days = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];

  String formatTimeOfDayTo24Hr(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dt = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    return DateFormat('HH:mm:ss').format(dt);
  }

  String morS = '';
  String morE = '';
  String evngS = '';
  String evngE = '';
  TimeOfDay? startTimePicked;
  TimeOfDay _startTime = TimeOfDay.now();
  Future<void> timePick(BuildContext context, int type) async {
    startTimePicked = (await showTimePicker(
      context: context,
      initialTime: _startTime,
      initialEntryMode: TimePickerEntryMode
          .dial, // Set to TimePickerEntryMode.dial for 24-hour format
    ))!;
    setState(() {
      _startTime = startTimePicked!;
      switch (type) {
        case 0:
          morStart.text = _startTime.format(context);
          morS = formatTimeOfDayTo24Hr(_startTime);
        case 1:
          morEnd.text = _startTime.format(context);
          morE = formatTimeOfDayTo24Hr(_startTime);
        case 2:
          evngStart.text = _startTime.format(context);
          evngS = formatTimeOfDayTo24Hr(_startTime);
        case 3:
          evngEnd.text = _startTime.format(context);
          evngE = formatTimeOfDayTo24Hr(_startTime);
        default:
          morStart.text = _startTime.format(context);
      }
    });
  }

  updateDates() {
    if (isChecked) {
      for (int i = 1; i <= 6; i++) {
        DesignerController.to.dayWiseTimeMap["$i"] = {
          "mor_start_time": morS,
          "mor_end_time": morE,
          "eve_start_time": evngS,
          "eve_end_time": evngE,
        };
      }
    } else {
      // Only update the selected day
      String selectedDay = (selected + 1).toString();
      DesignerController.to.dayWiseTimeMap[selectedDay] = {
        "mor_start_time": morS,
        "mor_end_time": morE,
        "eve_start_time": evngS,
        "eve_end_time": evngE,
      };
    }
  }
  String convertTo12HourFormat(String time24) {
    final time = TimeOfDay(
      hour: int.parse(time24.split(":")[0]),
      minute: int.parse(time24.split(":")[1]),
    );
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formattedTime = DateFormat.jm().format(dt); // e.g., "4:45 PM"
    return formattedTime;
  }


  updateFieldsByDayIndex(int index) {
    selected = index;
    final currentDay = index + 1;
    final match = DesignerController.to.scheduleList.firstWhereOrNull(
      (e) => e.dateOfWeek == currentDay,
    );
    if (match != null) {
      morStart.text =convertTo12HourFormat(match.morStartTime!);
      morEnd.text = convertTo12HourFormat(match.morEndTime!);
      evngStart.text = convertTo12HourFormat(match.eveStartTime!);
      evngEnd.text = convertTo12HourFormat(match.eveEndTime!);
      morS = match.morStartTime!;
      morE = match.morEndTime!;
      evngS = match.eveStartTime!;
      evngE = match.eveEndTime!;
    } else {
      morStart.clear();
      morEnd.clear();
      evngStart.clear();
      evngEnd.clear();
    }
  }

  void fetchData() async {
    await DesignerController.to.profile();
    updateFieldsByDayIndex(0);
  }

  @override
  void initState() {
    DesignerController.to.dayWiseTimeMap = {};
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.013),
          child: InkWell(
            onTap: () {
              DesignerController.to.tabSelected.value = 0;
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
          'Schedule',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Let’s Schedule Your',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor,
                        fontSize: 18,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: ' Comfortable',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackColor,
                            fontSize: 22,
                          ),
                        ),
                        TextSpan(
                          text: 'Timings!',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            color: Colors.orange,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Choose Date',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: days.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                            updateFieldsByDayIndex(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: selected != index
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.primaryColor),
                            ),
                            width: Get.width / 8.3,
                            alignment: Alignment.center,
                            child: Text(
                              days[index],
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: selected != index
                                    ? AppColors.primaryColor
                                    : AppColors.whiteColor,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 16);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Choose Timings',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Morning Start Time - End Time',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyTextColor.withOpacity(0.8),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.white,
                        height: 45.00,
                        width: Get.width * 0.4,
                        child: TextFormField(
                          readOnly: true,
                          cursorColor: Colors.black,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.015,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          controller: morStart,
                          onTap: () async {
                            await timePick(context, 0);
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: const Color(0xffC6C6C6).withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: const Color(0xffC6C6C6).withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            fillColor: const Color(0xffC6C6C6),
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                fontSize: 12.00,
                                color: Color(0xff6F6F6F),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                                left: 12,
                                right: 12,
                              ),
                              child: Icon(Icons.keyboard_arrow_down_rounded),
                            ),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 10,
                              bottom: 0,
                              top: MediaQuery.of(context).size.height * 0.025,
                              right: 0,
                            ),
                            labelText: 'Time',
                            labelStyle: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                fontSize: 12.00,
                                color: Color(0xff6F6F6F),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            hintText: 'Time',
                          ),
                          validator: (data) {
                            if (data == "" || data == null) {
                              return "Please choose the morning start time";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 45.00,
                        width: Get.width * 0.4,
                        child: TextFormField(
                          readOnly: true,
                          cursorColor: Colors.black,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.015,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          controller: morEnd,
                          onTap: () async {
                            await timePick(context, 1);
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: const Color(0xffC6C6C6).withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: const Color(0xffC6C6C6).withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            fillColor: const Color(0xffC6C6C6),
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff6F6F6F),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                                left: 12,
                                right: 12,
                              ),
                              child: Icon(Icons.keyboard_arrow_down_rounded),
                            ),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 10,
                              bottom: 0,
                              top: MediaQuery.of(context).size.height * 0.025,
                              right: 0,
                            ),
                            labelText: 'Time',
                            labelStyle: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff6F6F6F),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            hintText: 'Time',
                          ),
                          validator: (data) {
                            if (data == "" || data == null) {
                              return "Please choose the morning end time";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text(
                        'Evening Start Time - End Time',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyTextColor.withOpacity(0.8),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.white,
                        height: 45.00,
                        width: Get.width * 0.4,
                        child: TextFormField(
                          readOnly: true,
                          cursorColor: Colors.black,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.015,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          controller: evngStart,
                          onTap: () async {
                            await timePick(context, 2);
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: const Color(0xffC6C6C6).withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: const Color(0xffC6C6C6).withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            fillColor: const Color(0xffC6C6C6),
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                fontSize: 12.00,
                                color: Color(0xff6F6F6F),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                                left: 12,
                                right: 12,
                              ),
                              child: Icon(Icons.keyboard_arrow_down_rounded),
                            ),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 10,
                              bottom: 0,
                              top: MediaQuery.of(context).size.height * 0.025,
                              right: 0,
                            ),
                            labelText: 'Time',
                            labelStyle: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                fontSize: 12.00,
                                color: Color(0xff6F6F6F),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            hintText: 'Time',
                          ),
                          validator: (data) {
                            if (data == "" || data == null) {
                              return "Please choose the Evening start time";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 45.00,
                        width: Get.width * 0.4,
                        child: TextFormField(
                          readOnly: true,
                          cursorColor: Colors.black,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.015,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          controller: evngEnd,
                          onTap: () async {
                            await timePick(context, 3);
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: const Color(0xffC6C6C6).withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: const Color(0xffC6C6C6).withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            fillColor: const Color(0xffC6C6C6),
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff6F6F6F),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                                left: 12,
                                right: 12,
                              ),
                              child: Icon(Icons.keyboard_arrow_down_rounded),
                            ),
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 10,
                              bottom: 0,
                              top: MediaQuery.of(context).size.height * 0.025,
                              right: 0,
                            ),
                            labelText: 'Time',
                            labelStyle: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff6F6F6F),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            hintText: 'Time',
                          ),
                          validator: (data) {
                            if (data == "" || data == null) {
                              return "Please choose the evening end time";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: Container(
                          width: 16.0,
                          height: 16.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2.0,
                            ),
                            color: isChecked
                                ? AppColors.primaryColor
                                : Colors.transparent,
                          ),
                          child: isChecked
                              ? const Icon(
                                  Icons.check,
                                  size: 12.0,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Same as Everyday',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyTextColor.withOpacity(0.8),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  Utils.columnSpacer(height: screenHeight * 0.1),
                  InkWell(
                    onTap: () async {
                      await updateDates();
                      DesignerController.to.updateSchedule();
                    },
                    child: CommonButton(
                      text: 'Schedule Now',
                      borderRadius: 8.0,
                      width: screenWidth,
                      height: 40.0,
                      isLoading: DesignerController.to.scheduleLoading.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
