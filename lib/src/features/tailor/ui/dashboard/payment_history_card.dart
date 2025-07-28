import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String dateTime; // e.g., "Mar 24, 2024 11:15 AM"
  final dynamic amount;

  const TransactionTile({
    super.key,
    required this.title,
    required this.dateTime,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Circle avatar with first letter
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFFFE4E1), // light pink
            child: Text(
              title[0].toUpperCase(),
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                color: Colors.brown,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Title and DateTime
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.capitalizeFirst.toString(),
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      dateTime,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Amount
          Text(
            "+₹${amount.toStringAsFixed(2)}",
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
