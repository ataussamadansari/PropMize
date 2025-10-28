import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/properties/properties_repository.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/properties/data.dart';
import '../../../modules/common_modules/auth_screen/views/auth_bottom_sheet.dart';
import '../storage/current_user_id_services.dart';

class LikeService extends GetxService
{
    final PropertiesRepository _repo = PropertiesRepository();

    final RxMap<String, bool> likedStatus = <String, bool>{}.obs;

    // String? get currentUserId => StorageServices.to.read("userId");
    String? get currentUserId => Get.find<CurrentUserIdServices>().userId.value;

    bool isLiked(String propertyId)
    {
        return likedStatus[propertyId] ?? false;
    }

    Future<void> toggleLike(Data property) async
    {
        if (currentUserId == null) 
        {
            AppHelpers.showSnackBar(
                title: "Error",
                message: "Please login to like",
                isError: true,
                actionLabel: 'Login',
                onActionTap: () =>
                Get.bottomSheet(
                    AuthBottomSheet(),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent
                )
            );
            return;
        }

        final previous = isLiked(property.id!);
        likedStatus[property.id!] = !previous; // Optimistic update

        try
        {
            final response = await _repo.like(property.id!);
            if (!response.success) 
            {
                // rollback
                likedStatus[property.id!] = previous;
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: response.message,
                    isError: true
                );
            }
            else 
            {
                AppHelpers.showSnackBar(
                    title: "Property",
                    message: !previous ? "Liked successfully" : "Disliked successfully",
                    isError: previous // if previously liked then this is dislike
                );
            }
        }
        catch (e)
        {
            likedStatus[property.id!] = previous;
            AppHelpers.showSnackBar(
                title: "Error",
                message: e.toString(),
                isError: true
            );
        }
    }

    /// Sync with property object (for list controllers)
    void syncWithProperty(Data property) 
    {
        likedStatus[property.id!] = property.likedBy?.any((like) => like.user == currentUserId) ?? false;
    }

    // Clear all like states when user logs out
    void clearLikeStates() {
        likedStatus.clear();
    }
}
