import 'package:flutter/material.dart';

class LegalVerification extends StatelessWidget {
  const LegalVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BuildLegalPoint(
            point: 'Title Clearance',
            description: 'Property ka clear title confirm karein',
          ),
          _BuildLegalPoint(
            point: 'Encumbrance Free',
            description: 'Last 30 years ka encumbrance certificate check karein',
          ),
          _BuildLegalPoint(
            point: 'Approved Plans',
            description: 'Municipal approval for construction verify karein',
          ),
          _BuildLegalPoint(
            point: 'NOC from Society',
            description: 'Society NOC for resale properties lein',
          ),
          _BuildLegalPoint(
            point: 'Loan Closure',
            description: 'Previous loan closure proof verify karein',
          ),
        ],
      ),
    );
  }
}

class _BuildLegalPoint extends StatelessWidget {
  final String point;
  final String description;

  const _BuildLegalPoint({
    required this.point,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, size: 18, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  point,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade800,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}