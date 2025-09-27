import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/core/utils/responsice_media_query/responsive_helper.dart';
import 'package:prop_mize/app/global_widgets/message_card_item.dart';
import '../../../global_widgets/choice_client_seller_btn.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController>
{
    const HomeView({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Image.asset('assets/images/logo.png', width: 40),
                        const SizedBox(width: 8),
                        const Text('PropMize')
                    ]
                ),
                centerTitle: true
            ),
            body: ListView(
                padding: EdgeInsets.all(16),
                children: [
                    Column(
                        spacing: 12,
                        children: [
                            Text(
                                '😎',
                                style: TextStyle(
                                    fontSize: 60
                                )
                            ),
                            Text(
                                'What\'s on your mind?',
                                style: context.textTheme.displayMedium
                            ),
                            Text(
                                'Discover your perfect property with AI-powered insights. Connect with verified buyers and sellers in a trusted marketplace.',
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodyMedium
                            ),

                            LayoutBuilder(builder: (context, constraints) {
                              // Use 1 column for small screens, 2 for larger screens
                              int crossAxisCount = constraints.maxWidth < 600 ? 1 : 2;

                              return GridView.count(
                                shrinkWrap: true, // ✅ yeh zaroori hai
                                physics: const NeverScrollableScrollPhysics(), // ✅ scroll disable
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: constraints.maxWidth < 600 ? 4 : 4,
                                children: [
                                  ChoiceClientSellerBtn(
                                    leadingIcon: Icons.search,
                                    title: "Buy / Rent Properties",
                                    subtitle: "Find your dream home or apartment",
                                    onTap: controller.navigateHomeToAssistantChat,
                                  ),
                                  ChoiceClientSellerBtn(
                                    leadingIcon: Icons.home_work_outlined,
                                    title: "Sell / Rent Property",
                                    subtitle: "List your property & reach genuine buyers/tenants",
                                    onTap: () {
                                      AppHelpers.showSnackBar(icon: CupertinoIcons.bell,title: "Sell / Rent Property", message: "Coming Soon");
                                    },
                                  ),
                                ],
                              );
                            }),

                            /*ChoiceClientSellerBtn(
                                leadingIcon: Icons.search,
                                title: "Buy / Rent Properties",
                                subtitle: "Find your dream home or apartment",
                                onTap: ()
                                {
                                    controller.navigateHomeToAssistantChat();
                                }
                            ),
                            ChoiceClientSellerBtn(
                                leadingIcon: Icons.home_work_outlined,
                                title: "Sell / Rent Property",
                                subtitle: "List your property & reach genuine buyers/tenants",
                                onTap: ()
                                {
                                    Get.snackbar(
                                        "Sell / Rent Property",
                                        "Coming Soon",
                                        snackPosition: SnackPosition.BOTTOM
                                    );
                                }
                            ),*/

                            SizedBox(height: 50),
                            Text(
                                'Why Choose Propmize?',
                                style: context.textTheme.displayMedium
                            ),

                            Text(
                                'Experience the future of real estate with our innovative platform designed for modern property transactions.',
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodyMedium
                            ),

                            SizedBox(height: 24),

                            GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: ResponsiveHelper.getCrossAxisCount(context),
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 6 / 4,
                                children: [
                                    MessageCardItem(leadingData: Icons.electric_bolt, leadingSvg: "", isSvg: false, title: "AI-Powered Insights", message: "Get intelligent property recommendations and market analysis powered by advanced AI algorithms.", color: AppColors.primary),
                                    MessageCardItem(leadingData: Icons.shield_outlined, leadingSvg: "", isSvg: false, title: "Verified Community", message: "Connect with authenticated buyers and sellers in a secure, trusted marketplace environment.", color: Colors.green),
                                    MessageCardItem(leadingData: Icons.abc, leadingSvg: "assets/svg_icons/trend.svg", isSvg: true, title: "Real-Time Analytics", message: "Access live market data, pricing trends, and property insights to make informed decisions.", color: Colors.deepPurple)
                                ]
                            )

                          /*MessageCardItem(leadingData: Icons.electric_bolt, leadingSvg: "", isSvg: false, title: "AI-Powered Insights", message: "Get intelligent property recommendations and market analysis powered by advanced AI algorithms.", color: AppColors.primary),
                            MessageCardItem(leadingData: Icons.shield_outlined, leadingSvg: "", isSvg: false, title: "Verified Community", message: "Connect with authenticated buyers and sellers in a secure, trusted marketplace environment.", color: Colors.green),
                            MessageCardItem(leadingData: Icons.abc, leadingSvg: "assets/svg_icons/trend.svg", isSvg: true, title: "Real-Time Analytics", message: "Access live market data, pricing trends, and property insights to make informed decisions.", color: Colors.deepPurple)*/
                        ]
                    )
                ]
            )
        );
    }
}

/*

Container(
                padding: const EdgeInsets.only(top: 0, bottom: 100, left: 16, right: 16),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        // Bounce Animation for Avatar
                        InfiniteBounceAnimation(
                            child: Text(
                                '😎',
                                style: TextStyle(
                                    fontSize: 60
                                )
                            )
                        ),

                        Text(
                            'What\'s on your mind?',
                            style: context.textTheme.displayMedium
                        ),

                        Text(
                            'Discover your perfect property with AI-powered insights. Connect with verified buyers and sellers in a trusted marketplace.',
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyMedium
                        ),

                        ChoiceClientSellerBtn(
                            leadingIcon: Icons.search,
                            title: "Buy / Rent Properties",
                            subtitle: "Find your dream home or apartment",
                            onTap: ()
                            {
                                controller.navigateHomeToAssistantChat();
                            }
                        ),
                        ChoiceClientSellerBtn(
                            leadingIcon: Icons.home_work_outlined,
                            title: "Sell / Rent Property",
                            subtitle: "List your property & reach genuine buyers/tenants",
                            onTap: ()
                            {
                                Get.snackbar(
                                    "Sell / Rent Property",
                                    "Coming Soon",
                                    snackPosition: SnackPosition.BOTTOM
                                );
                            }
                        )

                    ]
                )
            )
 */
