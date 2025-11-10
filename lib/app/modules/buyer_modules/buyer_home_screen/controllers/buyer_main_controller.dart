import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/buyer_modules/assistant_chat_screen/controllers/assistant_chat_controller.dart';
import 'package:prop_mize/app/modules/buyer_modules/assistant_chat_screen/views/assistant_chat_view.dart';
import 'package:prop_mize/app/modules/buyer_modules/contacted_screen/views/contacted_view.dart';
import 'package:prop_mize/app/modules/buyer_modules/recent_viewed_screen/views/recent_viewed_view.dart';
import 'package:prop_mize/app/modules/buyer_modules/saved_properties_screen/views/saved_properties_view.dart';
import 'package:prop_mize/app/modules/common_modules/all_listing_screen/views/all_listing_view.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

import '../../../../data/services/storage/storage_services.dart';
import '../../../common_modules/auth_screen/controllers/auth_controller.dart';
import '../../../common_modules/auth_screen/views/auth_bottom_sheet.dart';

class BuyerMainController extends GetxController {

    // ===== Dependencies =====
    final AuthController authController = Get.find<AuthController>();
    final AssistantChatController assistantChatController = Get.find<AssistantChatController>();

    // ===== Keys =====
    final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

    // ===== Variables =====
    final isBottomNavVisible = true.obs;
    final currentIndex = 2.obs;

    // Scroll handling
    bool isScrollingDown = false;
    double lastScrollOffset = 0.0;
    final double _scrollThreshold = 10.0;

    // ===== Computed Getters =====
    RxString get currentUserId => StorageServices.to.userId;

    // Track if user has scrolled
    bool _hasUserScrolled = false;

    // Auto-hide timer (3 seconds) - only active after scrolling
    Timer? _autoHideTimer;
    final Duration _autoHideDuration = const Duration(seconds: 3);

    final List<Widget> pages = [
        ContactedView(),
        SavedPropertiesView(),
        AssistantChatView(),
        RecentViewedView(),
        AllListingView(),
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

    void showAuthBottomSheet()
    {
        Get.bottomSheet(
            AuthBottomSheet(),
            isScrollControlled: true
        );
    }


    // ===== Navigation Methods =====

    void gotoNotificationScreen() {
        Get.toNamed(Routes.notification);
    }

    void goToProductDetails(String id) => Get.toNamed('/product/$id');
    void goToAllListing() => Get.toNamed(Routes.allListing);
    void goToSavedProperties() => Get.toNamed(Routes.saveProperties);
    void goToContacted() => Get.toNamed(Routes.contacted);
    void goToProfile() => Get.toNamed(Routes.profile);
    void goToBuyerGuide() => Get.toNamed(Routes.buyerGuide);
    void goToHelpSupport() => Get.toNamed(Routes.helpAndSupport);

    @override
    void onClose() {
        _cancelAutoHideTimer();
        super.onClose();
    }
}


