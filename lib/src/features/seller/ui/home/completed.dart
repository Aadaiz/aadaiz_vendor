import 'package:flutter/cupertino.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/widgets/order_card.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../utils/utils.dart';
import 'controller/home_controller.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeController.to.getorderlist(isRefresh: true,type: 'completed');
  }
  void onRefreshOrderApi() {
    HomeController.to.getorderlist(isRefresh: true,type: 'completed');
  }

  void onLoadMoreOrderApi() {
    if (HomeController.to.currentPage.value < HomeController.to.lastPage.value) {
      HomeController.to.currentPage.value++;
      HomeController.to.getorderlist(isLoadMore: true,type: 'completed');
    } else {
      HomeController.to.refreshControllerforCompleted.loadNoData();
    }
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Obx(()=>
 SizedBox(
        height: screenHeight*0.702,
        child: SmartRefresher(
          controller: HomeController.to.refreshControllerforCompleted,
          enablePullDown: true,
          enablePullUp: HomeController.to.nextPageUrl.value.isNotEmpty,
          onRefresh: onRefreshOrderApi,
          onLoading: onLoadMoreOrderApi,
          child:  HomeController.to.isLoading.value
              ? Utils.carshimmer(lenght: 6)
              : HomeController.to.orderlist.isEmpty?

          Center(
            child: Image.asset('assets/dashboard/empty.png',
              height:screenHeight*0.4,
            ),
          ): ListView.builder(
              shrinkWrap: true,
              itemCount: HomeController.to.orderlist.length,
              padding: const EdgeInsets.only(bottom: 50),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context,int index){
                final data = HomeController.to.orderlist[index];
                return   OrderCard(buttonText1: '', buttonText2: 'Completed',type: 4,data: data,);
              }),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // HomeController.to.refreshControllerforCompleted.dispose();
    super.dispose();
  }
}
