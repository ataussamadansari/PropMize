import 'package:get/get.dart';
import 'package:prop_mize/app/modules/seller_modules/edit_sell_rent_property_screen/views/edit_sell_rent_property_view.dart';
import 'package:prop_mize/app/modules/seller_modules/lead_details_screen/bindings/lead_details_binding.dart';
import 'package:prop_mize/app/modules/seller_modules/lead_details_screen/views/lead_details_view.dart';
import '../modules/buyer_modules/buyer_home_screen/bindings/buyer_main_binding.dart';
import '../modules/buyer_modules/buyer_home_screen/views/buyer_main_view.dart';
import '../modules/buyer_modules/buyer_guide_screen/bindings/buyer_guide_binding.dart';
import '../modules/buyer_modules/buyer_guide_screen/views/buyer_guide_view.dart';
import '../modules/buyer_modules/recent_viewed_screen/bindings/recent_viewed_binding.dart';
import '../modules/buyer_modules/recent_viewed_screen/views/recent_viewed_view.dart';
import '../modules/seller_modules/analytics_screen/bindings/analytics_binding.dart';
import '../modules/seller_modules/analytics_screen/views/analytics_view.dart';
import '../modules/seller_modules/edit_sell_rent_property_screen/bindings/edit_sell_rent_property_binding.dart';
import '../modules/seller_modules/leads_screen/bindings/leads_binding.dart';
import '../modules/seller_modules/leads_screen/views/leads_view.dart';
import '../modules/seller_modules/my_property_screen/bindings/my_property_binding.dart';
import '../modules/seller_modules/my_property_screen/views/my_property_view.dart';
import '../modules/seller_modules/plans_screen/bindings/plans_binding.dart';
import '../modules/seller_modules/plans_screen/views/plans_view.dart';
import '../modules/seller_modules/sell_rent_property_screen/bindings/sell_rent_property_binding.dart';
import '../modules/seller_modules/sell_rent_property_screen/views/sell_rent_property_view.dart';
import '../modules/seller_modules/seller_guide_screen/bindings/seller_guide_binding.dart';
import '../modules/seller_modules/seller_guide_screen/views/seller_guide_view.dart';
import '../modules/common_modules/help_and_support_screen/bindings/help_and_support_binding.dart';
import '../modules/common_modules/help_and_support_screen/views/help_and_support_view.dart';

import '../modules/buyer_modules/assistant_chat_screen/bindings/assistant_chat_binding.dart';
import '../modules/buyer_modules/assistant_chat_screen/views/assistant_chat_view.dart';
import '../modules/buyer_modules/contacted_screen/bindings/contacted_binding.dart';
import '../modules/buyer_modules/contacted_screen/views/contacted_view.dart';
import '../modules/buyer_modules/saved_properties_screen/bindings/saved_properties_binding.dart';
import '../modules/buyer_modules/saved_properties_screen/views/saved_properties_view.dart';
import '../modules/common_modules/all_listing_screen/bindings/all_listing_binding.dart';
import '../modules/common_modules/all_listing_screen/views/all_listing_view.dart';
import '../modules/common_modules/home_screen/bindings/home_bindings.dart';
import '../modules/common_modules/home_screen/views/home_view.dart';
import '../modules/common_modules/notification_screen/bindings/notification_binding.dart';
import '../modules/common_modules/notification_screen/views/v1/notification_view.dart';
import '../modules/common_modules/product_details_screen/bindings/product_details_binding.dart';
import '../modules/common_modules/product_details_screen/views/product_details_view.dart';
import '../modules/common_modules/profile_screen/bindings/profile_binding.dart';
import '../modules/common_modules/profile_screen/views/profile_view.dart';
import '../modules/common_modules/splash_screen/bindings/splash_bindings.dart';
import '../modules/common_modules/splash_screen/views/splash_view.dart';
import '../modules/seller_modules/dashboard_screen/bindings/dashboard_binding.dart';
import '../modules/seller_modules/dashboard_screen/views/dashboard_view.dart';
import '../modules/seller_modules/seller_main_screen/bindings/seller_main_binding.dart';
import '../modules/seller_modules/seller_main_screen/views/seller_main_view.dart';
import 'app_routes.dart';

class AppPages
{
    static final routes = [

        /// Common -
        GetPage(name: Routes.allListing, page: () => AllListingView(isSeller: true), binding: AllListingBinding()),
        GetPage(name: Routes.helpAndSupport, page: () => HelpAndSupportView(), binding: HelpAndSupportBinding()),
        GetPage(name: Routes.home, page: () => HomeView(), binding: HomeBinding()),
        GetPage(name: Routes.notification, page: () => NotificationView(), binding: NotificationBinding()),
        GetPage(name: Routes.productDetails, page: () => ProductDetailsView(), binding: ProductDetailsBinding()),
        GetPage(name: Routes.profile, page: () => ProfileView(), binding: ProfileBinding()),
        GetPage(name: Routes.splash, page: () => SplashView(), binding: SplashBinding()),

        /// Buyer -
        GetPage(name: Routes.buyerMain, page: () => BuyerMainView(), binding: BuyerMainBinding()),
        GetPage(name: Routes.assistantChat, page: () => AssistantChatView(), binding: AssistantChatBinding()),
        GetPage(name: Routes.buyerGuide, page: () => BuyerGuideView(), binding: BuyerGuideBinding()),
        GetPage(name: Routes.contacted, page: () => ContactedView(), binding: ContactedBinding()),
        GetPage(name: Routes.recentViewed, page: () => RecentViewedView(), binding: RecentViewedBinding()),
        GetPage(name: Routes.saveProperties, page: () => SavedPropertiesView(), binding: SavedPropertiesBinding()),

        /// Seller -
        GetPage(name: Routes.sellerMain, page: () => SellerMainView(), binding: SellerMainBinding()),
        GetPage(name: Routes.analytics, page: () => AnalyticsView(), binding: AnalyticsBinding()),
        GetPage(name: Routes.dashboard, page: () => DashboardView(), binding: DashboardBinding()),
        GetPage(name: Routes.leads, page: () => LeadsView(), binding: LeadsBinding()),
        GetPage(name: Routes.leadDetails, page: () => LeadDetailsView(), binding: LeadDetailsBinding()),
        GetPage(name: Routes.myProperty, page: () => MyPropertyView(), binding: MyPropertyBinding()),
        GetPage(name: Routes.plans, page: () => PlansView(), binding: PlansBinding()),
        GetPage(name: Routes.sellRentProperty, page: () => SellRentPropertyView(), binding: SellRentPropertyBinding()),
        GetPage(name: Routes.editSellRentProperty, page: () => EditSellRentPropertyView(), binding: EditSellRentPropertyBinding()),
        GetPage(name: Routes.sellerGuide, page: () => SellerGuideView(), binding: SellerGuideBinding()),
    ];
}
