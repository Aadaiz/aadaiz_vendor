import 'package:aadaiz_seller/src/features/seller/ui/dashboard/model/sellerdash_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../repository/sellerdash_repository.dart';



class SellerdashController extends GetxController{


  static SellerdashController get to => Get.put(SellerdashController(),permanent: true);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Getdashdata();
  }
  var isLoading = false.obs;
  var dashdata = Data().obs;
  var selectedPeriod = 'Last Week'.obs;

  final dashRepository repo = dashRepository();
  Getdashdata()async{
    try{
      isLoading(true);
    var response = await repo.SellerdashApi();
    if(response.status==true){
      dashdata.value=response.data!;
    }}catch(e){

    }finally{
      isLoading(false);
    }
  }



}