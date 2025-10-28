import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/properties/properties_repository.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/properties/data.dart';
import '../../../modules/common_modules/auth_screen/views/auth_bottom_sheet.dart';
import '../storage/current_user_id_services.dart';
import 'liked_properties_service.dart';


class LikeService extends GetxService {
    final PropertiesRepository _repo = PropertiesRepository();

    /// Stores propertyId → liked(true/false)
    final RxMap<String, bool> likedStatus = <String, bool>{}.obs;

    /// Used to notify listeners of individual like/unlike events
    final RxnString lastToggledPropertyId = RxnString();

    final LikedPropertiesService likedPropertiesService = Get.find<LikedPropertiesService>(); // 🔥 NEW

    String? get currentUserId => Get.find<CurrentUserIdServices>().userId.value;

    bool isLiked(String propertyId) {
        return likedStatus[propertyId] ?? false;
    }

    /// Toggle like/unlike status for a property
    /// Toggle like/unlike status for a property
    Future<void> toggleLike(Data property) async {
        if (currentUserId == null) {
            AppHelpers.showSnackBar(
                title: "Error",
                message: "Please login to like",
                isError: true,
                actionLabel: 'Login',
                onActionTap: () => Get.bottomSheet(
                    const AuthBottomSheet(),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                ),
            );
            return;
        }

        final previous = isLiked(property.id!);
        final newStatus = !previous;

        // 🔥 Optimistic update
        likedStatus[property.id!] = newStatus;

        lastToggledPropertyId.value = property.id; // 🔥 Notify controller

        // 🔥 NEW: Immediately update liked properties list
        if (newStatus) {
            likedPropertiesService.addLikedProperty(property);
        } else {
            likedPropertiesService.removeLikedProperty(property.id!);
        }

        try {
            final response = await _repo.like(property.id!);

            if (!response.success) {
                // Rollback on failure
                likedStatus[property.id!] = previous;
                if (newStatus) {
                    likedPropertiesService.removeLikedProperty(property.id!);
                } else {
                    likedPropertiesService.addLikedProperty(property);
                }
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: response.message,
                    isError: true,
                );
            } else {
                AppHelpers.showSnackBar(
                    title: "Property",
                    message: newStatus ? "Liked successfully" : "Disliked successfully",
                    isError: !newStatus,
                );
            }
        } catch (e) {
            // Rollback on error
            likedStatus[property.id!] = previous;
            if (newStatus) {
                likedPropertiesService.removeLikedProperty(property.id!);
            } else {
                likedPropertiesService.addLikedProperty(property);
            }
            AppHelpers.showSnackBar(
                title: "Error",
                message: e.toString(),
                isError: true,
            );
        }
    }
    /*Future<void> toggleLike(Data property) async {
        if (currentUserId == null) {
            AppHelpers.showSnackBar(
                title: "Error",
                message: "Please login to like",
                isError: true,
                actionLabel: 'Login',
                onActionTap: () => Get.bottomSheet(
                    const AuthBottomSheet(),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                ),
            );
            return;
        }

        final previous = isLiked(property.id!);
        likedStatus[property.id!] = !previous; // Optimistic update
        // lastToggledPropertyId.value = property.id; // 🔥 Notify controller


        try {
            final response = await _repo.like(property.id!);

            if (!response.success) {
                // Rollback
                likedStatus[property.id!] = previous;
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: response.message,
                    isError: true,
                );
            } else {
                AppHelpers.showSnackBar(
                    title: "Property",
                    message: !previous
                        ? "Liked successfully"
                        : "Disliked successfully",
                    isError: previous, // Show red if unliked
                );
            }
        } catch (e) {
            likedStatus[property.id!] = previous;
            AppHelpers.showSnackBar(
                title: "Error",
                message: e.toString(),
                isError: true,
            );
        }
    }*/

    /// Sync like status from property object (for list controllers)
    void syncWithProperty(Data property) {
        likedStatus[property.id!] =
            property.likedBy?.any((like) => like.user == currentUserId) ?? false;
    }

    /// Clear all likes on logout
    void clearLikeStates() {
        likedStatus.clear();
        lastToggledPropertyId.value = null;
    }
}
