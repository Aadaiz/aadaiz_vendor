import 'package:country_state_city/utils/state_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/res/components/widgets/overlay_widgets.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

import '../../../utils/form_validation.dart';

class Shipping extends StatefulWidget {
  const Shipping({super.key});

  @override
  State<Shipping> createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {

  final FocusNode _streetFocus = FocusNode();
  final FocusNode _pinCodeFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _landmarkFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final List<String> _ddList = <String>['TamilNadu', 'Karnataka'];
  List states = [];
  bool isState = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
       states = await getStatesOfCountry('AF');
    });
  }

  @override
  void dispose() {
    _streetFocus.dispose();
    _pinCodeFocus.dispose();
    _cityFocus.dispose();
    _landmarkFocus.dispose();
    _stateFocus.dispose();

  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () async {
      states = await getStatesOfCountry('IN');
    });
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    ScreenUtil.init(context);

    return Column(
      children: <Widget>[
        OverlayWidgets.fullWidthTextField(
            label: Text(
                'Locality / Street',
                style: GoogleFonts.inter(
                    color: AppColors.blackColor
                )
            ),
            child: SizedBox(
                height: screenHeight * 0.05,
                child: TextFormField(
                    focusNode: _streetFocus,
                    controller: AuthController.to.street,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        hintText: 'Enter Your address here',
                        hintStyle: GoogleFonts.inter(
                            color: AppColors.hintTextColor,
                            fontSize: 12.sp
                        ),
                        fillColor: AppColors.whiteColor,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColors.textFieldBorderColor
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColors.textFieldBorderColor
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColors.textFieldBorderColor
                            )
                        )
                    ),
                    onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                        context: context,
                        currentFocus: _streetFocus,
                        nextFocus: _pinCodeFocus
                    )
                )
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: screenWidth*0.3,
              child: OverlayWidgets.fullWidthTextField(
                  label: Text(
                      'PinCode',
                      style: GoogleFonts.inter(
                          color: AppColors.blackColor
                      )
                  ),
                  child: SizedBox(
                      height: screenHeight * 0.05,
                      child: TextFormField(

                          focusNode: _pinCodeFocus,
                          controller: AuthController.to.pinCode,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [LengthLimitingTextInputFormatter(6),FormValidation.allowedIntegers,
                            FormValidation.ignoreDots],
                          decoration: InputDecoration(
                              hintText: 'PinCode',
                              hintStyle: GoogleFonts.inter(
                                  color: AppColors.hintTextColor,
                                  fontSize: 12.sp
                              ),
                              fillColor: AppColors.whiteColor,
                              filled: true,

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.textFieldBorderColor
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.textFieldBorderColor
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.textFieldBorderColor
                                  )
                              )
                          ),
                          onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                              context: context,
                              currentFocus: _pinCodeFocus,
                              nextFocus: _cityFocus
                          )
                      )
                  )
              )
            ),
            SizedBox(
                width: screenWidth*0.3,
              child: OverlayWidgets.fullWidthTextField(
                  label: Text(
                      'City',
                      style: GoogleFonts.inter(
                          color: AppColors.blackColor
                      )
                  ),
                  child: SizedBox(
                      height: screenHeight * 0.05,
                      child: TextFormField(
                          focusNode: _cityFocus,
                          controller: AuthController.to.city,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              hintText: 'City',
                              hintStyle: GoogleFonts.inter(
                                  color: AppColors.hintTextColor,
                                  fontSize: 12.sp
                              ),
                              fillColor: AppColors.whiteColor,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.textFieldBorderColor
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.textFieldBorderColor
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.textFieldBorderColor
                                  )
                              )
                          ),
                          onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                              context: context,
                              currentFocus: _cityFocus,
                              nextFocus: _landmarkFocus
                          )
                      )
                  )
              )
            ),
            SizedBox(
                width: screenWidth*0.3,
              child: OverlayWidgets.fullWidthTextField(
                  label: Text(
                      'Landmark',
                      style: GoogleFonts.inter(
                          color: AppColors.blackColor
                      )
                  ),
                  child: SizedBox(
                      height: screenHeight * 0.05,
                      child: TextFormField(
                          focusNode: _landmarkFocus,
                          controller: AuthController.to.landMark,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              hintText:  'Landmark',
                              hintStyle: GoogleFonts.inter(
                                  color: AppColors.hintTextColor,
                                  fontSize: 12.sp
                              ),
                              fillColor: AppColors.whiteColor,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.textFieldBorderColor
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.textFieldBorderColor
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.textFieldBorderColor
                                  )
                              )
                          ),
                          onFieldSubmitted: (String val) => Utils.fieldFocusChange(
                              context: context,
                              currentFocus: _landmarkFocus,
                              nextFocus: _stateFocus
                          )
                      )
                  )
              )
            )
          ]
        ),
        OverlayWidgets.fullWidthTextField(
            label: Text(
                'State',
                style: GoogleFonts.inter(
                    color: AppColors.blackColor
                )
            ),
            child: InkWell(

              child: SizedBox(
                  height: screenHeight * 0.05,
                  child: TextFormField(
                    onTap: (){
                      setState(() {
                        isState=!isState;
                      });
                      print('adfada');
                    },
                    readOnly: true,
                      focusNode: _stateFocus,
                      controller:  AuthController.to.state,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.keyboard_arrow_down,size: 25,color: AppColors.primaryColor,),
                          hintText: 'State',
                          hintStyle: GoogleFonts.inter(
                              color: AppColors.hintTextColor,
                              fontSize: 12.sp
                          ),
                          fillColor: AppColors.whiteColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldBorderColor
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldBorderColor
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldBorderColor
                              )
                          )
                      ),
                  )
              ),
            )
        ),
        isState?
            Container(
              width: screenWidth*0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey)
              ),
              child: ListView.separated(
                separatorBuilder: (context,index)=>Divider(),
                shrinkWrap: true,
                  itemCount: states.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                  itemBuilder: (context,index){
                  var data = states[index];
              return  InkWell(
                onTap: (){
                  setState(() {
                    isState=!isState;
                  });
                  AuthController.to.state.text = data.name??'';
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('${data.name??''}',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 14.00.sp,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w400
                          )
                      )),
                ),
              );
              }),
            )
            :const SizedBox()
      ]
    );

  }

}