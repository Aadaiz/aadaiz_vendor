import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/res/components/widgets/overlay_widgets.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/controller/location_controller.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/model/location_model.dart';

import '../../../utils/form_validation.dart';

class Shipping extends StatefulWidget {
  const Shipping({super.key});

  @override
  State<Shipping> createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  final LocationController locationController = LocationController.to;
  final AuthController authController = Get.find<AuthController>();

  final FocusNode _streetFocus = FocusNode();
  final FocusNode _pinCodeFocus = FocusNode();
  final FocusNode _landmarkFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();

  // Use separate GlobalKeys for dropdowns to prevent tap issues
  final GlobalKey _countryDropdownKey = GlobalKey();
  final GlobalKey _stateDropdownKey = GlobalKey();
  final GlobalKey _cityDropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Optional: Set default country after data loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndSetDefaultCountry();
    });
  }

  void _checkAndSetDefaultCountry() {
    // You can set a default country if needed
    Future.delayed(Duration(seconds: 1), () {
      if (locationController.countries.isNotEmpty) {
        // Find India in the list
        final india = locationController.countries.firstWhere(
              (country) => country.name?.toLowerCase() == 'india',
          orElse: () => Datum(),
        );
        if (india.id != null) {
          locationController.setSelectedCountry(india);
        }
      }
    });
  }

  @override
  void dispose() {
    _streetFocus.dispose();
    _pinCodeFocus.dispose();
    _landmarkFocus.dispose();
    _stateFocus.dispose();
    _countryFocus.dispose();
    _cityFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    ScreenUtil.init(context);

    return Column(
      children: <Widget>[
        // Country Dropdown Field
        GestureDetector(

          child: OverlayWidgets.fullWidthTextField(
            label: Text(
              'Country',
              style: GoogleFonts.inter(color: AppColors.blackColor),
            ),
            child: SizedBox(
              height: screenHeight * 0.05,
              child: Obx(() => TextFormField(
                controller: TextEditingController(
                  text: locationController.selectedCountry.value?.name ?? '',
                ),
                focusNode: _countryFocus,
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    key: _countryDropdownKey,
                    onTap: () {
                      setState(() {
                        locationController.isCountryDropdownOpen.value =
                        !locationController.isCountryDropdownOpen.value;
                        if (locationController.isCountryDropdownOpen.value) {
                          locationController.isStateDropdownOpen.value = false;
                          locationController.isCityDropdownOpen.value = false;
                        }
                      });
                    },
                    child: Icon(
                      locationController.isCountryDropdownOpen.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 25,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  hintText: 'Select Country',
                  hintStyle: GoogleFonts.inter(
                    color: AppColors.hintTextColor,
                    fontSize: 12.sp,
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
              )),
            ),
          ),
        ),
        const SizedBox(height: 4),

        // Country Dropdown List
        Obx(() => locationController.isCountryDropdownOpen.value
            ? _buildDropdownList(
          screenWidth,
          locationController.countries,
          locationController.isLoadingCountries,
          'No countries found',
              (Datum country) {
            locationController.setSelectedCountry(country);
            locationController.isCountryDropdownOpen.value = false;
            authController.country.text = country.name ?? '';
          },
        )
            : const SizedBox.shrink(),
        ),

        const SizedBox(height: 8),

        // State Dropdown Field
        GestureDetector(

          child: OverlayWidgets.fullWidthTextField(
            label: Text(
              'State',
              style: GoogleFonts.inter(color: AppColors.blackColor),
            ),
            child: SizedBox(
              height: screenHeight * 0.05,
              child: Obx(() => TextFormField(
                controller: TextEditingController(
                  text: locationController.selectedState.value?.name ?? '',
                ),
                focusNode: _stateFocus,
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    key: _stateDropdownKey,
                    onTap: () {
                      if (locationController.selectedCountry.value != null) {
                        setState(() {
                          locationController.isStateDropdownOpen.value =
                          !locationController.isStateDropdownOpen.value;
                          if (locationController.isStateDropdownOpen.value) {
                            locationController.isCountryDropdownOpen.value = false;
                            locationController.isCityDropdownOpen.value = false;
                          }
                        });
                      }
                    },
                    child: Icon(
                      locationController.isStateDropdownOpen.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 25,
                      color: locationController.selectedCountry.value != null
                          ? AppColors.primaryColor
                          : AppColors.greyColor,
                    ),
                  ),
                  hintText: locationController.selectedCountry.value != null
                      ? 'Select State'
                      : 'Select Country First',
                  hintStyle: GoogleFonts.inter(
                    color: AppColors.hintTextColor,
                    fontSize: 12.sp,
                  ),
                  fillColor: locationController.selectedCountry.value != null
                      ? AppColors.whiteColor
                      : AppColors.greyColor.withOpacity(0.3),
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
              )),
            ),
          ),
        ),
        const SizedBox(height: 4),

        // State Dropdown List
        Obx(() => locationController.isStateDropdownOpen.value
            ? _buildDropdownList(
          screenWidth,
          locationController.states,
          locationController.isLoadingStates,
          'No states found',
              (Datum state) {
            locationController.setSelectedState(state);
            locationController.isStateDropdownOpen.value = false;
            authController.state.text = state.name ?? '';
          },
        )
            : const SizedBox.shrink(),
        ),

        const SizedBox(height: 8),

        // City Dropdown Field
        GestureDetector(

          child: OverlayWidgets.fullWidthTextField(
            label: Text(
              'City',
              style: GoogleFonts.inter(color: AppColors.blackColor),
            ),
            child: SizedBox(
              height: screenHeight * 0.05,
              child: Obx(() => TextFormField(

                controller: TextEditingController(
                  text: locationController.selectedCity.value?.name ?? '',
                ),
                focusNode: _cityFocus,
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    key: _cityDropdownKey,
                    onTap: () {
                      if (locationController.selectedState.value != null) {
                        setState(() {
                          locationController.isCityDropdownOpen.value =
                          !locationController.isCityDropdownOpen.value;
                          if (locationController.isCityDropdownOpen.value) {
                            locationController.isCountryDropdownOpen.value = false;
                            locationController.isStateDropdownOpen.value = false;
                          }
                        });
                      }
                    },
                    child: Icon(
                      locationController.isCityDropdownOpen.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 25,
                      color: locationController.selectedState.value != null
                          ? AppColors.primaryColor
                          : AppColors.greyColor,
                    ),
                  ),
                  hintText: locationController.selectedState.value != null
                      ? 'Select City'
                      : 'Select State First',
                  hintStyle: GoogleFonts.inter(
                    color: AppColors.hintTextColor,
                    fontSize: 12.sp,
                  ),
                  fillColor: locationController.selectedState.value != null
                      ? AppColors.whiteColor
                      : AppColors.greyColor.withOpacity(0.3),
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
                onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                  context: context,
                  currentFocus: _cityFocus,
                  nextFocus: _streetFocus,
                ),
              )),
            ),
          ),
        ),
        const SizedBox(height: 4),

        // City Dropdown List
        Obx(() => locationController.isCityDropdownOpen.value
            ? _buildDropdownList(
          screenWidth,
          locationController.cities,
          locationController.isLoadingCities,
          'No cities found',
              (Datum city) {
            locationController.setSelectedCity(city);
            locationController.isCityDropdownOpen.value = false;
            authController.city.text = city.name ?? '';
          },
        )
            : const SizedBox.shrink(),
        ),

        const SizedBox(height: 8),

        // Street/Address Field
        OverlayWidgets.fullWidthTextField(
          label: Text(
            'Locality / Street',
            style: GoogleFonts.inter(color: AppColors.blackColor),
          ),
          child: SizedBox(
            height: screenHeight * 0.05,
            child: TextFormField(
              focusNode: _streetFocus,
              controller: authController.street,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Ex. 3/105 ,Middle Street',
                hintStyle: GoogleFonts.inter(
                  color: AppColors.hintTextColor,
                  fontSize: 12.sp,
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
              onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                context: context,
                currentFocus: _streetFocus,
                nextFocus: _pinCodeFocus,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // PinCode Field
            SizedBox(
              width: screenWidth * 0.3,
              child: OverlayWidgets.fullWidthTextField(
                label: Text(
                  'PinCode',
                  style: GoogleFonts.inter(color: AppColors.blackColor),
                ),
                child: SizedBox(
                  height: screenHeight * 0.05,
                  child: TextFormField(
                    focusNode: _pinCodeFocus,
                    controller: authController.pinCode,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      FormValidation.allowedIntegers,
                      FormValidation.ignoreDots,
                    ],
                    decoration: InputDecoration(
                      hintText: 'PinCode',
                      hintStyle: GoogleFonts.inter(
                        color: AppColors.hintTextColor,
                        fontSize: 12.sp,
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
                    onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                      context: context,
                      currentFocus: _pinCodeFocus,
                      nextFocus: _landmarkFocus,
                    ),
                  ),
                ),
              ),
            ),

            // Landmark Field
            SizedBox(
              width: screenWidth * 0.3,
              child: OverlayWidgets.fullWidthTextField(
                label: Text(
                  'Landmark',
                  style: GoogleFonts.inter(color: AppColors.blackColor),
                ),
                child: SizedBox(
                  height: screenHeight * 0.05,
                  child: TextFormField(
                    focusNode: _landmarkFocus,
                    controller: authController.landMark,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'Landmark',
                      hintStyle: GoogleFonts.inter(
                        color: AppColors.hintTextColor,
                        fontSize: 12.sp,
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
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Helper method to build dropdown lists
  Widget _buildDropdownList(
      double screenWidth,
      RxList<Datum> items,
      RxBool isLoading,
      String emptyMessage,
      Function(Datum) onItemSelected,
      ) {
    return Container(
      width: screenWidth * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      child: isLoading.value
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        ),
      )
          : items.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            emptyMessage,
            style: GoogleFonts.inter(
              color: AppColors.hintTextColor,
              fontSize: 14.sp,
            ),
          ),
        ),
      )
          : Obx(() => ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () {
              onItemSelected(item);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                border: index < items.length - 1
                    ? Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                )
                    : null,
              ),
              child: Text(
                item.name ?? 'Unnamed',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 14.00.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}