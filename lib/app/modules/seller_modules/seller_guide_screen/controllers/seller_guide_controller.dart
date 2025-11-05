import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/seller_modules/seller_main_screen/controllers/seller_main_controller.dart';

import '../../../../data/models/guide/seller_guide_controller.dart';

class SellerGuideController extends GetxController
{
    // Data for "Getting Started" section
    final gettingStartedItems = [
        GuideItem(icon: Icons.person_add_alt_1_outlined, title: "Create an Account", subtitle: "Register and set up your seller profile."),
        GuideItem(icon: Icons.verified_user_outlined, title: "Verify Your Profile", subtitle: "Complete verification for buyer trust."),
        GuideItem(icon: Icons.list_alt, title: "List Your Property", subtitle: "Follow our simple steps to post your property.")
    ];

    // Data for "Valuable Tips" sections
    final photographyTips = [
        "Use a high-quality camera or smartphone.",
        "Shoot during the day for natural light.",
        "Showcase key areas like living room, kitchen, and bedrooms.",
        "Tidy up the space before taking pictures.",
        "Include exterior shots and unique features."
    ];

    final pricingTips = [
        "Research similar properties in your area.",
        "Consider the property's condition, age, and features.",
        "Be open to negotiation but know your baseline.",
        "Highlight value, not just the price tag.",
        "Factor in any recent renovations or upgrades."
    ];

    // Data for FAQ section
    final faqs = [
    {
        'question': 'How do I edit a property listing?',
        'answer': 'Navigate to "My Properties", find the listing you wish to change, and tap the "Edit" button. You can update details, images, and pricing.'
    },
    {
        'question': 'What are the fees for selling a property?',
        'answer': 'Our Basic plan is completely free! For more features and visibility, you can upgrade to our Premium or Enterprise plans. Visit the "Plans" section for more details.'
    },
    {
        'question': 'How do I handle inquiries from buyers?',
        'answer': 'All inquiries will appear in your "Leads" tab. From there, you can manage conversations, schedule viewings, and update the status of each lead.'
    }
    ];

    //----------------------------------------------------------------------------
    // Navigational Methods
    //----------------------------------------------------------------------------
    void gotoListProperty() 
    {
        final controller = Get.find<SellerMainController>();
        Get.back();
        controller.currentIndex.value = 2;
    }
}
