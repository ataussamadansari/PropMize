import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/animation/fade_scale_animation.dart';
import 'package:prop_mize/app/core/utils/animation/staggered_animation_widget.dart';
import 'package:prop_mize/app/modules/common_modules/home_screen/controllers/home_controller.dart';

import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/utils/animation/bounce_animation.dart';
import '../../../../../../core/utils/animation/slide_in_animation.dart';
import '../../../../../../core/utils/animation/typing_animation.dart';
import '../../../../../../core/utils/helpers.dart';
import '../choice_client_seller_btn.dart';
import '../message_card_item.dart';

class NarrowLayout extends GetView<HomeController>
{
    final bool isLoggedIn;
    const NarrowLayout({super.key, required this.isLoggedIn});

    @override
    Widget build(BuildContext context) 
    {
        return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child:
            Column(
                children: [
                    SizedBox(height: 32),
                    BounceAnimation(
                        scale: 1.2,
                        infinite: true,
                        duration: Duration(milliseconds: 2000),
                        child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                shape: BoxShape.circle
                            ),
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                                '🏡',
                                style: TextStyle(fontSize: 50)
                            )
                        )
                    ),
                    const SizedBox(height: 16),

                    // Typing Animation for main title
                    TypingAnimation(
                        texts: [
                            'What\'s on your mind?',
                            'Looking to buy?',
                            'Want to sell?',
                            'Need to rent?'
                        ],
                        typingDuration: Duration(milliseconds: 80),
                        pauseDuration: Duration(milliseconds: 2000),
                        eraseDuration: Duration(milliseconds: 40),
                        style: context.textTheme.displayMedium?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center
                    ),

                    const SizedBox(height: 12),

                    // Static subtitle
                    Text(
                        'Discover your perfect property with AI-powered insights. Connect with verified buyers and sellers in a trusted marketplace.',
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.center
                    ),

                    SizedBox(height: 32,),

                    Column(
                      spacing: 8,
                        children: [
                            SlideInAnimation(
                                beginOffset: Offset(-1, 0),
                                duration: Duration(milliseconds: 600),
                                child: ChoiceClientSellerBtn(
                                    leadingIcon: Icons.search,
                                    title: "Buy / Rent Properties",
                                    subtitle: "Find your dream home or apartment",
                                    onTap: controller.navigateToBuyerMain
                                )
                            ),
                            SlideInAnimation(
                                beginOffset: Offset(1, 0),
                                duration: Duration(milliseconds: 600),
                                child: ChoiceClientSellerBtn(
                                    leadingIcon: Icons.home_work_outlined,
                                    title: "Sell / Rent Property",
                                    subtitle: "List your property & reach genuine buyers/tenants",
                                    onTap: ()
                                    {
                                        if (isLoggedIn) 
                                        {
                                            controller.authController.role(controller.currentUserId.value, "seller");
                                        }
                                        else 
                                        {
                                            AppHelpers.showSnackBar(
                                                title: "Error",
                                                message: "Please login to continue",
                                                actionLabel: "Login",
                                                onActionTap: ()
                                                {
                                                    controller.showAuthBottomSheet();
                                                }
                                            );
                                        }
                                    }
                                )
                            )
                        ]
                    ),

                  SizedBox(height: 32),
                  Column(
                      children: [
                        FadeScaleAnimation(
                          duration: Duration(milliseconds: 800),
                          child: Text(
                              'Why Choose Propmize?',
                              style: context.textTheme.displayMedium?.copyWith(
                                  fontSize: 22
                              )
                          ),
                        ),
                        const SizedBox(height: 12),
                        FadeScaleAnimation(
                          duration: Duration(milliseconds: 900),
                          child: Text(
                              'Experience the future of real estate with our innovative platform designed for modern property transactions.',
                              style: context.textTheme.bodyMedium?.copyWith(
                                  fontSize: 14
                              ),
                              textAlign: TextAlign.center
                          ),
                        ),
                        const SizedBox(height: 24),
                        Column(
                          spacing: 8,
                            children: [
                              StaggeredAnimationWidget(
                                child: MessageCardItem(
                                    leadingData: Icons.electric_bolt,
                                    leadingSvg: "",
                                    isSvg: false,
                                    title: "AI-Powered Insights",
                                    message: "Get intelligent property recommendations and market analysis powered by advanced AI algorithms.",
                                    color: AppColors.primary
                                ),
                              ),
                              StaggeredAnimationWidget(
                                child: MessageCardItem(
                                    leadingData: Icons.shield_outlined,
                                    leadingSvg: "",
                                    isSvg: false,
                                    title: "Verified Community",
                                    message: "Connect with authenticated buyers and sellers in a secure, trusted marketplace environment.",
                                    color: Colors.green
                                ),
                              ),
                              StaggeredAnimationWidget(
                                child: MessageCardItem(
                                    leadingData: Icons.abc,
                                    leadingSvg: "assets/icons/trend.svg",
                                    isSvg: true,
                                    title: "Real-Time Analytics",
                                    message: "Access live market data, pricing trends, and property insights to make informed decisions.",
                                    color: Colors.deepPurpleAccent
                                ),
                              )
                            ]
                        )
                      ]
                  )
                ]
            )
        );
    }
}
