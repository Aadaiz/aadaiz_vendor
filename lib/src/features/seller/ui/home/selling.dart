import 'package:aadaiz_seller/src/features/seller/ui/home/controller/home_controller.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/widgets/product_card_approve.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/widgets/product_card.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Selling extends StatefulWidget {
  const Selling({super.key, this.height});
  final dynamic height;

  @override
  State<Selling> createState() => _SellingState();
}

class _SellingState extends State<Selling> {

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Obx(() =>
        SizedBox(
          height: widget.height ?? screenHeight * 0.702,
          child: SmartRefresher(
            controller: HomeController.to.refreshController,
            enablePullDown: true,
            enablePullUp: HomeController.to.nextPageUrl.value.isNotEmpty,
            onRefresh: HomeController.to.onRefresh,
            onLoading: HomeController.to.onLoadMore,
            child: HomeController.to.isLoading.value
                ? Utils.carshimmer(lenght: 6)
                : HomeController.to.productlist.isEmpty
                ? Center(
              child: Image.asset(
                'assets/dashboard/empty.png',
                height: screenHeight * 0.4,
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              itemCount: HomeController.to.productlist.length,
              itemBuilder: (BuildContext context, int index) {
                final data = HomeController.to.productlist[index];
                return data.status == 'approved'||data.status=='Approve'
                    ? CommonCardWidget(data: data)
                    : ProductCard(data: data);
              },
            ),
          ),
        ),
    );
  }

}
