import 'package:aadaiz_seller/src/features/seller/ui/profile/model/support_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../res/colors/app_colors.dart';

class SupportCart extends StatefulWidget {
  final Datum data;
 const  SupportCart({super.key, required this.data});

  @override
  State<SupportCart> createState() => _SupportCartState();
}

class _SupportCartState extends State<SupportCart> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return  Container(
      width: screenWidth*0.9,
      padding: const EdgeInsets.all(8),
      decoration:
      BoxDecoration(color: AppColors.whiteColor,
          borderRadius:BorderRadius.circular(4),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppColors.blackColor.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Text('Ticket Number',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                    fontSize : 12
                ),
              ),
              const SizedBox(width: 10,),
              Text('#${widget.data.ticketNumber}',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyTextColor.withOpacity(0.8),
                    fontSize : 10
                ),),
               const Spacer(),
              Text(widget.data.createdAt.toString(), style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                  fontSize : 12
              ),)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.data.title??'',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                      fontSize : 15
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(widget.data.description??'',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyTextColor.withOpacity(0.8),
                            fontSize : 13
                        ),),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.greyTextColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.all(4.0),
                          child: Text(widget.data.status??'',
                            style: GoogleFonts.dmSans(
                              color: AppColors.whiteColor,
                              fontSize: 12
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
