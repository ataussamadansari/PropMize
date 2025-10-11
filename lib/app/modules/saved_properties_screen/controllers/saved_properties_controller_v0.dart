// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:prop_mize/app/data/repositories/properties/properties_repository.dart';
//
// import '../../../data/models/properties/data.dart';
// import '../../../data/services/like_services.dart';
// import '../../../data/services/storage_services.dart';
//
// class SavedPropertiesController extends GetxController {
//   final PropertiesRepository _propertiesRepository = PropertiesRepository();
//   final LikeService likeService = Get.find<LikeService>();
//
//   // Properties
//   final RxList<Data> properties = <Data>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxBool isLoadMore = false.obs;
//   final RxBool hasMore = true.obs;
//   final RxInt currentPage = 1.obs;
//   final RxString errorMessage = ''.obs;
//   final RxBool hasError = false.obs;
//
//   // current user id
//   final currentUserId = StorageServices.to.read("userId");
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadLikedProperties();
//
//     ever(likeService.likedStatus, (_) {
//       properties.removeWhere((p) => !likeService.isLiked(p.id!));
//     });
//   }
//
//   Future<void> loadLikedProperties({bool reset = true}) async {
//     try {
//       if (reset) {
//         isLoading.value = true;
//         currentPage.value = 1;
//         properties.clear();
//         hasMore.value = true;
//       }
//
//       hasError.value = false;
//       errorMessage.value = '';
//
//       final response = await _propertiesRepository.getLikedProperties(
//         page: currentPage.value,
//         limit: 10,
//       );
//
//       if (response.success && response.data != null) {
//         final newProperties = response.data!.data ?? [];
//
//         // sync with global like service
//         for (var p in newProperties) {
//           likeService.syncWithProperty(p);
//         }
//
//         if (reset) {
//           properties.value = newProperties;
//         } else {
//           properties.addAll(newProperties);
//         }
//
//         hasMore.value = newProperties.length == 10;
//
//         debugPrint('✅ Properties loaded successfully: ${properties.length}');
//       } else {
//         hasError.value = true;
//         errorMessage.value = response.message;
//         debugPrint('❌ Error in response: ${response.message}');
//       }
//     } catch (e, stackTrace) {
//       debugPrint('❌ Error in loadLikedProperties: $e');
//       debugPrint('📋 Stack trace: $stackTrace');
//
//       hasError.value = true;
//
//       errorMessage.value = 'Failed to load properties: ${e.toString()}';
//     } finally {
//       isLoading.value = false;
//       isLoadMore.value = false;
//     }
//   }
//
//   // ---------------- LOAD MORE ----------------
//   Future<void> loadMoreProperties() async {
//     if (isLoadMore.value || !hasMore.value) return;
//
//     try {
//       isLoadMore.value = true;
//       currentPage.value++;
//       await loadLikedProperties(reset: false);
//     } catch (e) {
//       currentPage.value--;
//       hasError.value = true;
//       errorMessage.value = e.toString();
//     } finally {
//       isLoadMore.value = false;
//     }
//   }
//
//
//   // ---------- Like - Dislike ----------
//
//   /*// Add this method to check like status for a specific property
//   bool isPropertyLiked(Data property) {
//     return property.likedBy?.any((like) => like.user == currentUserId) ?? false;
//   }
//
//   // Update the toggleLike method
//   void toggleLike(String productId, int index) async
//   {
//     if (properties.isEmpty) return;
//     if (currentUserId == null)
//     {
//       AppHelpers.showSnackBar(
//           title: "Error",
//           message: "Please login to like",
//           isError: true,
//           actionLabel: "Login"
//       );
//       return;
//     }
//
//     // Find the property and get current like status
//     final propertyIndex = properties.indexWhere((p) => p.id == productId);
//     if (propertyIndex == -1) return;
//
//     final property = properties[propertyIndex];
//     final previousStatus = isPropertyLiked(property);
//
//     try
//     {
//       final response = await _propertiesRepository.like(productId);
//       if (!response.success)
//       {
//         AppHelpers.showSnackBar(
//             title: "Error",
//             message: response.message,
//             isError: true
//         );
//       }
//       else
//       {
//         // Update the local likedBy array to reflect the change
//         if (previousStatus) {
//           // Remove like
//           property.likedBy?.removeWhere((like) => like.user == currentUserId);
//         } else {
//           // Add like
//           property.likedBy ??= [];
//           property.likedBy!.add(LikedBy(user: currentUserId));
//         }
//
//         // Force UI update by reassigning the list
//         properties[propertyIndex] = property;
//         properties.refresh();
//
//         loadLikedProperties(reset: true);
//
//         AppHelpers.showSnackBar(
//             title: "Property",
//             message: !previousStatus ? "Liked successfully" : "Disliked successfully",
//             isError: !previousStatus ? false : true
//         );
//       }
//     }
//     catch (e)
//     {
//       AppHelpers.showSnackBar(
//           title: "error",
//           message: e.toString(),
//           isError: true
//       );
//     }
//   }
//
//   // Add this method to update like status from other screens
//   void updateLikeStatus({required String propertyId, required bool isLiked}) {
//     if (!isLiked) {
//       // If property is unliked, remove it from saved properties
//       final propertyIndex = properties.indexWhere((p) => p.id == propertyId);
//       if (propertyIndex != -1) {
//         properties.removeAt(propertyIndex);
//         properties.refresh();
//       }
//     } else {
//       // If property is liked, we might want to add it to saved properties
//       // But we don't have the full property data here, so we'll reload
//       loadLikedProperties(reset: true);
//     }
//   }
//
//   // Refresh the entire list
//   void refreshSavedProperties() {
//     loadLikedProperties(reset: true);
//   }*/
//
//
//   // ------------ Navigation -----------------
//   void navigateToPropertyDetails(String propertyId) {
//     Get.toNamed('/product/$propertyId');
//   }
// }