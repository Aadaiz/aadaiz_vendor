import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:aadaiz_seller/src/features/auth/controller/auth_controller.dart';
import 'package:aadaiz_seller/src/features/tailor/model/address_list_model.dart';
import 'package:aadaiz_seller/src/features/tailor/model/address_list_model.dart'
    as addres;
import 'package:aadaiz_seller/src/features/tailor/model/address_model.dart';
import 'package:aadaiz_seller/src/features/tailor/model/tailor_order_model.dart';
import 'package:aadaiz_seller/src/features/tailor/model/tailor_order_model.dart' as order;
import 'package:aadaiz_seller/src/features/tailor/repository/tailor_repository.dart';
import 'package:aadaiz_seller/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../res/components/common_toast.dart';
import '../../../utils/routes/routes_name.dart';
import '../model/category_list_model.dart';
import '../model/category_list_model.dart' as category;

class TailorController extends GetxController {
static TailorController  get to => Get.put(TailorController());
RxInt selectedIndex = 0.obs;

void setTab(int index) {
  selectedIndex.value = index;
}

  var repo = TailorRepository();
Rx<File> image1 = File('').obs;
Rx<File> image2 = File('').obs;
Rx<File> image3 = File('').obs;
Rx<File> adhar = File('').obs;

TextEditingController no = TextEditingController();
TextEditingController st = TextEditingController();
TextEditingController pin = TextEditingController();
TextEditingController city = TextEditingController();
TextEditingController land = TextEditingController();
TextEditingController mob = TextEditingController();
TextEditingController acc = TextEditingController();
TextEditingController conacc = TextEditingController();
TextEditingController ifsc = TextEditingController();
var latitude = 0.0.obs;
var longitude = 0.0.obs;

List selectedCategory=<category.PatternFiltercategory>[].obs;
 var selectedCategoriesWithPrice = {}.obs;
  var tailorLoading =false.obs;

  Future<dynamic> tailorKyc(context) async{
    if(acc.text!=conacc.text){
      CommonToast.show(msg: "Confirm Account number should be same as Account number");

    }
   else if(ifsc.text==''){
      CommonToast.show(msg: "Enter IFSC Code");
    }
   else{



    tailorLoading(true);
    await AuthController.to.uploadImage();
    Map body = {
      'account_type': 'Tailer',
      'email': 'gfsg@gmail.com',
      'category': selectedCategoriesWithPrice.map((key, value) => MapEntry(key.toString(), value.toString())),
      'mobile_number': AuthController.to.mobile.text,
      'what_u_done': '${AuthController.to.upload[0]},${AuthController.to.upload[1]},${AuthController.to.upload[2]}',
      'aadhar_card': '${AuthController.to.upload[3]}',
      'house_no': no.text,
      'pincode': pin.text,
      'city': city.text,
      'street': st.text,
      'landmark': land.text,
      'latitude': latitude.value.toString(),
      'longitude': longitude.value.toString(),
      'account_number': acc.text,
      'confirm_account_number': conacc.text,
      'ifsc_code': ifsc.text,
      'shop_name': 'sd',
    };
    TailorAddressRes res = await repo.kycTailor(body: jsonEncode(body));
    tailorLoading(false);
    if(res.success==true){
      SharedPreferences prefs=await SharedPreferences.getInstance();
      await prefs.setInt('isLogin', 2);
      await prefs.setString('token', '${res.data!.token}');

      await Navigator.pushReplacementNamed(context,  RoutesName.tailorHome,);
    }else{
      CommonToast.show(msg: res.message);
    }}
  }


  var orderLoading=false.obs;
  var orderList = <order.Datum>[].obs;

  getOrders(status) async {
    orderLoading(true);
    TailorOrderListRes res = await repo.getOrders(status);
    orderLoading(false);
    if(res.success==true){
      orderList.value = res.data!;
    }else{
      orderList.clear();
    }
  }


  var addressLoading=false.obs;
  Future<dynamic> address(action,{
    dynamic name,
    dynamic address,
    dynamic land,
    dynamic city,
    dynamic state,
    dynamic country,
    dynamic addressId,
    dynamic zipCode,
    dynamic mobile,
    dynamic isDefault}) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.getString("token");
    addressLoading(true);
    Map body = {
      'name':'${name.text}',
      'address':'${address.text}',
      'landmark':'${land.text}',
      'city':'${city.text}',
      'state':'${state.text}',
      'country':'${country.text}',
      'pincode':'${zipCode.text}',
      'mobile':'${mobile.text}',
      'is_default':'$isDefault',
      'action':'$action',
      'address_id':'$addressId',
      'token':'$token',
    };
    TailorAddressRes res = await repo.address(body:jsonEncode(body));
    if(res.success==true){
      addressLoading(false);
      await getAddressList();
      Get.back();
    }else{
      addressLoading(false);
      CommonToast.show(msg: '${res.message}');
    }
  }

  var addressListLoading = false.obs;
  var addressList = <addres.Datum>[].obs;
  List isDefaultList = [].obs;

  Future<dynamic> getAddressList() async {
    isDefaultList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    addressListLoading(true);
    Map body = {
      'action': 'list',
      'token': '$token',
    };
    TailorAddressListRes res = await repo.getAddress(body: jsonEncode(body));
    if (res.success == true) {
      addressList.value = res.data!;
      isDefaultList = List.generate(addressList.length,
          (index) => addressList[index].isDefault == 1 ? true : false);
      addressListLoading(false);
    } else {
      addressList.clear();
    }
  }

  var filterListLoading = false.obs;
  var filterList = <category.Category>[].obs;

  Future<dynamic> getFilterList() async {
    filterListLoading(true);
    TailorCategoryListRes res = await repo.getCategory();
    if (res.status == true) {
      filterListLoading(false);
      filterList.value = res.categories!;
    } else {
      filterList.clear();
    }
  }
}
