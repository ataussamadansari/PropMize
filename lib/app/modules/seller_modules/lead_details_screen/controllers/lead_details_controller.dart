import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/models/leads/lead_details_model.dart';
import 'package:prop_mize/app/data/repositories/leads/leads_repository.dart';
import 'package:prop_mize/app/data/services/leads/leads_service.dart';


class LeadDetailsController extends GetxController
{
    final LeadsRepository _leadsRepository = LeadsRepository();
    final LeadsService _leadsService = Get.find<LeadsService>();

    // ----- State Management -----
    final RxBool isLoading = true.obs;
    final RxBool hasError = false.obs;
    final RxString errorMessage = "".obs;
    final RxBool isUpdatingStatus = false.obs;

    // ----- Data -----
    final leadDetails = Rxn<LeadDetailsModel>();
    late final String _leadId;

    @override
    void onInit()
    {
        super.onInit();
        // Retrieve the lead ID from route parameters
        _leadId = Get.parameters['leadId'] ?? '';

        if (_leadId.isNotEmpty)
        {
            fetchLeadDetails(_leadId);
        }
        else
        {
            hasError.value = true;
            errorMessage.value = "Lead ID not found";
            isLoading.value = false;
        }
    }

    /// Fetches the details for the specific lead from the repository.
    Future<void> fetchLeadDetails(String id) async
    {
        try
        {
            isLoading.value = true;
            hasError.value = false;

            final response = await _leadsRepository.viewLead(id);

            if (response.success && response.data != null)
            {
                leadDetails.value = response.data;
            }
            else
            {
                hasError.value = true;
                errorMessage.value = response.message;
            }
        }
        catch (e)
        {
            hasError.value = true;
            errorMessage.value = "An unexpected error occurred: $e";
        }
        finally
        {
            isLoading.value = false;
        }
    }

    /// Updates the lead status
    Future<void> updateLeadStatus(String newStatus) async
    {
        try
        {
            isLoading.value = true;
            hasError.value = false;

            final status = newStatus.toLowerCase().replaceAll(' ', '-');
            isUpdatingStatus.value = true;

            final response = await _leadsRepository.leadStatus(_leadId, status, "");

            if (response.success && response.data != null) 
            {
                leadDetails.value = response.data;
                _leadsService.updateLeadStatus(_leadId, status);

                AppHelpers.showSnackBar(
                    title: "Success",
                    message: "Lead status updated to $newStatus",
                    isError: false
                );
            }
            else 
            {
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: response.message,
                    isError: true
                );
            }
        }
        catch (e)
        {
            AppHelpers.showSnackBar(title: "Error", message: "Failed to update lead status: $e", isError: true);
        }
        finally
        {
            isUpdatingStatus.value = false;
            isLoading.value = false;
        }
    }

    void retryFetch()
    {
        fetchLeadDetails(_leadId);
    }
}
