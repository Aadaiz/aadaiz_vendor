import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Future<dynamic>.delayed(const Duration(seconds: 2), ()=> AuthController.to.checkLoginStatus(context));

  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SizedBox(
          width: screenWidth / 1.8,
          child: Image.asset(
            'assets/images/aadaiz_logo.png'
          )
        )
      )
    );

  }

}