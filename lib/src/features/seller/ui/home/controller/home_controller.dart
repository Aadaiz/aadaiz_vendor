import 'dart:convert';
import 'dart:io';
import 'package:aadaiz_seller/src/features/seller/ui/home/model/tracking_model.dart' as tracking;
import 'package:aadaiz_seller/src/features/seller/ui/home/model/home_model.dart'
    show Product;
import '../model/SellerOrder_model.dart' hide Product;
import 'package:aadaiz_seller/src/res/components/common_toast.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/notification_model.dart' as notification;
import '../repository/home_repository.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.put(HomeController(), permanent: true);
  RxInt selectedIndex = 0.obs;

  void setTab(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getproductlist();
    getNotificationList(isRefresh: true);

  }

  var selectedImages = <XFile>[].obs;
  HomeRepository repo = HomeRepository();

  List upload = [];
  var kycLoading = false.obs;
  var isLoading = false.obs;
  var isLoadingStatusById = <dynamic, dynamic>{}.obs;
  var productlist = <Product>[].obs;
  var orderlist = <Datum>[].obs;
  var isProductAddLoading = false.obs;
  var isProductListLoading = false.obs;
  var isProductDeleteLoading = false.obs;
  var isProductEditLoading = false.obs;
  var isStockUpdateLoading = false.obs;
  var isOrderListLoading = false.obs;

  Future<List<String>> uploadImage() async {
    print('Starting image upload. Selected images: ${selectedImages.length}');
    upload.clear();
    // if (selectedImages.isEmpty) {
    //   print('No images selected for upload');
    //   throw Exception('No images selected');
    // }

    for (var i = 0; i < selectedImages.length; i++) {
      try {
        kycLoading(true);
        print('Processing image ${i + 1}: ${selectedImages[i].path}');

        // Compress the image
        final compressedFile = await _compressImage(selectedImages[i]);
        if (compressedFile == null) {
          print('Failed to compress image ${i + 1}');
          throw Exception('Failed to compress image ${i + 1}');
        }

        print('Uploading compressed image ${i + 1}: ${compressedFile.path}');
        var response = await repo.uploadImage(image: compressedFile.path);
        if (response != null &&
            response.url != null &&
            response.url!.isNotEmpty) {
          upload.add(response.url);
          print('Uploaded image ${i + 1}: ${response.url}');
        } else {
          print('Upload response is null or missing URL for image ${i + 1}');
          throw Exception('Failed to upload image ${i + 1}: Invalid response');
        }
      } catch (e) {
        print('Error uploading image ${i + 1}: $e');

        return [];
      } finally {
        kycLoading(false);
      }
    }
    return upload.cast<String>();
  }

  Future<XFile?> _compressImage(XFile image) async {
    try {
      final File originalFile = File(image.path);
      final tempDir = await getTemporaryDirectory();
      final format = CompressFormat.jpeg;
      final extension = format == CompressFormat.jpeg
          ? '.jpg'
          : format == CompressFormat.png
          ? '.png'
          : '.webp';
      final String targetPath =
          '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}$extension';

      // Compress the image
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        originalFile.path,
        targetPath,
        quality: 85, // Adjust quality (0-100) to target < 2MB
        minWidth: 1024, // Adjust resolution if needed
        minHeight: 1024,
        format: CompressFormat.jpeg,
      );

      if (compressedFile == null) {
        print('Compression failed for image: ${image.path}');
        return null;
      }

      // Check file size
      final fileSize = await compressedFile.length();
      if (fileSize > 2 * 1024 * 1024) {
        // If still over 2MB, reduce quality further
        final reCompressedFile = await FlutterImageCompress.compressAndGetFile(
          originalFile.path,
          targetPath,
          quality: 70, // Further reduce quality
          minWidth: 800,
          minHeight: 800,
          format: CompressFormat.jpeg,
        );

        if (reCompressedFile == null ||
            await reCompressedFile.length() > 2 * 1024 * 1024) {
          print('Image size still exceeds 2MB after recompression');
          return null;
        }
        return XFile(reCompressedFile.path);
      }

      return XFile(compressedFile.path);
    } catch (e) {
      print('Error compressing image: $e');
      return null;
    }
  }

  Future<dynamic> product({
    required String category,
    required String subCategory,
    required String color,
    required String price,
    required String quantity,
    required String description,
    required dynamic coupon,required String hsnCode }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {

      return;
    }

    try {
     isProductAddLoading.value=true;
      List<String> uploadedUrls = await uploadImage();
      String imageUrls = uploadedUrls.join(',');
      if (imageUrls.isEmpty) {

        return;
      }

      Map<String, dynamic> body = {
        "action": "create",
        "token": token,
        "category": category,
        "subtitle": subCategory,
        "image": imageUrls,
        "color": color,
        "price": price,
        "meter": quantity,
        "description": description,
        "coupon": coupon,
        'hsn_code': hsnCode,

      };

      var response = await repo.productaddApi(body: jsonEncode(body));
      if (response['success'] == true) {
        CommonToast.show(
          msg: response['message'] ?? "Product posted successfully",
        );

        await getproductlist(isRefresh: true);

        selectedImages.clear();
        Get.back();
      } else {

      }
    } catch (e) {
      print("Error saving order: $e");

    } finally {
      isProductAddLoading(false);
    }
  }

  final RxInt currentPage = 1.obs;
  final RxInt lastPage = 1.obs;
  final RxString nextPageUrl = ''.obs;
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  Future<void> getproductlist({
    bool isRefresh = false,
    bool isLoadMore = false,
  }) async {
    isLoading.value=true ;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {

      refreshController.refreshFailed();
      return;
    }

    if (isRefresh) {
      currentPage.value = 1;
      productlist.clear();
    } else if (isLoadMore && nextPageUrl.value.isEmpty) {
      refreshController.loadNoData();
      return;
    }

    Map<String, dynamic> body = {
      "action": "list",
      "token": token,
      "page": currentPage.value,
    };

    try {
      isLoading(true);
      var response = await repo.productApi(body: jsonEncode(body));
      if (response.success && response.data != null) {
        if (isRefresh) {
          productlist.assignAll(response.data.data);
        } else {
          productlist.addAll(response.data.data);
        }
        currentPage.value = response.data.currentPage;
        lastPage.value = response.data.lastPage;
        nextPageUrl.value = response.data.nextPageUrl ?? '';
        if (isRefresh) {
          refreshController.refreshCompleted();
        } else if (isLoadMore) {
          refreshController.loadComplete();
          if (nextPageUrl.value.isEmpty) {
            refreshController.loadNoData();
          }
        }
      } else {
        if (isRefresh) {
          refreshController.refreshFailed();
        } else {
          refreshController.loadFailed();
        }
      }
    } catch (e) {
      if (isRefresh) {
        refreshController.refreshFailed();
      } else {
        refreshController.loadFailed();
      }
    } finally {
      isLoading(false);
    }
  }

  void onRefresh() {
    getproductlist(isRefresh: true);
  }

  void onLoadMore() {
    if (currentPage.value < lastPage.value) {
      currentPage.value++;
      getproductlist(isLoadMore: true);
    } else {
      refreshController.loadNoData();
    }
  }

  Future<void> updateStockStatus(String id, String stockStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {

      return;
    }

    try {
      isLoading(true);
      Map<String, dynamic> body = {
        "action": "stock_update",
        "token": token,
        "id": id,
        "stock_status": stockStatus,
      };

      var response = await repo.productApi(body: jsonEncode(body));
      if (response.success == true) {
        CommonToast.show(
          msg: response.message ?? "Stock status updated successfully",
        );
        Future.delayed(const Duration(milliseconds: 500), () {
          getproductlist(isRefresh: true);
        });
      } else {

      }
    } catch (e) {
      print("Error updating stock status: $e");

    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteProduct(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {

      return;
    }

    try {
      isLoading(true);
      Map<String, dynamic> body = {
        "action": "delete",
        "token": token,
        "id": id,
      };

      var response = await repo.productaddApi(body: jsonEncode(body));
      if (response['success'] == true) {
        CommonToast.show(
          msg: response["message"] ?? "Product deleted successfully",
        );
        print('deleteProduct: Calling getproductlist to refresh');
        Future.delayed(const Duration(milliseconds: 500), () {
          getproductlist(isRefresh: true);
        });
      } else {
        Get.snackbar("Error", response.message ?? "Failed to delete product.");
      }
    } catch (e) {
      print("Error deleting product: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> editProduct({
    required String id,
    required String category,
    required String subCategory,
    required String color,
    required String price,
    required String quantity,
    required String description,
    required dynamic coupon,
    required String hsnCode,
    List<String> existingImageUrls =
        const [], // Existing URLs for unchanged images
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {

      return;
    }

    try {
      isProductEditLoading(true);
      // Upload only new images
      List<String> newImageUrls = selectedImages.isNotEmpty
          ? await uploadImage()
          : [];

      // Combine new and existing URLs, preserving order (up to 3 images)
      List<String> finalImageUrls = [];
      for (int i = 0; i < 3; i++) {
        if (i < newImageUrls.length) {
          // Use new uploaded URL if a new image was selected
          finalImageUrls.add(newImageUrls[i]);
        } else if (i < existingImageUrls.length) {
          // Use existing URL if no new image was selected for this slot
          finalImageUrls.add(existingImageUrls[i]);
        }
      }

      if (finalImageUrls.isEmpty) {
        Get.snackbar("Error", "Please provide at least one image.");
        return;
      }

      String imageUrls = finalImageUrls.join(',');

      Map<String, dynamic> body = {
        "action": "edit",
        "token": token,
        "id": id,
        "category": category,
        "subtitle": subCategory,
        "image": imageUrls,
        "color": color,
        "price": price,
        "meter": quantity,
        "description": description,
        "coupon": coupon,
        'hsn_code': hsnCode,

      };

      var response = await repo.productaddApi(body: jsonEncode(body));
      if (response["success"] == true) {
        CommonToast.show(msg: response["message"]);
        Get.back();
        selectedImages.clear();
        await getproductlist();
      } else {
        Get.snackbar("Error", response.message ?? "Failed to update product.");
      }
    } catch (e) {

    } finally {
      isProductEditLoading(false);
    }
  }

  final RefreshController refreshControllerfororders = RefreshController(
    initialRefresh: false,
  );
  final RefreshController refreshControllerforShipping = RefreshController(
    initialRefresh: false,
  );
  final RefreshController refreshControllerforPickup = RefreshController(
    initialRefresh: false,
  );
  final RefreshController refreshControllerforTrack = RefreshController(
    initialRefresh: false,
  );
  final RefreshController refreshControllerforCompleted = RefreshController(
    initialRefresh: false,
  );
  Future<void> getorderlist({
    bool isRefresh = false,
    bool isLoadMore = false,
    String? type,
  }) async {
    isLoading.value=true;
    print("typ : ${type}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {

      _getRefreshController(type).refreshFailed();
      return;
    }

    if (isRefresh) {
      currentPage.value = 1;
      orderlist.clear();
    } else if (isLoadMore && nextPageUrl.value.isEmpty) {
      _getRefreshController(type).loadNoData();
      return;
    }

    try {
      isLoading(true);
      SellerOrderRes response = await repo.orderApi(type, token, currentPage.value);
      if (response.status==true&& response.data != null) {
        if (isRefresh) {
          orderlist.assignAll(response.data!.data!);
        } else {
          orderlist.addAll(response.data!.data!);
        }
        currentPage.value = response.data!.currentPage!;
        lastPage.value = response.data!.lastPage!;
        nextPageUrl.value = response.data!.nextPageUrl ?? '';
        if (isRefresh) {
          _getRefreshController(type).refreshCompleted();
        } else if (isLoadMore) {
          _getRefreshController(type).loadComplete();
          if (nextPageUrl.value.isEmpty) {
            _getRefreshController(type).loadNoData();
          }
        }
      } else {
        if (isRefresh) {
          _getRefreshController(type).refreshFailed();
        } else {
          _getRefreshController(type).loadFailed();
        }
      }
    } catch (e) {
      if (isRefresh) {
        _getRefreshController(type).refreshFailed();
      } else {
        _getRefreshController(type).loadFailed();
      }
    } finally {
      isLoading(false);
    }
  }

  RefreshController _getRefreshController(String? type) {
    switch (type) {
      case 'shipping':
        return refreshControllerforShipping;
      case 'pickup':
        return refreshControllerforPickup;
      case 'track':
        return refreshControllerforTrack;
      case 'completed':
        return refreshControllerforCompleted;
      default:
        return refreshControllerfororders;
    }
  }

  Future<void> updatedOrderstatus({
    required dynamic id,

    required String status,
    required dynamic type,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {

      return;
    }

    try {
      isLoadingStatusById[id] = true; // Set loading for this specific order ID
      isLoadingStatusById.refresh();

      Map<String, dynamic> body = {
        "token": token,
        "order_item_id": id,

        "status": status,
      };

      var response = await repo.orderstatusApi(body: jsonEncode(body));
      if (response["status"] == true) {
        Future.delayed(
            Duration(milliseconds: 100),
                () => {
        CommonToast.show(msg: response["message"]),
            getorderlist(
              isRefresh: true,
              type: type == 0
                  ? "placed"
                  : type == 1
                  ? "shipping"
                  : type == 2
                  ? "pickup"
                  : type == 3
                  ? "track"
                  : "completed",
            ),
          },
        );
      } else {
        Get.snackbar("Error", response.message ?? "Failed to update product.");
      }
    } catch (e) {

    } finally {
      isLoadingStatusById[id] = false; // Clear loading for this order ID
      isLoadingStatusById.refresh();
    }
  }

  @override
  void onClose() {
    print("HomeController onClose: Disposing RefreshControllers");
    refreshController.dispose();
    refreshControllerfororders.dispose();
    refreshControllerforShipping.dispose();
    refreshControllerforPickup.dispose();
    refreshControllerforTrack.dispose();
    refreshControllerforCompleted.dispose();
    super.onClose();
  }
var trackingLoading=false.obs;
  var trackingData=<tracking.Data>[].obs;
  var trackingDeliveryAddress = Rx<tracking.DeliveryAddress?>(null);
  getTrackingData(String? trackId)async{
    try{
      trackingLoading(true);
      final res = await repo.getTrackingData( trackId);
      if(res.status==true){
        trackingData.assignAll([res.data!]);
        trackingDeliveryAddress.value = res.deliveryAddress;
      }else{
      }


    }
    finally{
      trackingLoading(false);

    }


  }
  var notificationList = <notification.Datum>[].obs;

  final RefreshController refreshNotification = RefreshController(
    initialRefresh: false,
  );

  int currentPageNotification = 1;
  int lastPageNotification = 1;
  Future<void> getNotificationList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        currentPageNotification = 1;
      }

      if (currentPageNotification == 1) {
        isLoading(true);
      }

      notification.NotificationRes res = await repo.getNotificationListApi(page: currentPageNotification);



      if (res.data != null && res.data!.data != null && res.data!.data!.isNotEmpty) {

        if (currentPageNotification == 1) {
          notificationList.assignAll(res.data!.data!);
        } else {
          notificationList.addAll(res.data!.data!);
        }

      } else {

        notificationList.assignAll([
          notification.Datum(
            message: "Heloooooooo",
            title: "New",
            createdAt: DateTime.now(),
          ),
          notification.Datum(
            message: "Test Notification",
            title: "Offer",
            createdAt: DateTime.now(),
          ),
        ]);
      }


      lastPageNotification = res.data!.lastPage ?? 1;

      if (currentPageNotification >= lastPageNotification) {
        refreshNotification.loadNoData();
      } else {
        refreshNotification.loadComplete();
        currentPageNotification++;
      }

    } catch (e) {
      refreshNotification.loadFailed();
    } finally {
      isLoading(false);
      refreshNotification.refreshCompleted();
      update();
    }
  }
}
