import 'package:get/get.dart';

import 'storage_services.dart';

class CurrentUserIdServices extends GetxService
{
  // String? get currentUserId => StorageServices.to.read("userId");
  final RxnString userId = RxnString();

  @override
  void onInit() {
    super.onInit();
    // initialize with storage value
    userId.value = StorageServices.to.read("userId");
  }

  void setUserId(String? id) {
    if (id == null) {
      StorageServices.to.remove("userId");
    } else {
      StorageServices.to.write("userId", id);
    }
    userId.value = id; // update reactive value
  }

  // Call this method when user logs out
  void clearUserId() {
    userId.value = null; // clear reactive value
    StorageServices.to.removeUserId();
  }
}