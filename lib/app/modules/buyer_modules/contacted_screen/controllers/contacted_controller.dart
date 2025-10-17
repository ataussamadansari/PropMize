import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/models/properties/contacted_seller/my_inquiries.dart';
import 'package:prop_mize/app/data/repositories/properties/properties_repository.dart';

import '../../../../data/services/storage_services.dart';

class ContactedController extends GetxController {
  final PropertiesRepository _repository = PropertiesRepository();

  final RxList<Data> contactedLeads = <Data>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasError = false.obs;
  final RxInt statusCode = 0.obs;

  // current user id
  final currentUserId = StorageServices.to.read("userId");
  final int limit = 2;

  @override
  void onInit() {
    super.onInit();
    getContactedLeads();
  }

  Future<void> getContactedLeads({bool loadMore = false}) async {
    if (!loadMore) {
      isLoading.value = true;
      contactedLeads.clear(); // Clear previous data on refresh
    } else {
      isLoadMore.value = true;
    }

    hasError.value = false;
    errorMessage.value = '';

    try {
      final response = await _repository.getContactedLeads(
        page: currentPage.value,
        limit: limit, // Use defined limit
      );

      if (response.success && response.data != null) {
        final myInquiries = response.data!;
        final newLeads = myInquiries.data ?? [];

        if (loadMore) {
          contactedLeads.addAll(newLeads);
        } else {
          contactedLeads.value = newLeads;
        }

        // Update pagination info
        final pagination = myInquiries.pagination;
        if (pagination != null) {
          hasMore.value = (pagination.page ?? 0) < (pagination.pages ?? 0);
        } else {
          // Fallback pagination logic
          hasMore.value = newLeads.length >= limit;
        }

        // Clear error state
        hasError.value = false;
        errorMessage.value = '';
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
        AppHelpers.showSnackBar(title: "Error", message: response.message, isError: true);
      }

    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      AppHelpers.showSnackBar(title: "Error", message: e.toString(), isError: true);
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
  }

  // Method to load more data
  Future<void> loadMore() async {
    if (!isLoadMore.value && hasMore.value && !isLoading.value) {
      print('Loading more data... Page: ${currentPage.value + 1}');
      currentPage.value++;
      await getContactedLeads(loadMore: true);
    }
  }

  // Method to refresh data
  Future<void> refresh() async {
    currentPage.value = 1;
    hasMore.value = true;
    await getContactedLeads();
  }

  @override
  void onClose() {
    _repository.cancelRequests();
    super.onClose();
  }
}