import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/seller_modules/plans_screen/views/widgets/build_billing_toggle.dart';

import '../controllers/plans_controller.dart';
import 'widgets/build_feature_comparison.dart';
import 'widgets/build_plan_card.dart';
import 'widgets/build_success_stories.dart';

class PlansView extends GetView<PlansController>
{
    const PlansView({super.key});

    @override
    Widget build(BuildContext context) 
    {
        return Scaffold(
            appBar: AppBar(
                scrolledUnderElevation: 0,
                elevation: 0,
                title: const Text('Choose Your Seller Plan')
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                        // _buildBillingToggle(),
                        // const SizedBox(height: 24),
                        _buildCurrentPlanCard(),
                        const SizedBox(height: 24),
                        BuildPlanCard(
                            planType: PlanType.basic,
                            icon: Icons.flash_on,
                            title: 'Basic',
                            price: 'Free',
                            features: [
                                '5 property listings',
                                'Basic property analytics',
                                'Email support',
                                'Manual updates'
                            ]
                        ),
                        const SizedBox(height: 16),
                        BuildPlanCard(
                            planType: PlanType.premium,
                            icon: Icons.workspace_premium,
                            title: 'Premium',
                            price: '₹999',
                            period: '/ month',
                            features: [
                                '50 property listings',
                                'Featured property visibility',
                                'Advanced analytics',
                                'Lead management tools',
                                'Priority email & chat support',
                                'Auto-updates & sync'
                            ],
                            isRecommended: true
                        ),
                        const SizedBox(height: 16),
                        BuildPlanCard(
                            planType: PlanType.enterprise,
                            icon: Icons.business,
                            title: 'Enterprise',
                            price: '₹2499',
                            period: '/ month',
                            features: [
                                'Unlimited property listings',
                                'Dedicated private agent',
                                'Customized branding',
                                'API access for integration',
                                '24/7 dedicated support'
                            ]
                        ),
                        const SizedBox(height: 32),
                        BuildFeatureComparison(),
                        const SizedBox(height: 32),
                        BuildSuccessStories()
                    ]
                )
            )
        );
    }

    Widget _buildBillingToggle() 
    {
        return Obx(() => Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        BuildBillingToggle(text: 'Monthly', cycle: BillingCycle.monthly),
                        BuildBillingToggle(text: 'Yearly (Save 20%)', cycle: BillingCycle.yearly)
                    ]
                )
            ));
    }

    Widget _buildCurrentPlanCard() 
    {
        return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3))
            ),
            child: Row(
                children: [
                    Icon(Icons.check_circle, color: Colors.green[700], size: 40),
                    const SizedBox(width: 16),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                'Current Plan: Basic',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green[800]
                                )
                            ),
                            const SizedBox(height: 4),
                            Text(
                                'Expires: Forever',
                                style: TextStyle(color: Colors.green[700])
                            )
                        ]
                    )
                ]
            )
        );
    }
}
