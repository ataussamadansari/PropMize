import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/animation/bounce_animation.dart';
import '../../../../core/utils/animation/fade_scale_animation.dart';
import '../../../../core/utils/animation/slide_in_animation.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../global_widgets/message_card_item.dart';
import '../../../../global_widgets/background/ola_background.dart';
import '../../../../core/utils/animation/staggered_animation_widget.dart';
import '../../../../core/utils/animation/typing_animation.dart';
import '../../../../global_widgets/choice_client_seller_btn.dart';
import '../controllers/home_controller.dart';

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

              return LayoutBuilder(
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
                color: AppColors.primary.withOpacity(0.2),
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

    return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
        children: [
          SlideInAnimation(
            beginOffset: Offset(-1, 0),
            duration: Duration(milliseconds: 600),
            child: ChoiceClientSellerBtn(
                leadingIcon: Icons.search,
                title: "Buy / Rent Properties",
                subtitle: "Find your dream home or apartment",
                onTap: controller.navigateHomeToAssistantChat
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
                          controller.showBottomSheet();
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
          GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: childAspectRatio,
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

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/animation/animated_builder_widget.dart';
import 'package:prop_mize/app/core/utils/animation/bounce_animation.dart';
import 'package:prop_mize/app/core/utils/animation/fade_scale_animation.dart';
import 'package:prop_mize/app/core/utils/animation/slide_in_animation.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/global_widgets/message_card_item.dart';
import '../../../core/utils/animation/staggered_animation_widget.dart';
import '../../../core/utils/animation/typing_animation.dart';
import '../../../global_widgets/choice_client_seller_btn.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            // ✅ OLA-STYLE ANIMATED BACKGROUND
            _buildOlaBackground(context),

            Obx(() {
              final isLoggedIn = controller.currentUserId.value.isNotEmpty;

              return LayoutBuilder(
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
              );
            }),
          ],
        )
    );
  }

  // ✅ OLA-STYLE ANIMATED BACKGROUND
  Widget _buildOlaBackground(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Base gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.05),
                  AppColors.primary.withOpacity(0.02),
                  Colors.white,
                  AppColors.primary.withOpacity(0.03),
                ],
              ),
            ),
          ),

          // Animated waves/circles
          _buildAnimatedWave(
            size: 200,
            color: AppColors.primary.withOpacity(0.08),
            top: -50,
            left: -30,
            duration: 15000,
          ),

          _buildAnimatedWave(
            size: 150,
            color: AppColors.primary.withOpacity(0.06),
            top: 100,
            right: -20,
            duration: 12000,
          ),

          _buildAnimatedWave(
            size: 180,
            color: AppColors.primary.withOpacity(0.07),
            bottom: 200,
            left: -40,
            duration: 18000,
          ),

          _buildAnimatedWave(
            size: 120,
            color: AppColors.primary.withOpacity(0.05),
            bottom: 50,
            right: -30,
            duration: 14000,
          ),

          // Small floating dots
          _buildFloatingDot(
            size: 8,
            color: AppColors.primary.withOpacity(0.1),
            top: 150,
            left: 50,
            duration: 8000,
          ),

          _buildFloatingDot(
            size: 6,
            color: AppColors.primary.withOpacity(0.08),
            top: 300,
            right: 80,
            duration: 6000,
          ),

          _buildFloatingDot(
            size: 10,
            color: AppColors.primary.withOpacity(0.12),
            bottom: 150,
            left: 100,
            duration: 10000,
          ),
        ],
      ),
    );
  }

  // ✅ ANIMATED WAVE/CIRCLE
  Widget _buildAnimatedWave({
    required double size,
    required Color color,
    double? top,
    double? bottom,
    double? left,
    double? right,
    required int duration,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedBuilderWidget(
        duration: Duration(milliseconds: duration),
        autoPlay: true,
        builder: (context, animation, child) {
          final scale = 1.0 + (0.3 * animation.value);
          final opacity = 0.5 + (0.5 * (1 - animation.value).abs());

          return Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(opacity * 0.3),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ✅ FLOATING DOT
  Widget _buildFloatingDot({
    required double size,
    required Color color,
    double? top,
    double? bottom,
    double? left,
    double? right,
    required int duration,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedBuilderWidget(
        duration: Duration(milliseconds: duration),
        autoPlay: true,
        builder: (context, animation, child) {
          final offset = 20.0 * (animation.value - 0.5).abs();

          return Transform.translate(
            offset: Offset(0, offset),
            child: Opacity(
              opacity: 0.7 + (0.3 * (1 - animation.value).abs()),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ✅ HERO SECTION
  *//*Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Column(
        children: [
          BounceAnimation(
            scale: 1.2,
            infinite: true,
            duration: Duration(milliseconds: 2000),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
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
          Text(
              'What\'s on your mind?',
              style: context.textTheme.displayMedium?.copyWith(
                  fontSize: isMobile ? 24 : 28
              ),
              textAlign: TextAlign.center
          ),
          const SizedBox(height: 12),
          Text(
              'Discover your perfect property with AI-powered insights. Connect with verified buyers and sellers in a trusted marketplace.',
              style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: isMobile ? 14 : 16
              ),
              textAlign: TextAlign.center
          )
        ]
    );
  }*//*
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
                color: AppColors.primary.withOpacity(0.2),
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

    return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
        children: [
          SlideInAnimation(
            beginOffset: Offset(-1, 0),
            duration: Duration(milliseconds: 600),
            child: ChoiceClientSellerBtn(
                leadingIcon: Icons.search,
                title: "Buy / Rent Properties",
                subtitle: "Find your dream home or apartment",
                onTap: controller.navigateHomeToAssistantChat
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
                          controller.showBottomSheet();
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
          GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: childAspectRatio,
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
}*/


/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/animation/animated_builder_widget.dart';
import 'package:prop_mize/app/core/utils/animation/bounce_animation.dart';
import 'package:prop_mize/app/core/utils/animation/fade_scale_animation.dart';
import 'package:prop_mize/app/core/utils/animation/slide_in_animation.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/global_widgets/message_card_item.dart';
import '../../../core/utils/animation/staggered_animation_widget.dart';
import '../../../global_widgets/choice_client_seller_btn.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController>
{
    const HomeView({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            body: SafeArea(
                child: Obx(()
                    {
                        final isLoggedIn = controller.currentUserId.value.isNotEmpty;

                        return LayoutBuilder(
                            builder: (context, constraints)
                            {
                                final isMobile = constraints.maxWidth < 600;
                                final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1200;
                                final isDesktop = constraints.maxWidth >= 1200;

                                return SingleChildScrollView(
                                    padding: EdgeInsets.all(isMobile ? 16 : 24),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
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
                        );
                    }
                )
            )
        );
    }

    // ✅ HERO SECTION
    Widget _buildHeroSection(BuildContext context, bool isMobile)
    {
        return Column(
            children: [
              BounceAnimation(
                scale: 1.2,
                infinite: true, // Infinite looping
                duration: Duration(milliseconds: 2000), // Even slower - 2 seconds per bounce
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
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
                Text(
                    'What\'s on your mind?',
                    style: context.textTheme.displayMedium?.copyWith(
                        fontSize: isMobile ? 24 : 28
                    ),
                    textAlign: TextAlign.center
                ),
                const SizedBox(height: 12),
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
    Widget _buildChoiceButtonsGrid(BuildContext context, bool isLoggedIn, bool isMobile, bool isTablet, bool isDesktop)
    {
        int crossAxisCount = 1;
        double childAspectRatio = 4;

        if (isTablet)
        {
            crossAxisCount = 2;
            childAspectRatio = 3;
        }
        else if (isDesktop)
        {
            crossAxisCount = 2;
            childAspectRatio = 2.5;
        }

        return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
            children: [
                ChoiceClientSellerBtn(
                    leadingIcon: Icons.search,
                    title: "Buy / Rent Properties",
                    subtitle: "Find your dream home or apartment",
                    onTap: controller.navigateHomeToAssistantChat
                ),
                ChoiceClientSellerBtn(
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
                                    controller.showBottomSheet();
                                }
                            );
                        }
                    }
                )
            ]
        );
    }

    // ✅ FEATURES SECTION
    Widget _buildFeaturesSection(BuildContext context, bool isMobile, bool isTablet, bool isDesktop)
    {
        int crossAxisCount = 1;
        double childAspectRatio = 6 / 4;

        if (isTablet)
        {
            crossAxisCount = 2;
            childAspectRatio = 5 / 4;
        }
        else if (isDesktop)
        {
            crossAxisCount = 3;
            childAspectRatio = 4 / 3;
        }

        return Column(
            children: [
                Text(
                    'Why Choose Propmize?',
                    style: context.textTheme.displayMedium?.copyWith(
                        fontSize: isMobile ? 22 : 26
                    )
                ),
                const SizedBox(height: 12),
                Text(
                    'Experience the future of real estate with our innovative platform designed for modern property transactions.',
                    style: context.textTheme.bodyMedium?.copyWith(
                        fontSize: isMobile ? 14 : 16
                    ),
                    textAlign: TextAlign.center
                ),
                const SizedBox(height: 24),
                GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: childAspectRatio,
                    children: [
                        MessageCardItem(
                            leadingData: Icons.electric_bolt,
                            leadingSvg: "",
                            isSvg: false,
                            title: "AI-Powered Insights",
                            message: "Get intelligent property recommendations and market analysis powered by advanced AI algorithms.",
                            color: AppColors.primary
                        ),
                        MessageCardItem(
                            leadingData: Icons.shield_outlined,
                            leadingSvg: "",
                            isSvg: false,
                            title: "Verified Community",
                            message: "Connect with authenticated buyers and sellers in a secure, trusted marketplace environment.",
                            color: Colors.green
                        ),
                        MessageCardItem(
                            leadingData: Icons.abc,
                            leadingSvg: "assets/icons/trend.svg",
                            isSvg: true,
                            title: "Real-Time Analytics",
                            message: "Access live market data, pricing trends, and property insights to make informed decisions.",
                            color: Colors.deepPurple
                        )
                    ]
                )
            ]
        );
    }
}

*/
