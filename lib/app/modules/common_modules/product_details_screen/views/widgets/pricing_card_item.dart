import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/helpers.dart';
import '../../../../../data/models/properties/lists/pricing.dart';

class PricingCardItem extends StatelessWidget {
  final Pricing? pricing;
  final int? price;
  final String? currency;

  const PricingCardItem({super.key, this.pricing, this.price, this.currency});

  @override
  Widget build(BuildContext context) {
    final basePrice = pricing?.basePrice ?? price;

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.colorScheme.surfaceContainerHighest, width: 1),
        borderRadius: BorderRadius.circular(8.0),
        color: context.theme.cardColor,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                // "₹ $basePrice",
                '${AppHelpers.formatCurrency(basePrice ?? 0)} ${currency ?? 'INR'}',
                style: context.textTheme.headlineMedium?.copyWith(color: Colors.green),
              ),
              if (pricing?.basePrice != null)
                Text(" /Month", style: context.textTheme.bodySmall),
            ],
          ),
          if (pricing?.maintenanceCharges != null || pricing?.securityDeposit != null) ...[
            Divider(color: context.theme.colorScheme.surfaceContainerHighest),
            Row(
              children: [
                PricingSubCardItem(
                  title: "Maintenance",
                  amount: pricing?.maintenanceCharges,
                ),
                const SizedBox(width: 8),
                PricingSubCardItem(
                  title: "Security Deposit",
                  amount: pricing?.securityDeposit,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class PricingSubCardItem extends StatelessWidget {
  final String title;
  final int? amount;

  const PricingSubCardItem({super.key, required this.title, this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: context.theme.colorScheme.surfaceContainerHighest,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium
                ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹${amount ?? 0}",
                style: context.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (title == "Maintenance") Text(" /Month", style: context.textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}


/*class PricingCardItem extends StatelessWidget
{
  final Pricing? pricing;
  final int? price;
  const PricingCardItem({super.key, this.pricing, this.price});

  @override
  Widget build(BuildContext context)
  {
    return Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
            border: BoxBorder.all(color: context.theme.colorScheme.surfaceContainerHighest, width: 1),
            borderRadius: BorderRadius.circular(8.0),
            color: context.theme.cardColor,
            *//*boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 10,
                  offset: const Offset(1, 1)
              )
            ]*//*
        ),
        child: Column(
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (pricing!.basePrice != null) ...[
                      Text("₹ ${pricing!.basePrice}",
                          style: context.textTheme.headlineMedium?.copyWith(color: Colors.green)
                      ),
                      Text(" /Month", style: context.textTheme.bodySmall)
                    ] else ...[
                      Text(
                          "₹ ${price!}",
                          style: context.textTheme.headlineMedium?.copyWith(color: Colors.green)
                      )
                    ]
                  ]),
              if (pricing!.maintenanceCharges != null || pricing!.securityDeposit != null) ...[
                Divider(color: context.theme.colorScheme.surfaceContainerHighest),
                Row(
                    children: [
                      PricingSubCardItem(title: "Maintenance", amount: pricing!.maintenanceCharges),
                      SizedBox(width: 8),
                      PricingSubCardItem(title: "Security Deposit", amount: pricing!.securityDeposit)
                    ]
                )
              ]
            ]
        )
    );
  }
}

class PricingSubCardItem extends StatelessWidget
{
  final String title;
  final int? amount;
  const PricingSubCardItem({super.key, required this.title, this.amount});

  @override
  Widget build(BuildContext context)
  {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: context.theme.colorScheme.surfaceContainerHighest
        ),
        child: Column(
            spacing: 8,
            children: [
              Text(title, style: context.textTheme.bodyMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold)),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("₹$amount", style: context.textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold)),
                    Text(title == "Maintenance" ? " /Month" : "", style: context.textTheme.bodySmall)
                  ]
              )
            ]
        )
    );
  }
}*/

