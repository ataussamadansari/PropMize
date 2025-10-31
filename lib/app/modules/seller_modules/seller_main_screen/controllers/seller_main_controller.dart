import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/seller_modules/analytics_screen/views/analytics_view.dart';
import 'package:prop_mize/app/modules/seller_modules/dashboard_screen/views/dashboard_view.dart';
import 'package:prop_mize/app/modules/seller_modules/leads_screen/views/leads_view.dart';
import 'package:prop_mize/app/modules/seller_modules/my_property_screen/views/my_property_view.dart';
import 'package:prop_mize/app/modules/seller_modules/sell_rent_property_screen/views/sell_rent_property_view.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/services/storage/storage_services.dart';
import '../../../common_modules/auth_screen/controllers/auth_controller.dart';


class SellerMainController extends GetxController {

  // ===== Dependencies =====
  final AuthController authController = Get.find<AuthController>();

  // ===== Keys =====
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  // ===== Variables =====
  final isBottomNavVisible = true.obs;
  final currentIndex = 0.obs;
  RxBool isLoading = false.obs;

  // Scroll handling
  bool isScrollingDown = false;
  double lastScrollOffset = 0.0;
  final double _scrollThreshold = 10.0;

  // ===== Computed Getters =====
  RxString get currentUserId => StorageServices.to.userId;
  bool get isLoggedIn => currentUserId.isNotEmpty;

  // Track if user has scrolled
  bool _hasUserScrolled = false;

  // Auto-hide timer (3 seconds) - only active after scrolling
  Timer? _autoHideTimer;
  final Duration _autoHideDuration = const Duration(seconds: 3);

  @override
  void onInit() {
    super.onInit();
    _initializeAfterBuild();
  }

  void _initializeAfterBuild()
  {
    Future.delayed(Duration.zero, () async
    {
      await _loadUserProfile();
    });
  }
  /// Load user profile (if token available) and then load chat history.
  Future<void> _loadUserProfile() async
  {
    try
    {
      isLoading.value = true;

      final token = StorageServices.to.getToken();
      if (token != null && token.isNotEmpty)
      {
        // call your auth controller to fetch profile (await optional)
        await authController.me();
      }
    }
    catch (e)
    {
      // show a friendly error and keep the controller stable
      AppHelpers.showSnackBar(title: "Error", message: e.toString(), isError: true);
    }
    finally {
      isLoading.value = false;
    }
  }


  final List<Widget> pages = [
    DashboardView(),
    LeadsView(),
    SellRentPropertyView(),
    MyPropertyView(),
    AnalyticsView()
  ];

  void onUserInteraction() {
    _showBottomNav();
    _cancelAutoHideTimer();

    // only restart timer if user has scrolled before
    if (_hasUserScrolled) {
      _startAutoHideTimer();
    }
  }
  void handleScrollNotification(ScrollNotification scrollInfo) {
    // If scrollable area smaller than viewport → no hiding logic
    if (scrollInfo.metrics.maxScrollExtent <= 0) {
      _showBottomNav();
      _cancelAutoHideTimer();
      return;
    }

    if (scrollInfo is ScrollUpdateNotification) {
      final currentScrollOffset = scrollInfo.metrics.pixels;
      final delta = currentScrollOffset - lastScrollOffset;

      _hasUserScrolled = true;

      if (currentScrollOffset <= 0) {
        _cancelAutoHideTimer();
        _showBottomNav();
        lastScrollOffset = currentScrollOffset;
        return;
      }

      if (delta.abs() < _scrollThreshold) {
        lastScrollOffset = currentScrollOffset;
        return;
      }

      if (delta > 0 && !isScrollingDown) {
        isScrollingDown = true;
        _cancelAutoHideTimer();
        _hideBottomNav();
      } else if (delta < 0 && isScrollingDown) {
        isScrollingDown = false;
        _showBottomNav();
        if (_hasUserScrolled) {
          _startAutoHideTimer();
        }
      }

      lastScrollOffset = currentScrollOffset;
    } else if (scrollInfo is ScrollEndNotification) {
      if (!isScrollingDown && _hasUserScrolled) {
        _startAutoHideTimer();
      }
    }
  }


  void _startAutoHideTimer() {
    _cancelAutoHideTimer();
    _autoHideTimer = Timer(_autoHideDuration, () {
      // only hide if currently visible and user has scrolled before
      if (isBottomNavVisible.value && _hasUserScrolled) {
        _hideBottomNav();
      }
    });
  }

  void _cancelAutoHideTimer() {
    _autoHideTimer?.cancel();
    _autoHideTimer = null;
  }

  void _hideBottomNav() {
    if (isBottomNavVisible.value) {
      isBottomNavVisible.value = false;
    }
  }

  void _showBottomNav() {
    if (!isBottomNavVisible.value) {
      isBottomNavVisible.value = true;
    }
  }

  void changePage(int index) {
    currentIndex.value = index;
    _showBottomNav();
    _cancelAutoHideTimer();

    // When changing pages, don't start auto-hide timer immediately
    // Only start if user has scrolled before
    if (_hasUserScrolled) {
      _startAutoHideTimer();
    }
  }

  // Call this when user interacts with bottom nav directly
  void onBottomNavInteracted() {
    _showBottomNav();
    _cancelAutoHideTimer();

    // Only start auto-hide timer if user has scrolled before
    if (_hasUserScrolled) {
      _startAutoHideTimer();
    }
  }

  // Reset scroll state when needed (optional)
  void resetScrollState() {
    _hasUserScrolled = false;
    _cancelAutoHideTimer();
  }

  void logout() {
    bool res = authController.logout();
    if(res) {
      gotoHome();
    }
  }


  // ===== Navigation Methods =====
  void gotoHome() => Get.offAllNamed(Routes.home);
  void gotoNotificationScreen() => Get.toNamed(Routes.notification);
  void goToProductDetails(String id) => Get.toNamed('/product/$id');
  void goToAllListing() => Get.toNamed(Routes.allListing);
  void goToProfile() => Get.toNamed(Routes.profile);
  void goToSellerGuide() => Get.toNamed(Routes.sellerGuide);
  void goToHelpSupport() => Get.toNamed(Routes.helpAndSupport);

  void viewAllInquiries() => currentIndex.value = 1;
  void gotoAddProperty() => currentIndex.value = 2;
  void viewAllMyProperties() => currentIndex.value = 3;

}
