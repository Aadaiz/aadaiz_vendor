import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';

class PaymentHistoryItem extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final String imageUrl;

  const PaymentHistoryItem({super.key, 
    required this.title,
    required this.date,
    required this.amount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2.0,
            spreadRadius: 0.5
          ),
        ],
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundImage: imageProvider,
              radius: 24.0,
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.dmSans(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.calendar_month,size: 15,
                    color: AppColors.greyTextColor.withOpacity(0.5),),
                    const SizedBox(width: 4,),
                    Text(
                      date,
                      style: GoogleFonts.dmSans(
                        fontSize: 10.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.aBeeZee(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}