import "package:get/get.dart";

enum MarkerType { parties, bars, restaurants }

class DashboardController extends GetxController {
  var tabIndex = 0.obs;

  var selectedMarkers = <MarkerType>{}.obs;

  void selectMarker(MarkerType type) {
    if (selectedMarkers.contains(type)) {
      selectedMarkers.remove(type);
    } else {
      selectedMarkers.add(type);
    }
  }

  void navigateToHome() {
    tabIndex.value = 0;
    update();
  }

  void navigateToMessages() {
    selectedMarkers.clear();
    tabIndex.value = 1;
    update();
  }

  void navigateToPin() {
    selectedMarkers.clear();
    tabIndex.value = 2;
    update();
  }
}
