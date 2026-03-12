import 'dart:developer';

import 'package:aadaiz_seller/src/features/seller/ui/dashboard/model/sellerdash_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../repository/sellerdash_repository.dart';

class SellerDashController extends GetxController {
  static SellerDashController get to => Get.put(SellerDashController(), permanent: true);

  @override
  void onInit() {
    super.onInit();
    getDashData(filter: 'this_week');
  }

  var isLoading = false.obs;
  var dashData = SellerDashRes().obs;
  var selectedPeriod = 'This Week'.obs;
  final DashRepository repo = DashRepository();

  getDashData({String filter = 'this_week'}) async {
    try {
      isLoading(true);
      var response = await repo.sellerDashApi(filter);
      if (response.status == true) {
        dashData.value = response;
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
