import 'dart:convert';
import 'dart:io';
import 'package:aadaiz_seller/src/features/seller/ui/home/model/home_model.dart'
    show Product;
import 'package:aadaiz_seller/src/features/tailor/ui/home/model/home_order_model.dart'
    show Datum;
import 'package:aadaiz_seller/src/res/components/common_toast.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/home_order_repository.dart';

class TailorOrderController extends GetxController {
  static TailorOrderController get to => Get.put(TailorOrderController(), permanent: true);
  RxInt selectedIndex = 0.obs;

  void setTab(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    // Initial fetch for the default tab ('placed') can be handled in the UI
    // Removed getorderlist() here to avoid unnecessary API call
  }

  var selectedImages = <XFile>[].obs;
  TailorOrderRepository repo = TailorOrderRepository();

  List upload = [];
  var kycLoading = false.obs;
  var isLoading = false.obs;
  var isLoadingStatusById = <dynamic, dynamic>{}.obs;

  var orderlist = <Datum>[].obs;

  Future<List<String>> uploadImage() async {
    print('Starting image upload. Selected images: ${selectedImages.length}');
    upload.clear();

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
        Get.snackbar("Error", "Failed to upload image ${i + 1}: $e");
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
        quality: 85,
        minWidth: 1024,
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
          quality: 70,
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

  final RxInt currentPage = 1.obs;
  final RxInt lastPage = 1.obs;
  final RxString nextPageUrl = ''.obs;
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );
  final RefreshController refreshControllerforassignedorders = RefreshController(
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
    if (isLoading.value) return;
    print("type: ${type ?? 'unknown'}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {
      Get.snackbar("Error", "No token found. Please log in again.");
      _getRefreshController(type).refreshFailed();
      return;
    }

    if (isRefresh) {
      currentPage.value = 1;
      nextPageUrl.value = '';
      lastPage.value = 1;
      orderlist.clear();
    } else if (isLoadMore && nextPageUrl.value.isEmpty) {
      _getRefreshController(type).loadNoData();
      return;
    }

    try {
      isLoading(true);
      var response = await repo.orderApi(type, token, currentPage.value);
      if (response.success && response.data != null) {
        if (isRefresh) {
          orderlist.assignAll(response.data.data);
        } else {
          orderlist.addAll(response.data.data);
        }
        currentPage.value = response.data.currentPage;
        lastPage.value = response.data.lastPage;
        nextPageUrl.value = response.data.nextPageUrl ?? '';
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
      print('Error fetching order list: $e');
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
      case 'placed':
        return refreshControllerforassignedorders;
      case 'pickup':
        return refreshControllerforPickup;
      case 'track':
        return refreshControllerforTrack;
      case 'completed':
        return refreshControllerforCompleted;
      default:
      // Fallback to default controller to avoid null return
        return refreshController;
    }
  }
  Future<void> updatedOrderstatus({
    required dynamic id,

    required String status,
    required dynamic type,
    required dynamic material_status,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {
      Get.snackbar("Error", "No token found. Please log in again.");
      return;
    }

    try {
      isLoadingStatusById[id] = true; // Set loading for this specific order ID
      isLoadingStatusById.refresh();
      List<String> uploadedUrls = await uploadImage(); // Upload images first
      String imageUrls = uploadedUrls.join(',');
      Map<String, dynamic> body = {
        "token": token,
        "order_id": id,

        "status": status,
        "material_status":material_status,
        "completed_image":imageUrls
      };

      var response = await repo.orderstatusApi(body: jsonEncode(body));
      if (response["success"] == true) {
      await  CommonToast.show(msg: response["message"]);
        Future.delayed(
          Duration(milliseconds: 100),
              () => {
            if(type!=7){
            getorderlist(isRefresh: true,
              type: type == 3
                  ? "pickup"
                  : type == 4
                  ? "track"
                  : "completed"

            ),}
          },
        );
    if  (material_status=='completed'){
      Get.back();Get.back();
      selectedImages.clear();
    }

      } else {
        Get.snackbar("Error", response.message ?? "Failed to update product.");
      }
    } catch (e) {
      print("Error updating product: $e");
      Get.snackbar("Error", "An error occurred while updating product: $e");
    } finally {
      isLoadingStatusById[id] = false; // Clear loading for this order ID
      isLoadingStatusById.refresh();
    }
  }
  @override
  void onClose() {
    print("TailorOrderController onClose: Disposing RefreshControllers");
    refreshController.dispose();
    refreshControllerforassignedorders.dispose();
    refreshControllerforPickup.dispose();
    refreshControllerforTrack.dispose();
    refreshControllerforCompleted.dispose();
    super.onClose();
  }
}