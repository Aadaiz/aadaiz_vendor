import 'package:flutter/cupertino.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/widgets/order_card.dart';
import 'package:get/state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../utils/utils.dart';
import 'controller/home_controller.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeController.to.getorderlist(isRefresh: true,type: 'shipping');
  }
  void onRefreshOrderApi() {
    HomeController.to.getorderlist(isRefresh: true,type: 'shipping');
  }

  void onLoadMoreOrderApi() {
    if (HomeController.to.currentPage.value < HomeController.to.lastPage.value) {
      HomeController.to.currentPage.value++;
      HomeController.to.getorderlist(isLoadMore: true,type: 'shipping');
    } else {
      HomeController.to.refreshControllerforShipping.loadNoData();
    }
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Obx(()=>
       SizedBox(
        height: screenHeight*0.702,
        child: SmartRefresher(
                controller: HomeController.to.refreshControllerforShipping,
        enablePullDown: true,
        enablePullUp: HomeController.to.nextPageUrl.value.isNotEmpty,
        onRefresh: onRefreshOrderApi,
        onLoading: onLoadMoreOrderApi,
        child:
        HomeController.to.isLoading.value
            ? Utils.carshimmer(lenght: 6)
            : HomeController.to.orderlist.isEmpty?

        Center(
          child: Image.asset('assets/dashboard/empty.png',
            height:screenHeight*0.4,
          ),
        ):
         ListView.builder(
              shrinkWrap: true,
              itemCount: HomeController.to.orderlist.length,
              padding: const EdgeInsets.only(bottom: 50),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context,int index){
                final data = HomeController.to.orderlist[index];
                return   OrderCard(buttonText1: 'Cancel', buttonText2: 'Confirm Shipment',type: 1,data: data,);
              }),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // HomeController.to.refreshControllerforShipping.dispose();
    super.dispose();
  }
}
