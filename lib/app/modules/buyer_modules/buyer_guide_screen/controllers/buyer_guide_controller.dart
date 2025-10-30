import 'package:get/get.dart';

class BuyerGuideController extends GetxController {
  final List<String> favoriteSections = <String>[].obs;

  void toggleFavorite(String section) {
    if (favoriteSections.contains(section)) {
      favoriteSections.remove(section);
    } else {
      favoriteSections.add(section);
    }
  }
}
