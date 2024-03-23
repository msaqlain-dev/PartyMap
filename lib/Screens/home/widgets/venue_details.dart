class VenueDetails {
  final String name;
  final String? description;
  final String? imageUrl;
  final double longitude;
  final double latitude;
  final List<String>? ticketUrls;
  final List<DateTime>? times;

  VenueDetails({
    required this.name,
    this.description,
    this.imageUrl,
    this.longitude = 0,
    this.latitude = 0,
    this.ticketUrls,
    this.times,
  });
}
