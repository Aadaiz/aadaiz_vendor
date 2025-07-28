import 'package:aadaiz_seller/src/features/seller/ui/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/widgets/order_card.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../utils/utils.dart';


class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeController.to.getorderlist(isRefresh: true,type: 'placed');
  }
  void onRefreshOrderApi() {
    HomeController.to.getorderlist(isRefresh: true,type: 'placed');
  }

  void onLoadMoreOrderApi() {
    if (HomeController.to.currentPage.value < HomeController.to.lastPage.value) {
      HomeController.to.currentPage.value++;
      HomeController.to.getorderlist(isLoadMore: true,type: 'placed');
    } else {
      HomeController.to.refreshControllerfororders.loadNoData();
    }
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return  Obx(()=>
     SizedBox(
        height: screenHeight*0.702,
        child: SmartRefresher(
          controller: HomeController.to.refreshControllerfororders,
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
                return   OrderCard(buttonText1: 'Cancel Order', buttonText2: 'Process Order',type: 0,data:data);
              }),
        ),
      ),
    );
  }
  @override
  void dispose() {
   // HomeController.to.refreshControllerfororders.dispose();
    super.dispose();
  }
}
