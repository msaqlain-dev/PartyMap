// import 'package:get/get.dart';
// import 'package:partymap/Screens/home/mapbox_service.dart';

// class LocationSearchController extends GetxController {
//   final MapboxService mapboxService = MapboxService();
//   var suggestions = <String>[].obs;

//   var showSuggestions = false.obs;

//   void searchLocation(String query) async {
//     if (query.isNotEmpty) {
//       final result = await mapboxService.getSuggestions(query);
//       suggestions.assignAll(result);
//       showSuggestions.value = true; // Show suggestions
//     } else {
//       suggestions.clear();
//       showSuggestions.value = false; // Hide suggestions
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:partymap/Screens/home/widgets/venue_details.dart';

class LocationSearchController extends GetxController {
  // Assume venues is your list of Venue objects
  List<VenueDetails> venues = [
    VenueDetails(
      name: "Drai's Beachclub & Nightclub",
      latitude: 36.11509362417488,
      longitude: -115.17217125911195,
    ),
    VenueDetails(
        name: "Arc Bar",
        latitude: 36.11244019665051,
        longitude: -115.17255939774128),
    VenueDetails(
      name: "Hell's Kitchen",
      latitude: 36.11572852007753,
      longitude: -115.17323234620663,
    ),
  ]; // This should be populated with your actual venue data
  var suggestions = <VenueDetails>[].obs; // Change to hold Venue objects

  var showSuggestions = false.obs;

  void searchLocation(String query) {
    if (query.isNotEmpty) {
      // Filter venues by whether their name contains the query
      final result = venues
          .where(
              (venue) => venue.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      suggestions.assignAll(result);
      showSuggestions.value = true; // Show suggestions
    } else {
      suggestions.clear();
      showSuggestions.value = false; // Hide suggestions
    }
  }
}
