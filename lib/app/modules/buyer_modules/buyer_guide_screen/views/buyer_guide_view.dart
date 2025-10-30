import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/buyer_guide_controller.dart';
import 'widgets/guide_header.dart';
import 'widgets/process_steps.dart';
import 'widgets/document_checklist.dart';
import 'widgets/financial_tips.dart';
import 'widgets/legal_verification.dart';
import 'widgets/inspection_tips.dart';

class BuyerGuideView extends GetView<BuyerGuideController> {
  const BuyerGuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: GuideHeader(),
                collapseMode: CollapseMode.parallax,
              ),
              pinned: true,
              floating: false,
              snap: false,
              elevation: 0,
              scrolledUnderElevation: 0,
              // Title will only show when scrolled
              title: innerBoxIsScrolled
                  ? const Text('Property Buying Guide')
                  : null,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Process Steps
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: ProcessSteps(),
              ),

              // Document Checklist
              _buildSectionWithHeader(
                title: 'Important Documents',
                icon: Icons.checklist_rounded,
                color: Colors.orange,
                child: DocumentChecklist(),
              ),

              // Financial Tips
              _buildSectionWithHeader(
                title: 'Financial Planning',
                icon: Icons.attach_money_rounded,
                color: Colors.blue,
                child: FinancialTips(),
              ),

              // Legal Verification
              _buildSectionWithHeader(
                title: 'Legal Verification',
                icon: Icons.gavel_rounded,
                color: Colors.red,
                child: LegalVerification(),
              ),

              // Inspection Tips
              _buildSectionWithHeader(
                title: 'Inspection Tips',
                icon: Icons.home_repair_service_rounded,
                color: Colors.purple,
                child: InspectionTips(),
              ),

              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionWithHeader({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: color,
                ),
              ),
            ],
          ),
        ),

        // Section Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: child,
        ),
      ],
    );
  }
}

// ============
/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/buyer_guide_controller.dart';
import 'widgets/guide_header.dart';
import 'widgets/process_steps.dart';
import 'widgets/document_checklist.dart';
import 'widgets/financial_tips.dart';
import 'widgets/legal_verification.dart';
import 'widgets/inspection_tips.dart';

class BuyerGuideView extends GetView<BuyerGuideController> {
  const BuyerGuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsing AppBar
          SliverAppBar(
            title: Text('Property Buying Guide'),
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: GuideHeader(),
              collapseMode: CollapseMode.parallax,
            ),
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),

          // Main Content
          SliverList(
            delegate: SliverChildListDelegate([
              // Process Steps
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: ProcessSteps(),
              ),

              // Document Checklist
              _buildSectionWithHeader(
                title: 'Important Documents',
                icon: Icons.checklist_rounded,
                color: Colors.orange,
                child: DocumentChecklist(),
              ),

              // Financial Tips
              _buildSectionWithHeader(
                title: 'Financial Planning',
                icon: Icons.attach_money_rounded,
                color: Colors.blue,
                child: FinancialTips(),
              ),

              // Legal Verification
              _buildSectionWithHeader(
                title: 'Legal Verification',
                icon: Icons.gavel_rounded,
                color: Colors.red,
                child: LegalVerification(),
              ),

              // Inspection Tips
              _buildSectionWithHeader(
                title: 'Inspection Tips',
                icon: Icons.home_repair_service_rounded,
                color: Colors.purple,
                child: InspectionTips(),
              ),

              SizedBox(height: 24.0),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionWithHeader({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 28,
              ),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: color,
                ),
              ),
            ],
          ),
        ),

        // Section Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: child,
        ),
      ],
    );
  }
}*/


//===========
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/buyer_guide_controller.dart';
import 'widgets/guide_header.dart';
import 'widgets/process_steps.dart';
import 'widgets/document_checklist.dart';
import 'widgets/financial_tips.dart';
import 'widgets/legal_verification.dart';
import 'widgets/inspection_tips.dart';

class BuyerGuideView extends GetView<BuyerGuideController> {
  const BuyerGuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Buying Guide'),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const GuideHeader(),
            const SizedBox(height: 24),
            const ProcessSteps(),
            const SizedBox(height: 24),
            const DocumentChecklist(),
            const SizedBox(height: 24),
            const FinancialTips(),
            const SizedBox(height: 24),
            const LegalVerification(),
            const SizedBox(height: 24),
            const InspectionTips(),
          ],
        ),
      ),
    );
  }
}*/
