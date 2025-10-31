import 'package:flutter/material.dart';

class FinancialTips extends StatelessWidget {
  const FinancialTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BuildFinancialTip(
            title: 'Down Payment',
            description: '20-25% of property value arrange rakhein',
          ),
          _BuildFinancialTip(
            title: 'Additional Costs',
            description: 'Stamp duty, registration, lawyer fees consider karein',
          ),
          _BuildFinancialTip(
            title: 'Loan Eligibility',
            description: 'EMI apni monthly income ke 40% se jyada na ho',
          ),
          _BuildFinancialTip(
            title: 'Emergency Fund',
            description: 'Closing costs aur repairs ke liye extra fund rakhein',
          ),
        ],
      ),
    );
  }
}

class _BuildFinancialTip extends StatelessWidget {
  final String title;
  final String description;

  const _BuildFinancialTip({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.blue.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade800,
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