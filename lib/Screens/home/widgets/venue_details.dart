import 'package:partymap/Screens/dashboard/dashboard_controller.dart';

class VenueDetails {
  final String name;
  final String? description;
  final MarkerType? type;
  final String? imageUrl;
  final double longitude;
  final double latitude;
  final List<String>? ticketUrls;
  final List<DateTime>? times;

  VenueDetails({
    required this.name,
    this.description,
    this.type,
    this.imageUrl,
    this.longitude = 0,
    this.latitude = 0,
    this.ticketUrls,
    this.times,
  });
}
