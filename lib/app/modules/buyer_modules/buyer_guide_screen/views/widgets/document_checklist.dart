import 'package:flutter/material.dart';

class DocumentChecklist extends StatelessWidget {
  const DocumentChecklist({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> documents = [
      'Title Deed (7/12 extract)',
      'Property Tax Receipts',
      'Encumbrance Certificate',
      'Building Approval Plan',
      'OC (Occupancy Certificate)',
      'Sale Agreement',
      'No Objection Certificates',
      'Identity Proof (Aadhar, PAN)',
      'Latest Bank Statements'
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...documents.map((doc) => _BuildDocumentItem(doc)),
        ],
      ),
    );
  }
}

class _BuildDocumentItem extends StatelessWidget {
  final String document;

  const _BuildDocumentItem(this.document);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 18, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              document,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}