import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/components/common_toast.dart';
import '../../res/components/loading_button.dart';
import '../../utils/utils.dart';
import '../seller/ui/dashboard.dart';
import '../tailor/ui/dashboard/tailor_dashboard.dart';

class KYCPendingScreen extends StatefulWidget {
  final String type;
  const KYCPendingScreen({super.key, required this.type});

  static const Color primaryColor = Color(0xFF0C1855);
  static const Color starColor = Color(0xFFF71C1C);
  static const Color whiteColor = Color(0xFFFFFFFF);

  @override
  State<KYCPendingScreen> createState() => _KYCPendingScreenState();
}

class _KYCPendingScreenState extends State<KYCPendingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStatus();
  }

  checkStatus() async {
    await AuthController.to.checkKycStatus();
    if (AuthController.to.kycStatus.value == 1) {
      widget.type == 'seller'
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Dashboard()),
            )
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TailorDashboard()),
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Scaffold(
      backgroundColor: KYCPendingScreen.primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: KYCPendingScreen.whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: KYCPendingScreen.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified_user,
                    color: KYCPendingScreen.whiteColor,
                    size: 40,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "KYC Verification",
                  style: GoogleFonts.dmSans(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: KYCPendingScreen.primaryColor,
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  "Under Review",
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: KYCPendingScreen.starColor,
                  ),
                ),

                const SizedBox(height: 15),

                /// DESCRIPTION
                Text(
                  "Your documents are submitted successfully.\nOur team is reviewing your KYC.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 25),
                Obx(
                  () => LoadingButton(
                    loading: AuthController.to.kycStatusLoading.value,
                    title: 'Check Status',
                    onPressed: () async {
                      await AuthController.to.checkKycStatus();
                      if (AuthController.to.kycStatus.value == 1) {
                        await CommonToast.show(
                          msg: AuthController.to.kycStatusMessage.value,
                        );
                        widget.type == 'seller'
                            ? Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(),
                                ),
                              )
                            : Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => TailorDashboard(),
                                ),
                              );
                      } else {
                        CommonToast.show(
                          msg: AuthController.to.kycStatusMessage.value,
                        );
                      }
                    },

                    btnWidth: screenWidth / 1.2,
                    btnHeight: screenHeight * 0.05,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Usually takes 1-2 business days",
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
