import 'package:get/get.dart';
import 'package:prop_mize/app/modules/all_listing_screen/bindings/all_listing_binding.dart';
import 'package:prop_mize/app/modules/all_listing_screen/views/all_listing_view.dart';
import 'package:prop_mize/app/modules/auth_screen/bindings/auth_binding.dart';
import 'package:prop_mize/app/modules/auth_screen/views/auth_view.dart';
import 'package:prop_mize/app/modules/product_details_screen/bindings/product_details_binding.dart';
import 'package:prop_mize/app/modules/product_details_screen/views/product_details_view.dart';

import 'package:prop_mize/app/routes/app_routes.dart';
import '../modules/assistant_chat_screen/bindings/assistant_chat_binding.dart';
import '../modules/assistant_chat_screen/views/assistant_chat_view.dart';
import '../modules/home_screen/bindings/home_bindings.dart';
import '../modules/home_screen/views/home_view.dart';
import '../modules/profile_screen/bindings/profile_binding.dart';
import '../modules/profile_screen/views/profile_view.dart';
import '../modules/splash_screen/bindings/splash_bindings.dart';
import '../modules/splash_screen/views/splash_view.dart';

class AppPages
{
    static final routes = [
        GetPage(name: Routes.splash, page: () => SplashView(), binding: SplashBinding()),
        GetPage(name: Routes.auth, page: () => AuthView(), binding: AuthBinding()),
        GetPage(name: Routes.home, page: () => HomeView(), binding: HomeBinding()),
        GetPage(name: Routes.assistantChat, page: () => AssistantChatView(), binding: AssistantChatBinding()),
        GetPage(name: Routes.profile, page: () => ProfileView(), binding: ProfileBinding()),
        GetPage(name: Routes.allListing, page: () => AllListingView(), binding: AllListingBinding()),
        GetPage(name: Routes.productDetails, page: () => ProductDetailsView(), binding: ProductDetailsBinding())
    ];
}
