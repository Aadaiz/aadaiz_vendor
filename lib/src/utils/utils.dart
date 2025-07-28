import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Utils {
  static double getActivityScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getActivityScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static void fieldFocusChange({
    required BuildContext context,
    required FocusNode currentFocus,
    required FocusNode nextFocus,
  }) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static Widget rowSpacer({required double width}) {
    return SizedBox(width: width);
  }

  static Widget columnSpacer({required double height}) {
    return SizedBox(height: height);
  }

  static Widget carshimmer({required int lenght}) {
    return ListView.builder(
      itemCount: lenght,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: 12, width: double.infinity, color: Colors.white),
                          const SizedBox(height: 8),
                          Container(height: 12, width: 150, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  static Widget shimmer({required int lenght}) {
    return ListView.builder(
      itemCount: lenght,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: 12, width: double.infinity, color: Colors.white),
                          const SizedBox(height: 8),
                          Container(height: 12, width: 150, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
