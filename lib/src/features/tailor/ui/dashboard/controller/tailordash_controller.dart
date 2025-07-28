
import 'package:aadaiz_seller/src/features/tailor/ui/dashboard/repository/tailordash_repository.dart';
import 'package:aadaiz_seller/src/features/tailor/ui/dashboard/model/tailordash_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';





class TailordashController extends GetxController{


  static TailordashController get to => Get.put(TailordashController(),permanent: true);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Gettailordashdata();
  }
  var isLoading = false.obs;
  var dashdata = Data().obs;
  var paymenthistorylist =<PaymentHistory>[].obs;
  var selectedPeriod = 'Last Week'.obs;

  final tailordashRepository repo = tailordashRepository();
  Gettailordashdata()async{
    try{
      isLoading(true);
      var response = await repo.TailordashApi();
      if(response.status==true){
        dashdata.value=response.data!;
        paymenthistorylist.assignAll(response.data!.paymentHistory!);
      }}catch(e){

    }finally{
      isLoading(false);
    }
  }



}