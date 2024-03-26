import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:partymap/Screens/dashboard/dashboard_controller.dart';
import 'package:partymap/Screens/home/widgets/venue_detail_bottomsheet.dart';
import 'package:partymap/Screens/home/widgets/venue_details.dart';
import 'package:partymap/res/assets/image_assets.dart';
import 'package:partymap/res/colors/app_color.dart';
import 'package:tuple/tuple.dart';

class HomeController extends GetxController {
  MapboxMap? mapboxMap;

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  final DashboardController dashboardController =
      Get.find<DashboardController>();
  PointAnnotationManager? pointAnnotationManager;
  List<PointAnnotationOptions> options = [];

  final Rxn<VenueDetails> selectedVenue = Rxn<VenueDetails>();

  RxBool clicked = false.obs;

  RxString mapType = "Dark".obs;

  // Additional variable to store details for each annotation
  final Map<String, VenueDetails> annotationDetails = {};

  // Adjusting to store more than just VenueDetails, but also the type.
  // final Map<String, Tuple2<MarkerType, VenueDetails>> annotationDetails = {};

  // final List<VenueDetails> party = [
  //   VenueDetails(
  //     name: "Drai's Beachclub & Nightclub",
  //     description: "It's Paty",
  //     longitude: -115.17217125911195,
  //     latitude: 36.11509362417488,
  //   ),
  // ];

  // final List<VenueDetails> bar = [
  //   VenueDetails(
  //     name: 'Arc Bar',
  //     description: "It's Bar",
  //     longitude: -115.17255939774128,
  //     latitude: 36.11244019665051,
  //   ),
  // ];

  // final List<VenueDetails> restaurant = [
  //   VenueDetails(
  //     name: "Hell's Kitchen",
  //     description: "It's Restaurant",
  //     longitude: -115.17323234620663,
  //     latitude: 36.11572852007753,
  //   ),
  // ];

  @override
  void onInit() {
    super.onInit();
    // Listen to changes in selected markers and update the map accordingly
    ever(dashboardController.selectedMarkers, (_) => updateMarkers());
  }

  void updateMapType(String newMapType) {
    mapType.value = newMapType;
    update();
  }

  void updateCameraPosition(double latitude, double longitude, double zoom) {
    if (mapboxMap != null) {
      // Ensure the mapboxMap is not null
      CameraOptions cameraOptions = CameraOptions(
        center: {
          'type': 'Point',
          'coordinates': [
            longitude,
            latitude
          ], // Notice the order is [longitude, latitude]
        },
        zoom: zoom,
        pitch: 75.0,
      );

      MapAnimationOptions animationOptions = MapAnimationOptions(
        duration: 1000, // Set the animation duration to 1000 milliseconds
        startDelay: 0, // Start the animation immediately
      );

      // Use easeTo for a smooth transition, applying the camera and animation options
      mapboxMap!.easeTo(cameraOptions, animationOptions);
    }
  }

  void onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    pointAnnotationManager =
        await mapboxMap.annotations.createPointAnnotationManager();

    updateMarkers();
    setupPointAnnotationListener();
  }

  // void updateMarkers() async {
  //   final ByteData bytes = await rootBundle.load(ImageAssets.markerIconSmall);
  //   final Uint8List list = bytes.buffer.asUint8List();
  //   // List<PointAnnotationOptions> options = [];

  //   var labels = {
  //     MarkerType.parties: 'Party',
  //     MarkerType.bars: 'Bar',
  //     MarkerType.restaurants: "Hell's Kitchen",
  //   };

  //   // This is a simplification. You would have different lists for each marker type.
  //   var points = {
  //     MarkerType.parties: [
  //       Point(coordinates: Position(-115.17217125911195, 36.11509362417488))
  //           .toJson(),
  //       // Add more party points
  //     ],
  //     MarkerType.bars: [
  //       Point(coordinates: Position(-115.17255939774128, 36.11244019665051))
  //           .toJson(),
  //       // Add more bar points
  //     ],
  //     MarkerType.restaurants: [
  //       Point(coordinates: Position(-115.17323234620663, 36.11572852007753))
  //           .toJson(),
  //       // Add more restaurant points
  //     ],
  //   };

  //   var details = {
  //     MarkerType.parties: [
  //       VenueDetails(
  //         name: "Drai's Beachclub & Nightclub",
  //         description: "It's Paty",
  //       ),
  //       // Add more party points
  //     ],
  //     MarkerType.bars: [
  //       VenueDetails(
  //         name: 'Arc Bar',
  //         description: "It's Bar",
  //       ),
  //       // Add more bar points
  //     ],
  //     MarkerType.restaurants: [
  //       VenueDetails(
  //         name: "Hell's Kitchen",
  //         description: "It's Restaurant",
  //       ),
  //       // Add more restaurant points
  //     ],
  //   };

  //   // Update the markers based on selected types
  //   if (dashboardController.selectedMarkers.isNotEmpty) {
  //     for (var type in dashboardController.selectedMarkers) {
  //       for (var point in points[type] ?? []) {
  //         options.add(
  //           PointAnnotationOptions(
  //             geometry: point,
  //             image: list,
  //             textField: labels[type], // Add text label
  //             textSize: 14, // Set the size of the text (optional)
  //             textColor:
  //                 AppColor.whiteColor.value, // Set the text color (optional)
  //             textHaloColor: AppColor.primaryColor
  //                 .value, // Set the text halo color for better readability (optional)
  //             textHaloWidth: 5.0, // Set the text halo width (optional)
  //             textHaloBlur: 5.0,
  //             textOffset: [0.0, 1.5],
  //           ),
  //         );
  //       }
  //     }
  //   } else {
  //     // If no markers are selected, add all
  //     for (var typePoints in points.values) {
  //       for (var point in typePoints) {
  //         options.add(PointAnnotationOptions(geometry: point, image: list));
  //       }
  //     }
  //   }

  //   // Clear existing markers and add new ones based on selected types
  //   await pointAnnotationManager?.deleteAll();
  //   await pointAnnotationManager?.createMulti(options);
  // }

  // Important (Working)

  // void updateMarkers() async {
  //   final ByteData bytes = await rootBundle.load(ImageAssets.markerIconSmall);
  //   final Uint8List list = bytes.buffer.asUint8List();
  //   List<PointAnnotationOptions> options = [];
  //   List<String> ids = []; // Temp store for generated ids

  //   // Definitions for marker points and details should be here
  //   var points = {
  //     MarkerType.parties: [
  //       Point(coordinates: Position(-115.17217125911195, 36.11509362417488))
  //           .toJson(),
  //       // Add more party points
  //     ],
  //     MarkerType.bars: [
  //       Point(coordinates: Position(-115.17255939774128, 36.11244019665051))
  //           .toJson(),
  //       // Add more bar points
  //     ],
  //     MarkerType.restaurants: [
  //       Point(coordinates: Position(-115.17323234620663, 36.11572852007753))
  //           .toJson(),
  //       // Add more restaurant points
  //     ],
  //   };

  //   var details = {
  //     MarkerType.parties: [
  //       VenueDetails(
  //         name: "Drai's Beachclub & Nightclub",
  //         description: "It's Paty",
  //       ),
  //       // Add more party points
  //     ],
  //     MarkerType.bars: [
  //       VenueDetails(
  //         name: 'Arc Bar',
  //         description: "It's Bar",
  //       ),
  //       // Add more bar points
  //     ],
  //     MarkerType.restaurants: [
  //       VenueDetails(
  //         name: "Hell's Kitchen",
  //         description: "It's Restaurant",
  //       ),
  //       // Add more restaurant points
  //     ],
  //   };

  //   // Clear existing markers
  //   await pointAnnotationManager?.deleteAll();

  //   // Create new annotations based on the filters
  //   int counter = 0;
  //   dashboardController.selectedMarkers.forEach((type) {
  //     var typePoints = points[type] ?? [];
  //     var typeDetails = details[type] ?? [];

  //     for (int i = 0; i < typePoints.length; i++) {
  //       // var pointId = 'point_$counter';
  //       String pointId = "point_${type.toString()}_$i";
  //       counter++;

  //       options.add(
  //         PointAnnotationOptions(
  //           geometry: typePoints[i],
  //           image: list,
  //           textField: typeDetails[i].name, // Here we add the name
  //           textSize: 14, // Set the size of the text (optional)
  //           textColor:
  //               AppColor.whiteColor.value, // Set the text color (optional)
  //           textHaloColor: AppColor.primaryColor
  //               .value, // Set the text halo color for better readability (optional)
  //           textHaloWidth: 5.0, // Set the text halo width (optional)
  //           textHaloBlur: 5.0,
  //           textOffset: [0.0, 1.5],
  //         ),
  //       );

  //       // Map this point's unique ID (or geometry) to its VenueDetails
  //       String geoKey = typePoints[i]
  //           .toString(); // Convert geometry to string as unique key
  //       annotationDetails[geoKey] = typeDetails[i];

  //       // Save details for this point
  //       // annotationDetails[pointId] = typeDetails[i];
  //     }
  //   });

  //   // If no markers are selected, add all types
  //   if (dashboardController.selectedMarkers.isEmpty) {
  //     for (var type in MarkerType.values) {
  //       var typePoints = points[type] ?? [];
  //       var typeDetails = details[type] ?? [];

  //       for (int i = 0; i < typePoints.length; i++) {
  //         var pointId = 'point_${type.toString()}_$i';
  //         counter++;

  //         options.add(
  //           PointAnnotationOptions(
  //             geometry: typePoints[i],
  //             image: list,
  //             textField: typeDetails[i].name, // Here we add the name
  //             textSize: 14, // Set the size of the text (optional)
  //             textColor:
  //                 AppColor.whiteColor.value, // Set the text color (optional)
  //             textHaloColor: AppColor.primaryColor
  //                 .value, // Set the text halo color for better readability (optional)
  //             textHaloWidth: 5.0, // Set the text halo width (optional)
  //             textHaloBlur: 5.0,
  //             textOffset: [0.0, 1.5],
  //           ),
  //         );

  //         // Map this point's unique ID (or geometry) to its VenueDetails
  //         String geoKey = typePoints[i]
  //             .toString(); // Convert geometry to string as unique key
  //         annotationDetails[geoKey] = typeDetails[i];

  //         // Save details for this point
  //         // annotationDetails[pointId] = typeDetails[i];
  //       }
  //     }
  //   }

  //   // Add new markers
  //   pointAnnotationManager?.createMulti(options);
  // }

  // var points = {
  //   MarkerType.parties: [LatLng(-115.17217125911195, 36.11509362417488)],
  //   MarkerType.bars: [LatLng(-115.17255939774128, 36.11244019665051)],
  //   MarkerType.restaurants: [LatLng(-115.17323234620663, 36.11572852007753)],
  // };

  var points = {
    MarkerType.parties: [
      Point(coordinates: Position(-115.17217125911195, 36.11509362417488))
          .toJson(),
      // Add more party points
    ],
    MarkerType.bars: [
      Point(coordinates: Position(-115.17255939774128, 36.11244019665051))
          .toJson(),
      // Add more bar points
    ],
    MarkerType.restaurants: [
      Point(coordinates: Position(-115.17323234620663, 36.11572852007753))
          .toJson(),
      // Add more restaurant points
    ],
  };

  var details = {
    MarkerType.parties: [
      VenueDetails(
          name: "Drai's Beachclub & Nightclub",
          description: "It's Party Time",
          type: MarkerType.parties)
    ],
    MarkerType.bars: [
      VenueDetails(
          name: 'Arc Bar', description: "It's Bar Time", type: MarkerType.bars)
    ],
    MarkerType.restaurants: [
      VenueDetails(
          name: "Hell's Kitchen",
          description: "It's Restaurant Time",
          type: MarkerType.restaurants)
    ],
  };

  void updateMarkers() async {
    final ByteData bytes = await rootBundle.load(ImageAssets.markerIconSmall);
    final Uint8List list = bytes.buffer.asUint8List();

    // Clear existing annotations to reset the map
    await pointAnnotationManager?.deleteAll();
    annotationDetails.clear(); // Clear old annotation details

    // Iterate through all marker types
    for (MarkerType type in MarkerType.values) {
      if (dashboardController.selectedMarkers.isEmpty ||
          dashboardController.selectedMarkers.contains(type)) {
        var typePoints = points[type] ?? [];
        var typeDetails = details[type] ?? [];

        for (int i = 0; i < typePoints.length; i++) {
          // Convert your custom Point to Mapbox compatible format
          final List<dynamic> coordinates = typePoints[i][
              'coordinates']; // Assuming typePoints[i] is directly the list [longitude, latitude]

          final detail = typeDetails[i];

          // Prepare the annotation options
          final PointAnnotationOptions annotationOptions =
              PointAnnotationOptions(
            geometry: {
              'type': 'Point',
              'coordinates': [coordinates[0], coordinates[1]]
            }, // ensure [longitude, latitude] order
            image: list,
            textField:
                detail.name, // Adjust based on type, or remove if unnecessary
            textSize: 14, // Set the size of the text (optional)
            textColor:
                AppColor.whiteColor.value, // Set the text color (optional)
            textHaloColor: AppColor.primaryColor
                .value, // Set the text halo color for better readability (optional)
            textHaloWidth: 5.0, // Set the text halo width (optional)
            textHaloBlur: 5.0,
            textOffset: [0.0, 1.5],
          );

          // Create the annotation and store its ID
          try {
            final PointAnnotation? createdAnnotation =
                await pointAnnotationManager?.create(annotationOptions);
            if (createdAnnotation != null) {
              // Store the association between annotation ID and its details
              annotationDetails[createdAnnotation.id] = detail;
            }
          } catch (e) {
            print("Failed to create annotation: $e");
          }
        }
      }
    }

    // Update any necessary components that depend on annotations
  }

  // Important (Working)

  // void setupPointAnnotationListener() {
  //   var listener = MyPointAnnotationClickListener(
  //     (PointAnnotation annotation) {
  //       String geoKey = annotation.geometry.toString();
  //       VenueDetails? details = annotationDetails[geoKey];
  //       if (details != null) {
  //         selectVenue(details);
  //       } else {
  //         Positioned(
  //           child: VenueDetailBottomSheet(
  //             venueDetails: VenueDetails(
  //               name: 'Venue Name',
  //               description: 'Venue Description',
  //             ),
  //           ),
  //         );
  //       }
  //     },
  //   );

  //   pointAnnotationManager?.addOnPointAnnotationClickListener(listener);
  // }

  void setupPointAnnotationListener() {
    // Create an instance of your custom listener
    var listener = MyAnnotationClickListener(this);

    // Attach the listener to the point annotation manager
    pointAnnotationManager?.addOnPointAnnotationClickListener(listener);
  }

  void selectVenue(VenueDetails details) {
    // Update selected venue observable
    selectedVenue.value = details;

    // Show bottom sheet or update UI as necessary
    Get.bottomSheet(
      VenueDetailBottomSheet(venueDetails: details),
      isScrollControlled: true,
    );
  }

  // void selectVenue(VenueDetails details) {
  //   selectedVenue.value = details; // This should trigger the UI to update
  // }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}

// class MyPointAnnotationClickListener implements OnPointAnnotationClickListener {
//   final void Function(PointAnnotation) callback;

//   MyPointAnnotationClickListener(this.callback);

//   final HomeController controller = Get.find<HomeController>();

//   // @override
//   // void onPointAnnotationClick(PointAnnotation annotation) {
//   //   callback(annotation);
//   // }
//   @override
//   void onPointAnnotationClick(PointAnnotation annotation) {
//     print("Annotation clicked: ${annotation.id}");
//     controller.clicked.value = true;
//     callback(annotation);
//   }
// }

class MyAnnotationClickListener implements OnPointAnnotationClickListener {
  final HomeController controller;

  MyAnnotationClickListener(this.controller);

  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    // Retrieve the associated details using the ID from your controller's annotationDetails
    VenueDetails? details = controller.annotationDetails[annotation.id];

    // Perform actions based on the annotation type
    if (details != null && details.type == MarkerType.parties) {
      // For party markers, show bottom sheet with details
      controller.selectVenue(details);
    } else {
      // Handle other types of markers
      print("Clicked on a non-party marker: ${details?.name}");
    }
  }
}
