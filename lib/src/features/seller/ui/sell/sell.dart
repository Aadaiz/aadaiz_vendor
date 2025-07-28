import 'package:flutter/material.dart';
import 'package:aadaiz_seller/src/features/seller/ui/sell/add_catalogue.dart';

import '../../../../res/colors/app_colors.dart';
import '../home/selling.dart';

class Sell extends StatefulWidget {
  const Sell({super.key});

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Selling(height: screenHeight*0.88,),

        ],
      ),
      floatingActionButton: InkWell(
        onTap: (){
          addCatalogueBottomSheet();
        },
        child: const Icon(Icons.add_circle_rounded,
          size: 40,
          color: AppColors.primaryColor,),
      ),
    );
  }

  void addCatalogueBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: AppColors.whiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return  const AddCatalogue(
          ); // returns your BottomSheet widget
        });
  }
}
