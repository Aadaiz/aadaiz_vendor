import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';

class CommonHistoryItem extends StatelessWidget {
  final String title;
  final String? message;
  final String date;
  final String? amount;
  final IconData icon;
  final Color? amountColor;
  final bool? isNotification;


  const CommonHistoryItem({
    super.key,
    required this.title,
    this.message,
    required this.date,
    this.amount,
    this.icon = Icons.notifications,
    this.amountColor,
    this.isNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            child: Icon(icon),
          ),

          const SizedBox(width: 12),

          /// Title + Message
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                if (message != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    message!,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],

                const SizedBox(height: 4),
if(isNotification==false)
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 14,
                      color: AppColors.greyTextColor.withOpacity(0.5),
                    ),
                    const SizedBox(width: 4),

                    Text(
                      date,
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Amount OR Date (Right Side)
          if (amount != null)
            Text(
              amount!,
              style: GoogleFonts.aBeeZee(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: amountColor ?? Colors.green,
              ),
            )
          else
            Text(
              date,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}