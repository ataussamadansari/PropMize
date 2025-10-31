import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/models/leads/lead_details_model.dart';
import 'package:prop_mize/app/data/repositories/leads/leads_repository.dart';

class LeadDetailsController extends GetxController {
  final LeadsRepository _leadsRepository = LeadsRepository();

  // ----- State Management -----
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxBool isUpdatingStatus = false.obs;

  // ----- Data -----
  final leadDetails = Rxn<LeadDetailsModel>();
  late final String _leadId;

  @override
  void onInit() {
    super.onInit();
    // Retrieve the lead ID from route parameters
    _leadId = Get.parameters['leadId'] ?? '';

    if (_leadId.isNotEmpty) {
      fetchLeadDetails(_leadId);
    } else {
      hasError.value = true;
      errorMessage.value = "Lead ID not found";
      isLoading.value = false;
    }
  }

  /// Fetches the details for the specific lead from the repository.
  Future<void> fetchLeadDetails(String id) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final response = await _leadsRepository.viewLead(id);

      if (response.success && response.data != null) {
        leadDetails.value = response.data;
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

  /// Updates the lead status
  Future<void> updateLeadStatus(String newStatus) async {
    try {
      isUpdatingStatus.value = true;

      // TODO: Implement API call to update lead status
      // final response = await _leadsRepository.updateLeadStatus(_leadId, newStatus);

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));


      AppHelpers.showSnackBar(
        title: "Success",
        message: "Lead status updated to $newStatus",
        isError: false,
      );

    } catch (e) {
      AppHelpers.showSnackBar(title: "Error", message: "Failed to update lead status: $e", isError: true);
    } finally {
      isUpdatingStatus.value = false;
    }
  }

  void retryFetch() {
    fetchLeadDetails(_leadId);
  }
}