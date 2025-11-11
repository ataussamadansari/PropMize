import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/animation/bounce_animation.dart';
import '../../../../core/utils/animation/fade_scale_animation.dart';
import '../../../../core/utils/animation/slide_in_animation.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../global_widgets/background/ola_background.dart';
import '../../../../core/utils/animation/staggered_animation_widget.dart';
import '../../../../core/utils/animation/typing_animation.dart';
import '../../../../global_widgets/choice_client_seller_btn.dart';
import '../controllers/home_controller.dart';
import 'widgets/message_card_item.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            // ✅ REUSABLE OLA BACKGROUND
            OlaBackground(
              primaryColor: AppColors.primary,
              waveOpacity: 0.08,
              dotOpacity: 0.1,
              // showWaves: true,
              // showDots: true,
            ),

            Obx(() {
              final isLoggedIn = controller.currentUserId.value.isNotEmpty;

              return SafeArea(
                child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 600;
                      final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1200;
                      final isDesktop = constraints.maxWidth >= 1200;

                      return SingleChildScrollView(
                          padding: EdgeInsets.all(isMobile ? 16 : 24),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 32),

                                // ✅ HERO SECTION
                                _buildHeroSection(context, isMobile),

                                const SizedBox(height: 32),

                                // ✅ CHOICE BUTTONS GRID
                                _buildChoiceButtonsGrid(context, isLoggedIn, isMobile, isTablet, isDesktop),

                                const SizedBox(height: 50),

                                // ✅ FEATURES SECTION
                                _buildFeaturesSection(context, isMobile, isTablet, isDesktop)
                              ]
                          )
                      );
                    }
                ),
              );
            }),
          ],
        )
    );
  }

  // ✅ HERO SECTION
  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Column(
        children: [
          BounceAnimation(
            scale: 1.2,
            infinite: true,
            duration: Duration(milliseconds: 2000),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(12.0),
              child: Text(
                  '🏡',
                  style: TextStyle(fontSize: isMobile ? 50 : 60)
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Typing Animation for main title
          TypingAnimation(
            texts: [
              'What\'s on your mind?',
              'Looking to buy?',
              'Want to sell?',
              'Need to rent?',
            ],
            typingDuration: Duration(milliseconds: 80),
            pauseDuration: Duration(milliseconds: 2000),
            eraseDuration: Duration(milliseconds: 40),
            style: context.textTheme.displayMedium?.copyWith(
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          // Static subtitle
          Text(
              'Discover your perfect property with AI-powered insights. Connect with verified buyers and sellers in a trusted marketplace.',
              style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: isMobile ? 14 : 16
              ),
              textAlign: TextAlign.center
          )
        ]
    );
  }

  // ✅ CHOICE BUTTONS GRID
  Widget _buildChoiceButtonsGrid(BuildContext context, bool isLoggedIn, bool isMobile, bool isTablet, bool isDesktop) {
    int crossAxisCount = 1;
    double childAspectRatio = 4;

    if (isTablet) {
      crossAxisCount = 2;
      childAspectRatio = 3;
    } else if (isDesktop) {
      crossAxisCount = 2;
      childAspectRatio = 2.5;
    }

    // return GridView.count(
    //     shrinkWrap: true,
    //     physics: const NeverScrollableScrollPhysics(),
    //     crossAxisCount: crossAxisCount,
    //     crossAxisSpacing: 16,
    //     mainAxisSpacing: 16,
    //     childAspectRatio: childAspectRatio,

    return Column(
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
            ),
          ),
          SlideInAnimation(
            beginOffset: Offset(1, 0),
            duration: Duration(milliseconds: 600),
            child: ChoiceClientSellerBtn(
                leadingIcon: Icons.home_work_outlined,
                title: "Sell / Rent Property",
                subtitle: "List your property & reach genuine buyers/tenants",
                onTap: () {
                  if (isLoggedIn) {
                    controller.authController.role(controller.currentUserId.value, "seller");
                  } else {
                    AppHelpers.showSnackBar(
                        title: "Error",
                        message: "Please login to continue",
                        actionLabel: "Login",
                        onActionTap: () {
                          controller.showAuthBottomSheet();
                        }
                    );
                  }
                }
            ),
          )
        ]
    );
  }

  // ✅ FEATURES SECTION
  Widget _buildFeaturesSection(BuildContext context, bool isMobile, bool isTablet, bool isDesktop) {
    int crossAxisCount = 1;
    double childAspectRatio = 6 / 4;

    if (isTablet) {
      crossAxisCount = 2;
      childAspectRatio = 5 / 4;
    } else if (isDesktop) {
      crossAxisCount = 3;
      childAspectRatio = 4 / 3;
    }

    return Column(
        children: [
          FadeScaleAnimation(
            duration: Duration(milliseconds: 800),
            child: Text(
                'Why Choose Propmize?',
                style: context.textTheme.displayMedium?.copyWith(
                    fontSize: isMobile ? 22 : 26
                )
            ),
          ),
          const SizedBox(height: 12),
          FadeScaleAnimation(
            duration: Duration(milliseconds: 900),
            child: Text(
                'Experience the future of real estate with our innovative platform designed for modern property transactions.',
                style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: isMobile ? 14 : 16
                ),
                textAlign: TextAlign.center
            ),
          ),
          const SizedBox(height: 24),
          // GridView.count(
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     crossAxisCount: crossAxisCount,
          //     crossAxisSpacing: 16,
          //     mainAxisSpacing: 16,
          //     childAspectRatio: childAspectRatio,
          const Column(
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
    );
  }
}

