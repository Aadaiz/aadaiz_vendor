import 'package:aadaiz_seller/src/features/tailor/controller/tailor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import '../../../../res/components/common_button.dart';
import '../../../../res/components/common_toast.dart';
import '../../../../res/components/widgets/custom_appbar.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  bool _isLoading = false; // Track loading state
  bool _isLocationFetched = false; // Track if location was successfully fetched

  bool _validateFields() {
    if (TailorController.to.no.text.isEmpty) {
      CommonToast.show(msg: "Please enter House number");
      return false;
    }
    if (TailorController.to.st.text.isEmpty) {
      CommonToast.show(msg: "Please enter street");
      return false;
    }
    if (TailorController.to.pin.text.isEmpty) {
      CommonToast.show(msg: "Please enter pin");
      return false;
    }
    if (TailorController.to.city.text.isEmpty) {
      CommonToast.show(msg: "Please enter city");
      return false;
    }
    if (TailorController.to.land.text.isEmpty) {
      CommonToast.show(msg: "Please enter landmark");
      return false;
    }
    return true;
  }

  // Function to handle location fetching and field population
  Future<void> _useCurrentLocation() async {
    setState(() {
      _isLoading = true; // Start loading
      _isLocationFetched = false; // Reset success state
    });

    try {
      // Check and request location permission
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        CommonToast.show(msg: "Location services are disabled.");
        setState(() {
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          CommonToast.show(msg: "Location permission denied.");
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        CommonToast.show(msg: "Location permission permanently denied.");
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Update latitude and longitude in TailorController
      TailorController.to.latitude.value = position.latitude;
      TailorController.to.longitude.value = position.longitude;

      // Reverse geocoding to get address details
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String? houseNumber;
        RegExp regExp = RegExp(r'^(\d+)');
        Match? match = regExp.firstMatch(placemark.street ?? '');
        if (match != null) {
          houseNumber = match.group(1);
        } else {
          match = regExp.firstMatch(placemark.name ?? '');
          if (match != null) {
            houseNumber = match.group(1);
          }
        }

        // Populate the text fields with address details
        TailorController.to.no.text = houseNumber ?? '';
        TailorController.to.st.text = placemark.subLocality ?? '';
        TailorController.to.pin.text = placemark.postalCode ?? '';
        TailorController.to.city.text = placemark.locality ?? '';
        TailorController.to.land.text = placemark.street ?? '';

        setState(() {
          _isLocationFetched = true; // Mark location as fetched
        });
      } else {
        CommonToast.show(msg: "Unable to fetch address details.");
      }
    } catch (e) {
      CommonToast.show(msg: "Error fetching location: $e");
      print('error : ${e.toString()}')
;    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30,
            color: AppColors.primaryColor,
          ),
        ),
        title: Text(
          'Address',
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),

        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              width: screenWidth * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: TailorController.to.no,
                    decoration: InputDecoration(
                      labelText: 'House No',
                      labelStyle: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: TailorController.to.st,
                    decoration: InputDecoration(
                      labelText: 'Street, Area',
                      labelStyle: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    maxLength: 6,
                    keyboardType: TextInputType.phone,
                    controller: TailorController.to.pin,
                    decoration: InputDecoration(

                      labelText: 'Pincode',
                      labelStyle: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: TailorController.to.city,
                    decoration: InputDecoration(
                      labelText: 'City',
                      labelStyle: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: TailorController.to.land,
                    decoration: InputDecoration(
                      labelText: 'Landmark',
                      labelStyle: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text("( Or )", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _isLoading ? null : _useCurrentLocation, // Disable tap during loading
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.greyTextColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _isLoading
                              ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.blackColor,
                            ),
                          )
                              : const Icon(Icons.my_location, color: Colors.black),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              Text(
                                'Use My Current Location',
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              if (_isLocationFetched) ...[
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 24,
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                if (_validateFields()) {
                  Get.back();
                }
              },
              child: CommonButton(
                text: 'Continue',
                borderRadius: 8.0,
                width: screenWidth * 0.9,
                height: 50.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}