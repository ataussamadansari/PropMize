import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/leads/leads_model.dart';
import 'package:prop_mize/app/data/repositories/leads/leads_repository.dart';

class LeadsController extends GetxController {
  final LeadsRepository _leadsRepository = LeadsRepository();

  // ----- State Management -----
  final RxBool isLoading = true.obs;
  final RxBool isLoadMore = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  // ----- Data & Filtering -----
  final _allLeads = <Data>[];
  final RxList<Data> filteredLeads = <Data>[].obs;
  final RxString selectedStatus = 'All Statuses'.obs;
  final RxList<String> statusOptions = <String>['All Statuses', 'New', 'Contacted', 'Converted', 'Lost'].obs;
  final TextEditingController searchController = TextEditingController();

  // ----- Pagination -----
  final int _limit = 10;
  RxInt page = 1.obs;
  RxBool hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_filterLeads);
    loadLeadsData();
  }

  /// Load initial leads data or refresh the list.
  Future<void> loadLeadsData({bool isRefresh = false}) async {
    if (isRefresh) {
      page.value = 1;
      hasMore.value = true;
      _allLeads.clear();
      filteredLeads.clear();
    }

    // Prevent multiple simultaneous requests
    if (isLoadMore.value || !hasMore.value) return;

    try {
      if (page.value == 1) {
        isLoading.value = true;
      } else {
        isLoadMore.value = true;
      }
      hasError.value = false;

      final response = await _leadsRepository.getLeads(page: page.value, limit: _limit);

      if (response.success && response.data != null) {
        final newLeads = response.data!.data ?? [];
        _allLeads.addAll(newLeads);
        _filterLeads(); // Apply current filters to the combined list

        // Check if there are more pages to load
        if (newLeads.length < _limit) {
          hasMore.value = false;
        } else {
          page.value++;
        }
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = "An unexpected error occurred: $e";
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
  }

  /// Filter leads locally based on search query and selected status.
  void _filterLeads() {
    final query = searchController.text.toLowerCase();
    final status = selectedStatus.value;

    // If no filters, show all leads
    if(query.isEmpty && status == 'All Statuses') {
      filteredLeads.assignAll(_allLeads);
      return;
    }

    var leads = _allLeads.where((lead) {
      final buyerName = lead.buyer?.name?.toLowerCase() ?? '';
      final propertyName = lead.property?.title?.toLowerCase() ?? '';
      return buyerName.contains(query) || propertyName.contains(query);
    }).toList();

    if (status != 'All Statuses') {
      leads = leads.where((lead) => (lead.status?.toLowerCase() ?? '') == status.toLowerCase()).toList();
    }

    filteredLeads.assignAll(leads);
  }

  /// Update the filter when a new status is selected and re-apply filtering.
  void changeStatus(String? newStatus) {
    if (newStatus != null) {
      selectedStatus.value = newStatus;
      _filterLeads();
    }
  }

  /// Navigate to the Lead Details screen.
  void viewLeadDetails(String leadId) {
    Get.toNamed('/leads/$leadId');
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}


/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/leads/leads_model.dart';
import 'package:prop_mize/app/data/repositories/leads/leads_repository.dart';

class LeadsController extends GetxController {
  final LeadsRepository _leadsRepository = LeadsRepository();

  // ----- State Management -----
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  // ----- Data & Filtering -----
  final _leadsModel = Rxn<LeadsModel>();
  final RxList<Data> filteredLeads = <Data>[].obs;
  final RxString selectedStatus = 'All Statuses'.obs;
  final RxList<String> statusOptions = <String>['All Statuses', 'New', 'Contacted', 'Converted', 'Lost'].obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_filterLeads);
    loadLeadsData();
  }

  /// Load leads data from the repository
  Future<void> loadLeadsData() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      final response = await _leadsRepository.getLeads();
      if (response.success && response.data != null) {
        _leadsModel.value = response.data;
        filteredLeads.assignAll(_leadsModel.value!.data!);
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = "An unexpected error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }

  /// Filter leads based on search query and selected status
  void _filterLeads() {
    final query = searchController.text.toLowerCase();
    final status = selectedStatus.value;
    final allLeads = _leadsModel.value?.data ?? [];

    var leads = allLeads.where((lead) {
      final buyerName = lead.buyer?.name?.toLowerCase() ?? '';
      final propertyName = lead.property?.title?.toLowerCase() ?? '';
      return buyerName.contains(query) || propertyName.contains(query);
    }).toList();

    if (status != 'All Statuses') {
      leads = leads.where((lead) => (lead.status?.toLowerCase() ?? '') == status.toLowerCase()).toList();
    }

    filteredLeads.assignAll(leads);
  }

  /// Update the filter when a new status is selected
  void changeStatus(String? newStatus) {
    if (newStatus != null) {
      selectedStatus.value = newStatus;
      _filterLeads();
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}*/


/*
import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/leads/leads_model.dart';
import 'package:prop_mize/app/data/repositories/leads/leads_repository.dart';

import '../../../../data/services/storage/storage_services.dart';

class LeadsController extends GetxController {

  //----------------------------------------------------------------------------
  // Dependency
  //----------------------------------------------------------------------------
  final LeadsRepository _leadsRepository = LeadsRepository();

  //----------------------------------------------------------------------------
  // Variables
  //----------------------------------------------------------------------------
  final leadsModel = Rxn<LeadsModel>();
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxBool isLoading = false.obs;

  // ===== Computed Getters =====
  RxString get currentUserId => StorageServices.to.userId;

  @override
  void onInit() {
    super.onInit();
    _initialized();
  }

  void _initialized() {
    loadLeadsData();
  }

  /// Load leads data
  Future<void> loadLeadsData() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _leadsRepository.getLeads();
      if(response.success && response.data != null) {
        leadsModel.value = response.data;
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = "An unexpected error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }

}
*/
