import 'package:flutter/material.dart';
import 'package:aadaiz_seller/src/features/auth/ui/login/login.dart';
import 'package:aadaiz_seller/src/features/designer/ui/designer_login.dart';
import 'package:aadaiz_seller/src/features/designer/ui/forgot_password/forgot_otp.dart';
import 'package:aadaiz_seller/src/features/kyc/ui/kyc.dart';
import 'package:aadaiz_seller/src/features/seller/ui/dashboard.dart';
import 'package:aadaiz_seller/src/features/splash/ui/splash.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/dashboard/tailor_dashboard.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/kyc/tailor_kyc_screen.dart';
import 'package:aadaiz_seller/src/utils/routes/routes_name.dart';

import '../../features/designer/ui/designer_dashboard.dart';

class Routes{

  static Route<dynamic> generateRouteSettings(RouteSettings settings){

    switch(settings.name){

      case RoutesName.splashActivity:
        return MaterialPageRoute<Splash>(
            builder: (BuildContext context) => const Splash()
        );

      case RoutesName.loginActivity:
        return MaterialPageRoute<Login>(
            builder: (BuildContext context) => const Login()
        );



      case RoutesName.kycActivity:
        return MaterialPageRoute<Kyc>(
            builder: (BuildContext context) => const Kyc()
        );

      case RoutesName.homeActivity:
        return MaterialPageRoute<Dashboard>(
            builder: (BuildContext context) =>  Dashboard()
        );
      case RoutesName.tailorHome:
        return MaterialPageRoute<Dashboard>(
            builder: (BuildContext context) =>  TailorDashboard()
        );
      case RoutesName.tailorKYC:
        return MaterialPageRoute<Dashboard>(
            builder: (BuildContext context) => const TailorKycScreen()
        );
      case RoutesName.designerLogin:
        return MaterialPageRoute<Dashboard>(
            builder: (BuildContext context) => const DesignerLogin()
        );
      case RoutesName.designerHome:
        return MaterialPageRoute<Dashboard>(
            builder: (BuildContext context) => const DesignerDashboard()
        );


      default:
        return MaterialPageRoute<dynamic>(
            builder: (_){

              return const Scaffold(
                  body: Center(
                      child: Text(
                          'No route Found'
                      )
                  )
              );

            }
        );

    }

  }

}