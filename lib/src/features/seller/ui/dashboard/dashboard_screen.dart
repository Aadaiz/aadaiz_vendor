import 'dart:developer';

import 'package:aadaiz_seller/src/features/seller/ui/dashboard/controller/sellerdash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_seller/src/res/colors/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../utils/utils.dart';
import '../home/controller/home_controller.dart';
import 'model/sellerdash_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteDimColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.013),
          child: InkWell(
            onTap: () {
              HomeController.to.setTab(0);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: AppColors.blackColor,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Dashboard',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
            fontSize: 20,
          ),
        ),
      ),
      body: Obx(
        () => SellerDashController.to.isLoading.value
            ? Utils.shimmer(lenght: 15)
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.15,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 6,
                                ),
                                child: revenueCard(
                                  width: screenWidth * 0.6,
                                  height: screenHeight * 0.1,
                                  title: 'Revenue',
                                  percentage: '',
                                  amount: SellerDashController
                                      .to
                                      .dashData
                                      .value
                                      .revenue,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 6,
                                ),
                                child: revenueCard(
                                  width: screenWidth * 0.6,
                                  height: screenHeight * 0.1,
                                  title: 'Product Sold',
                                  percentage: '',
                                  amount: SellerDashController
                                      .to
                                      .dashData
                                      .value
                                      .productSold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 6,
                                ),
                                child: revenueCard(
                                  width: screenWidth * 0.6,
                                  height: screenHeight * 0.1,
                                  title: 'Customer Count',
                                  percentage: '',
                                  amount: SellerDashController
                                      .to
                                      .dashData
                                      .value
                                      .customer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Utils.columnSpacer(height: screenHeight * 0.03),
                      const EarningStatistics(),
                      Utils.columnSpacer(height: screenHeight * 0.03),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Top Products',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                                fontSize: 18,
                              ),
                            ),
                            CustomDropdownButton(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Obx(
                          () => Table(
                            columnWidths: const {
                              0: FixedColumnWidth(50.0),
                              1: FlexColumnWidth(),
                              2: FixedColumnWidth(65.0),
                              3: FixedColumnWidth(80.0),
                            },
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'No.',
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.greyTextColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Product',
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.greyTextColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      'Price',
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.greyTextColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      'Item Sold',
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.greyTextColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ...getTopProductsRows(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget revenueCard({
    required String title,
    required dynamic amount,
    required dynamic percentage,
    required dynamic width,
    required dynamic height,
  }) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.whiteColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset('assets/images/moneysend.png', height: 15),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '₹$amount',
              style: GoogleFonts.aBeeZee(
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Image.asset('assets/images/nion.png', height: 10),
                const SizedBox(width: 8),
                Text(
                  'in the last 1 month',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyTextColor.withOpacity(0.5),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<TableRow> getTopProductsRows() {
    final data = SellerDashController.to.dashData.value;
    if (data.status == null) return [];

    final selectedPeriod = SellerDashController.to.selectedPeriod.value;
    List<TopProducts>? products = data.topProducts;

    if (products == null || products.isEmpty) return [];

    return products.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final product = entry.value.product;
      final totalSold = entry.value.totalUnitsSold ?? 0;
      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 14, 8, 8),
            child: Text('$index'),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    product?.image ?? '',
                    width: Get.width * 0.09,
                    height: Get.height * 0.04,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product?.title?.capitalizeFirst ?? 'Unknown',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: _parseColor(product!.color!),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '₹${product?.price ?? '0'}',
              style: GoogleFonts.dmSans(
                textStyle: const TextStyle(
                  fontSize: 14.00,
                  color: AppColors.skyblue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$totalSold Units',
              style: GoogleFonts.dmSans(
                textStyle: const TextStyle(
                  fontSize: 14.00,
                  color: AppColors.greyTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  Color _parseColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}

class EarningStatistics extends StatelessWidget {
  const EarningStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: AppColors.whiteColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.blackColor.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Sales Data',
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                          fontSize: 16.00,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const CustomDropdownButton(),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      labelStyle: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyTextColor,
                      ),
                      majorGridLines: const MajorGridLines(width: 0),
                      majorTickLines: const MajorTickLines(size: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: getMaxValue(
                        SellerDashController.to.selectedPeriod.value,
                      ),
                      interval: 50,
                      labelStyle: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyTextColor,
                      ),
                      majorGridLines: const MajorGridLines(
                        width: 1,
                        color: Colors.grey,
                        dashArray: [5, 5],
                      ),
                      majorTickLines: const MajorTickLines(size: 0),
                      numberFormat: NumberFormat.currency(
                        locale: 'en_IN',
                        symbol: '₹',
                        decimalDigits: 0,
                      ),
                      labelFormat: '{value}',
                    ),
                    plotAreaBorderWidth: 0,
                    series: <CartesianSeries<ChartData, String>>[
                      ColumnSeries<ChartData, String>(
                        dataSource: getChartData(
                          SellerDashController.to.selectedPeriod.value,
                        ),
                        xValueMapper: (ChartData data, _) => data.day,
                        yValueMapper: (ChartData data, _) => data.earnings,
                        color: AppColors.skyblue,
                        width: 0.15,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          labelAlignment: ChartDataLabelAlignment.top,
                          textStyle: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                          ),
                          builder:
                              (
                                dynamic data,
                                dynamic point,
                                dynamic series,
                                int pointIndex,
                                int seriesIndex,
                              ) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 3),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: AppColors.blackColor.withOpacity(
                                          0.3,
                                        ),
                                        blurRadius: 20,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '₹${formatEarnings(data.earnings)}',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                );
                              },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double getMaxValue(String period) {
    final data = SellerDashController.to.dashData.value;
    if (data.status == null) return 100.0;

    final salesChart = data.salesChart;
    if (salesChart == null || salesChart.isEmpty) return 100.0;

    final maxValue = salesChart
        .map((e) => e.totalSales ?? 0)
        .reduce((a, b) => a > b ? a : b)
        .toDouble();
    return maxValue + 50;
  }

  List<ChartData> getChartData(String period) {
    final data = SellerDashController.to.dashData.value;
    if (data.status == null) return [];

    final salesChart = data.salesChart;
    if (salesChart == null || salesChart.isEmpty) return [];

    return salesChart.map((item) {
      return ChartData(item.label ?? '', (item.totalSales ?? 0).toDouble());
    }).toList();
  }

  String formatEarnings(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    } else {
      return value.toStringAsFixed(0);
    }
  }
}

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 35,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: AppColors.greyTextColor.withOpacity(0.05),
            border: Border.all(color: AppColors.greyTextColor.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: SellerDashController.to.selectedPeriod.value,
              items: <String>['This Week', 'This Month', 'This Year'].map((
                String value,
              ) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  SellerDashController.to.selectedPeriod.value = newValue;

                  String value = newValue.trim().toLowerCase().replaceAll(' ', '');

                  SellerDashController.to.getDashData(
                    filter: value == 'thisweek'
                        ? 'this_week'
                        : value == 'thismonth'
                        ? 'this_month'
                        : 'this_year',
                  );

                  log('New Value: $newValue');
                  log('trimWithLowerCase: ${newValue.trim().toLowerCase()}');
                }
              },
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.greyTextColor.withOpacity(0.5),
              ),
              dropdownColor: Colors.white,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                color: AppColors.greyTextColor.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.day, this.earnings);
  final String day;
  final double earnings;
}
