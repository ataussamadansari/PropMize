import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/leads/leads_model.dart';

class LeadsService extends GetxService {
  // Sab leads store karega
  final RxList<Data> allLeads = <Data>[].obs;

  // Lead status track karega
  final RxMap<String, String> leadStatusMap = <String, String>{}.obs;

  // Real-time updates ke liye
  final RxnString lastUpdatedLeadId = RxnString();

  /// Lead status update karo aur sabko notify karo
  void updateLeadStatus(String leadId, String newStatus) {
    leadStatusMap[leadId] = newStatus;
    lastUpdatedLeadId.value = leadId;

    // Local list mein bhi update karo
    final index = allLeads.indexWhere((lead) => lead.id == leadId);
    if (index != -1) {
      // Temporary update - agar aapke model mein copyWith nahi hai
      allLeads[index] = allLeads[index];
      allLeads.refresh(); // Force UI update
    }

    print('✅ Lead $leadId status updated to $newStatus');
  }

  /// Naye leads add karo
  void addLeads(List<Data> leads) {
    allLeads.addAll(leads);

    // Status map initialize karo
    for (final lead in leads) {
      if (lead.id != null && lead.status != null) {
        leadStatusMap[lead.id!] = lead.status!;
      }
    }
  }

  /// Specific lead ka status get karo
  String getLeadStatus(String leadId) {
    return leadStatusMap[leadId] ?? 'new';
  }

  /// Specific lead get karo
  Data? getLeadById(String leadId) {
    return allLeads.firstWhereOrNull((lead) => lead.id == leadId);
  }

  @override
  void onInit() {
    print('🚀 LeadsService initialized');
    super.onInit();
  }
}